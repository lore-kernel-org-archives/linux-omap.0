From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 0/3] TI-SoC-thermal: Fine-tuning for two functions
Date: Tue, 2 May 2017 10:25:41 +0530
Message-ID: <d87115f9-db8f-d2af-c03e-019004d9b9ac@ti.com>
References: <cd524803-b771-c3d2-8906-ee78576c86d4@users.sourceforge.net>
 <20170427162047.GA18276@localhost.localdomain>
 <5fa2705e-3082-29b0-b174-cc478cd66e75@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <5fa2705e-3082-29b0-b174-cc478cd66e75@ti.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Monday 01 May 2017 10:50 AM, Keerthy wrote:
> 
> 
> On Thursday 27 April 2017 09:50 PM, Eduardo Valentin wrote:
>> On Wed, Apr 26, 2017 at 05:33:10PM +0200, SF Markus Elfring wrote:
>>> From: Markus Elfring <elfring@users.sourceforge.net>
>>> Date: Wed, 26 Apr 2017 17:24:56 +0200
>>>
>>> Three update suggestions were taken into account
>>> from static source code analysis.
>>>
>>> Markus Elfring (3):
>>>   Use devm_kcalloc() in ti_bandgap_build()
>>>   Delete error messages for failed memory allocations in ti_bandgap_build()
>>>   Fix a typo in a comment line
>>>
>>
>> Keerthy,
>>
>> Can you please give it a shot of this series on all supported OMAP chip
>> boards? I do not see any major issue with the series at all, but would
>> like to get it tested by you.
> 
> Sure Eduardo. I will test and review this series.

Tested for Temperatures of all the sensors and thermal shutdown
triggering using emul_temp on DRA7/DRA72 AM57xx-evm boards.


For the series:

Acked-by: Keerthy <j-keerthy@ti.com>
Tested-by: Keerthy <j-keerthy@ti.com>

- Keerthy

> 
>>
>> BR,
>>
>>>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 14 +++++---------
>>>  1 file changed, 5 insertions(+), 9 deletions(-)
>>>
>>> -- 
>>> 2.12.2
>>>
