From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 02/17] remoteproc/omap: Switch to SPDX license identifiers
Date: Tue, 12 Nov 2019 10:16:13 +0200
Message-ID: <bed42f27-3a67-bfa7-fdcc-bf333233828f@ti.com>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-3-t-kristo@ti.com> <20191109010348.GB5662@tuxbook-pro>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191109010348.GB5662@tuxbook-pro>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com
List-Id: linux-omap@vger.kernel.org

On 09/11/2019 03:03, Bjorn Andersson wrote:
> On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:
> 
>> From: Suman Anna <s-anna@ti.com>
>>
>> Use the appropriate SPDX license identifiers in various OMAP remoteproc
>> source files and drop the previous boilerplate license text.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/remoteproc/omap_remoteproc.h | 27 +--------------------------
>>   1 file changed, 1 insertion(+), 26 deletions(-)
>>
>> diff --git a/drivers/remoteproc/omap_remoteproc.h b/drivers/remoteproc/omap_remoteproc.h
>> index f6d2036d383d..1e6fef753c4f 100644
>> --- a/drivers/remoteproc/omap_remoteproc.h
>> +++ b/drivers/remoteproc/omap_remoteproc.h
>> @@ -1,35 +1,10 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> 
> Please confirm that you actually intend to change the license from BSD
> to dual here.

That is a very good point. Let me try to get clarification to this 
internally, this series is anyways too late for 5.5 so there is no rush 
to get this done anytime soon. Worst case I just drop this patch and 
keep the existing license in place.

-Tero

> 
> Regards,
> Bjorn
> 
>>   /*
>>    * Remote processor messaging
>>    *
>>    * Copyright (C) 2011 Texas Instruments, Inc.
>>    * Copyright (C) 2011 Google, Inc.
>>    * All rights reserved.
>> - *
>> - * Redistribution and use in source and binary forms, with or without
>> - * modification, are permitted provided that the following conditions
>> - * are met:
>> - *
>> - * * Redistributions of source code must retain the above copyright
>> - *   notice, this list of conditions and the following disclaimer.
>> - * * Redistributions in binary form must reproduce the above copyright
>> - *   notice, this list of conditions and the following disclaimer in
>> - *   the documentation and/or other materials provided with the
>> - *   distribution.
>> - * * Neither the name Texas Instruments nor the names of its
>> - *   contributors may be used to endorse or promote products derived
>> - *   from this software without specific prior written permission.
>> - *
>> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
>> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
>> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
>> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
>> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>    */
>>   
>>   #ifndef _OMAP_RPMSG_H
>> -- 
>> 2.17.1
>>
>> --

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
