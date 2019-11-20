From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 00/15] Remoteproc: updates for OMAP remoteproc support
Date: Wed, 20 Nov 2019 13:28:06 +0200
Message-ID: <46a3bfb0-6bf1-b3d9-14a6-d2ed5b91c930@ti.com>
References: <20191119141645.19777-1-t-kristo@ti.com>
 <CANLsYkwyLMHzKkm-6X+OgQ+khRYJshMJsxdst7+c7n+hX4nLpQ@mail.gmail.com>
 <CANLsYkwcWDOPx_rpL5RkzsNLyw+ccPE0bNhar6xv1SZ1=R5xmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANLsYkwcWDOPx_rpL5RkzsNLyw+ccPE0bNhar6xv1SZ1=R5xmA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

On 19/11/2019 20:07, Mathieu Poirier wrote:
> On Tue, 19 Nov 2019 at 10:31, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>>
>> On Tue, 19 Nov 2019 at 07:17, Tero Kristo <t-kristo@ti.com> wrote:
>>>
>>> Hi,
>>>
>>> This is v2 of the series [1], addressing comments from Bjorn and Rob.
>>> Bindings patch is funnily v2.5, as I posted v2 already and wanted to
>>> keep this somehow in sync. Individual patches contain comments about the
>>> changes, or Reviewed-by tags provided if there are no changes.
>>>
>>> I also dropped the conversion patch to SPDX licensing until I can
>>> confirm the license we want to use. Lets just keep the existing in place
>>> until that.
>>>
>>> This series still depends on the reset + clock patches posted earlier,
>>> but both of those dependencies are in linux-next now.
>>
>> I tried to apply your set to today's linux-next (next-20191119) but it
>> fails at patch 13.
> 
> Digging further into this patch 12 is causing problem on next-20191119 (not 13):
> 
> mpoirier@xps15:~/work/remoteproc/kernel-review$ git apply --reject
> 0012-remoteproc-omap-add-support-for-system-suspend-resum.patch
> Checking patch drivers/remoteproc/omap_remoteproc.c...
> Hunk #3 succeeded at 85 (offset -1 lines).
> Hunk #4 succeeded at 99 (offset -1 lines).
> Hunk #5 succeeded at 359 (offset -1 lines).
> Hunk #6 succeeded at 544 (offset -1 lines).
> Hunk #7 succeeded at 952 (offset -1 lines).
> Hunk #8 succeeded at 992 (offset -2 lines).
> Checking patch drivers/remoteproc/omap_remoteproc.h...
> error: while searching for:
> /*
>   * Remote processor messaging
>   *
>   * Copyright (C) 2011 Texas Instruments, Inc.
>   * Copyright (C) 2011 Google, Inc.
>   * All rights reserved.
>   */
> 
> error: patch failed: drivers/remoteproc/omap_remoteproc.h:2
> Hunk #2 succeeded at 57 (offset 25 lines).
> Hunk #3 succeeded at 80 (offset 25 lines).
> Applied patch drivers/remoteproc/omap_remoteproc.c cleanly.
> Applying patch drivers/remoteproc/omap_remoteproc.h with 1 reject...
> Rejected hunk #1.
> Hunk #2 applied cleanly.
> Hunk #3 applied cleanly.
> 
> Your patch expects the last line of the first hunk to be '*/' but it
> is '*' in linux-next.

Hmm right, this seems my bad. This is caused by me dropping the SPDX 
license conversion patch from the series, if that is applied, it goes 
cleanly.

Simple rebase of patch 12 is going to fix that though.

-Tero

> 
>>
>> Mathieu
>>
>>>
>>> -Tero
>>>
>>> [1] https://patchwork.kernel.org/cover/11215421/
>>>
>>>
>>>
>>> --

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
