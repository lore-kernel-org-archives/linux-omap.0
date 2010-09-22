From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCHv3 0/17] OMAP dmtimer hwmod
Date: Thu, 23 Sep 2010 00:31:22 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D70A@dbde02.ent.ti.com>
References: <1285059029-26291-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43417 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117Ab0IVTB1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 15:01:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8MJ1OTC008855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 22 Sep 2010 14:01:27 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o8MJ1Orx023662
	for <linux-omap@vger.kernel.org>; Thu, 23 Sep 2010 00:31:24 +0530 (IST)
In-Reply-To: <1285059029-26291-1-git-send-email-tarun.kanti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Here is checkpatch and sparse warnings for this series:

$./scripts/checkpatch.pl --strict timer_patches/*.patch
CHECK: multiple assignments should be avoided
#182: FILE: arch/arm/mach-omap1/dmtimer.c:127:
+		res[1].start = res[1].end = irq;

total: 0 errors, 0 warnings, 1 checks, 267 lines checked

timer_patches/PATCHv3-10-17-OMAP1-dmtimer-conversion-to-platform-devices.patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.


Sparse Warnings:
arch/arm/plat-omap/dmtimer.c: In function 'omap_dm_timer_reset':
arch/arm/plat-omap/dmtimer.c:152: warning: unused variable 'l'
include/trace/events/module.h:94:1: error: cannot size expression
kernel/module.c:149:6: error: symbol '__module_put_and_exit' redeclared with different type (originally declared at include/linux/module.h:460) - different modifiers
arch/arm/mach-omap2/timer-gp.c:50:22: warning: symbol 'gptimer_wakeup' was not declared. Should it be static?
arch/arm/mach-omap2/timer-gp.c:115:12: warning: symbol 'omap2_gp_clockevent_set_gptimer' was not declared. Should it be static?
arch/arm/mach-omap2/timer-gp.c:239:18: warning: symbol 'omap_timer' was not declared. Should it be static?
kernel/trace/trace.c:3971:15: warning: symbol 'tracing_dentry_percpu' was not declared. Should it be static?
kernel/trace/trace.c:915:9: warning: memset with byte count of 131076
arch/arm/mach-omap2/dmtimer.c:80:31: warning: symbol 'omap2_dmtimer_latency' was not declared. Should it be static?
arch/arm/mach-omap2/dmtimer.c:270:13: warning: symbol 'omap2_dm_timer_early_init' was not declared. Should it be static?
arch/arm/mach-omap2/pm-debug.c:170:15: warning: symbol 'pm_dbg_dir' was not declared. Should it be static?
WARNING: modpost: Found 7 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y

-Manjunath  

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tarun 
> Kanti DebBarma
> Sent: Tuesday, September 21, 2010 2:20 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCHv3 0/17] OMAP dmtimer hwmod
> 
> This patch series implements dmtimer hwmod.
> 
> Version 3
> *********
> (1) multi-line comment error correction
> 
> (2) provision to allow any of the available dmtimers as early 
> timers instead of restricting them to millisecond timers only. 
> 
> (3) in 'struct omap_dmtimer{}' is_initialized flag is 
> redundant and so must be removed. if the element is found in 
> the list it is already initialized.
> 
> (4) remove 'found' flag in omap_dm_timer_request() and
> omap_dm_timer_request_specific() functions.
> this is not needed with alternate implementation.
> 
> (5) use .init_name to initialize device names so that it can 
> be identified during early boot as well. This is to avoid 
> duplicate functions for clock manipulations during early boot 
> and later.
> 
> (6) remove redundant functions from mach-omap2 which are 
> created just to call pm functions like: 
> pm_runtime_get_sync(),pm_runtime_put_sync(),..
> and instead call them directly from plat-omap function api's.
> 
> (7) timer clock source names made part of hwmod database. 
> source_clock[] of type 'struct clk' is made part of platform data.
> 
> (8) clockactivity field initialized in hwmod database to 
> preserve fclk during idle. code which manipulate OCP config 
> removed since they are already taken care by hwmod framework.
> 
> (9) omap2_dm_timer_set_src() is optimized. Clock 
> enable/disbale routines moved to plat-omap layer and 
> simplfied to the level so as not to sacrifice intended functionality.
> 
> NOTE: During early boot clock management was requested to be 
> placed upon client drivers responsibility. this has not been 
> done keeping in mind that it would entail (i) multiple 
> modifications of client drivers (ii) it would violate the 
> purpose of having a framework (open to debate).
> 
> (10) dmtimer register maps moved to hwmod database
> 
> Baseline
> ********
> origin/pm-core
> 
> Test info
> *********
> OMAP4430SDP
> OMAP3630SDP
> OMAP3430SDP
> OMAP2430SDP
> OMAP1710SDP(Bootup)
> 
> 
> Tarun Kanti DebBarma (17):
>   OMAP2/3/4:dmtimer:add device names to flck nodes
>   dmtimer: infrastructure to support hwmod
>   dmtimer: add omap2420 hwmod database
>   dmtimer: add omap2430 hwmod database
>   dmtimer: add omap3xxx hwmod database
>   dmtimer: add omap44xx hwmod database
>   dmtimer: use list instead of static array
>   dmtimer: register mappings moved to hwmod database
>   OMAP: dmtimer platform driver
>   OMAP1: dmtimer conversion to platform devices
>   dmtimer: early boot infrastructure
>   OMAP2/3/4: dmtimers: convert to platform devices
>   dmtimer: switch-over to platform device driver with hwmod
>   dmtimer pm_runtime support
>   dmtimer: OMAP4 specific change in plat-omap
>   dmtimer: clean redundant code
>   dmtimer: remove OCP config code from plat-omap
> 
>  arch/arm/mach-omap1/Makefile               |    2 +-
>  arch/arm/mach-omap1/dmtimer.c              |  174 ++++++
>  arch/arm/mach-omap2/Makefile               |    2 +-
>  arch/arm/mach-omap2/clock2420_data.c       |   24 +-
>  arch/arm/mach-omap2/clock2430_data.c       |   24 +-
>  arch/arm/mach-omap2/clock3xxx_data.c       |   24 +-
>  arch/arm/mach-omap2/clock44xx_data.c       |   22 +-
>  arch/arm/mach-omap2/dmtimer.c              |  288 ++++++++++
>  arch/arm/mach-omap2/dmtimer.h              |   25 +
>  arch/arm/mach-omap2/io.c                   |    2 +
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  739 
> +++++++++++++++++++++++++  
> arch/arm/mach-omap2/omap_hwmod_2430_data.c |  737 
> +++++++++++++++++++++++++  
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  815 
> ++++++++++++++++++++++++++++  
> arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  796 
> +++++++++++++++++++++++++++
>  arch/arm/mach-omap2/timer-gp.c             |    1 -
>  arch/arm/plat-omap/dmtimer.c               |  679 
> +++++++++++------------
>  arch/arm/plat-omap/include/plat/dmtimer.h  |   80 +++
>  17 files changed, 4030 insertions(+), 404 deletions(-)  
> create mode 100644 arch/arm/mach-omap1/dmtimer.c  create mode 
> 100644 arch/arm/mach-omap2/dmtimer.c  create mode 100644 
> arch/arm/mach-omap2/dmtimer.h
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 