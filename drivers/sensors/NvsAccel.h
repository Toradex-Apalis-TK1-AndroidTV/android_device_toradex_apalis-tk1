/* Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#ifndef NVS_ACCEL_H
#define NVS_ACCEL_H

#include "Nvs.h"


class NvsAccel: public Nvs {

public:
    NvsAccel(int devNum, Nvs *link = NULL);
    virtual ~NvsAccel();
};

#endif /* NVS_ACCEL_H */

