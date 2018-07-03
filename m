From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: remove dead code
Date: Tue, 3 Jul 2018 10:40:25 +0530
Message-ID: <8e1b81d0-2ae4-90aa-b079-7bc778a2f015@ti.com>
References: <10747698.EAsn0e6Ddm@amdc3058>
 <CGME20180629161027eucas1p20846507c4f98f50d80ab58aaa1628fd1@eucas1p2.samsung.com>
 <3318201.BAqn4C3t6k@amdc3058> <20180702163010.GA2380@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702163010.GA2380@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Monday 02 July 2018 10:00 PM, Eduardo Valentin wrote:
> Keerthy,
> 
> On Fri, Jun 29, 2018 at 06:10:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>
>> Hi,
>>
>> On Wednesday, May 02, 2018 03:20:35 PM Bartlomiej Zolnierkiewicz wrote:
>>> Majority of this code (i.e. functions from ti-bandgap.c) has been
>>> introduced in May 2013 by commit eb982001dbd8 ("thermal: introduce TI
>>> SoC thermal driver"). Just remove it altogether (in case it is needed
>>> it can be easily resurrected from git repo).
>>>
>>> While at it fix incorrect "not used" comments.
>>>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> ---
>>>  drivers/thermal/ti-soc-thermal/dra752-bandgap.h      |   68 ---
>>>  drivers/thermal/ti-soc-thermal/dra752-thermal-data.c |   65 ---
>>>  drivers/thermal/ti-soc-thermal/omap3-thermal-data.c  |    6 
>>>  drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |   10 
>>>  drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h    |   10 
>>>  drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |   46 --
>>>  drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h    |   41 --
>>>  drivers/thermal/ti-soc-thermal/ti-bandgap.c          |  370 -------------------
>>>  drivers/thermal/ti-soc-thermal/ti-bandgap.h          |   43 --
>>>  9 files changed, 5 insertions(+), 654 deletions(-)
>>
>> Gentle ping.
>>
>> It would be great to see this patch in v4.19.
> 
> Any objections on this removal / cleanup?

Tested the patch on dra72-EVM.
cpufreq cooling works well.

Tested-by: Keerthy <j-keerthy@ti.com>
Acked-by: Keerthy <j-keerthy@ti.com>

Thanks for the clean up Bartalomiej!
> 
