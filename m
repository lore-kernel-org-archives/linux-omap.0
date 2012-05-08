From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
Date: Tue, 08 May 2012 12:54:13 +0530
Message-ID: <4FA8CA1D.6060105@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com> <4FA79AAB.5050503@ti.com> <20120507222635.GO5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:46006 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755386Ab2EHHYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 03:24:20 -0400
Received: by obbup19 with SMTP id up19so5818402obb.24
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 00:24:19 -0700 (PDT)
In-Reply-To: <20120507222635.GO5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com

On Tuesday 08 May 2012 03:56 AM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [120507 02:53]:
>> Tony,
>>
>> On Thursday 03 May 2012 12:56 PM, R Sricharan wrote:
>>> The series adds minimal OMAP5 support.
>>> OMAP5430 has a dual core Cortex-A15 based MPU subsystem with 2MB
>>> L2 cache. The SOC has many compatible blocks with OMAP4 SOCS and
>>> hence large part of the peripherals are re-used.
>>>
>>> OMAP5432 is another variant of OMAP5430, with a
>>> memory controller supporting DDR3 and SATA.
>>>
>>> Series is generated against the 3.4-rc5. This has been rebased on
>>> top of the OMAP2+ cleanup series [1]
>>>
>>> To get the boot working with omap2plus_defconfig,
>>> OMAP5 hwmod/clock/prm/cm database needs to be added.
>>> The data and the integrated tree are available in the
>>> below git repository
>>>
>>> OMAP5_DATA:
>>> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
>>>  omap5_data
>>>
>>> OMAP5_INTEGRATED:
>>> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
>>>  omap5_dt_integrated
>>>
>>> The series is boot tested on OMAP5430 ES1.0.
>>> OMAP2/3/4 build and boot is tested as well to avoid any breakage
>>> because of the series.
>>>
>>> Patch "TEMP: ARM: OMAP5: Add cpu_is_omap54xx() checks" is temporary and
>>> can be dropped once rebased against [2]
>>>
>>> Patch "TEMP: ARM: OMAP5: Update the base address of the 32k-counter" is
>>> temporary and can be dropped once rebased against [3]
>>>
>>>
>>> [1] http://www.spinics.net/lists/linux-omap/msg69233.html
>>> [2] http://www.spinics.net/lists/linux-omap/msg69013.html
>>> [3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67166.html
>>>
>> Do you have a branch where above dependencies are merged ?
> 
> Seems like those should go into the cleanup branch, and then
> that can be used as a base.
>
Yep. That will be a good base.

>> How do you suggest to go about updating this series so
>> that above dependencies plus DT support(3.3 based branch
>> in arm-soc tree and needs to be updated against 3.4) is
>> base tree for the patchset.
> 
> Probably the DT patch should be separate, we can make dt branch
> depend on the cleanup branch.
> 
Sounds good. Btw, who is re-basing the omap-dt branch against 3.4 ?

> Then the data files should be first posted for reviews (and potentially
> updated for what we have queued in hwmod-cleanup).  Does this series
> compile on it's own without the data now?
> 
This series does compile on it's own without data patches. Data
patches needs to re-based against Paul's clean-up and also we
need to sort out ES1/ES2 diff so they can wait till then.
Probably 3.6+

This series was intentionally made in such a way that it can
be merged without data patches. Just for getting boot working
on OMAP5 data patches needs to be merged.

Regards
Santosh


