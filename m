From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
Date: Mon, 07 May 2012 15:19:31 +0530
Message-ID: <4FA79AAB.5050503@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:48293 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755668Ab2EGJth (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 05:49:37 -0400
Received: by obcni5 with SMTP id ni5so9924773obc.41
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 02:49:36 -0700 (PDT)
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com

Tony,

On Thursday 03 May 2012 12:56 PM, R Sricharan wrote:
> The series adds minimal OMAP5 support.
> OMAP5430 has a dual core Cortex-A15 based MPU subsystem with 2MB
> L2 cache. The SOC has many compatible blocks with OMAP4 SOCS and
> hence large part of the peripherals are re-used.
> 
> OMAP5432 is another variant of OMAP5430, with a
> memory controller supporting DDR3 and SATA.
> 
> Series is generated against the 3.4-rc5. This has been rebased on
> top of the OMAP2+ cleanup series [1]
> 
> To get the boot working with omap2plus_defconfig,
> OMAP5 hwmod/clock/prm/cm database needs to be added.
> The data and the integrated tree are available in the
> below git repository
> 
> OMAP5_DATA:
> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
>  omap5_data
> 
> OMAP5_INTEGRATED:
> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
>  omap5_dt_integrated
> 
> The series is boot tested on OMAP5430 ES1.0.
> OMAP2/3/4 build and boot is tested as well to avoid any breakage
> because of the series.
> 
> Patch "TEMP: ARM: OMAP5: Add cpu_is_omap54xx() checks" is temporary and
> can be dropped once rebased against [2]
> 
> Patch "TEMP: ARM: OMAP5: Update the base address of the 32k-counter" is
> temporary and can be dropped once rebased against [3]
> 
> 
> [1] http://www.spinics.net/lists/linux-omap/msg69233.html
> [2] http://www.spinics.net/lists/linux-omap/msg69013.html
> [3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67166.html
> 
Do you have a branch where above dependencies are merged ?
How do you suggest to go about updating this series so
that above dependencies plus DT support(3.3 based branch
in arm-soc tree and needs to be updated against 3.4) is
base tree for the patchset.

Regards
Santosh


