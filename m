From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config
 option
Date: Sat, 25 Jul 2009 08:23:59 +0300 (EEST)
Message-ID: <20090725.082359.115933413.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD56@dlee03.ent.ti.com>
	<20090724.210005.226780464.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E3A941DDF@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63199 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbZGYFYL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jul 2009 01:24:11 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3A941DDF@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, ameya.palande@nokia.com, x0095840@ti.com, omar.ramirez@ti.com

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config option
Date: Sat, 25 Jul 2009 02:43:41 +0200

> Hiroshi,
> 
> > The problem here is that now all TRACEBUF code is always compiled in
> > in spite of setting "DEBUG". It doesn't print anything, but just
> > wastes some memory
> 
> That's not true. DSP_TRACEBUF is used to print the traces from DSP. This is used by Socket node developers to print their traces from DSP to console.
> If you enable DT=1 GT trace, then you get all the prints from DSP, which is extremely useful for DSP Developers.

I understand that DSP_TRACEBUF is useful. But now DSP_TRACEBUF is
always complied in and it cannot print anything without defining
GT_TRACE, IOW, without defining CONFIG_DSP_DEBUG. This is the matter of
dependency of those DEFINEs, DSP_TRACEBUF and DEBUG. Kconfig can describe
those dependency. I am proposing to set the dependency of DSP_TRACEBUF
on CONFIG_DSP_DEBUG, to save some memory instead of keeping unused
code(ex: PrintDSPDebugTrace()) in this driver.

Without defining "GT_TRACE", "DSP_TRACEBUF" won't print anything
because "PrintDSPDebugTrace()" uses GT_0trace to print and GT_?trace()
is set as below,

	arch/arm/plat-omap/include/dspbridge/gt.h:
	...
	#ifndef GT_TRACE
	#define GT_TRACE 0	    /* 0 = "trace compiled out"; 1 = "trace active" */
	#endif
	...
	#if GT_TRACE == 0
	...
	#define GT_0trace(mask, class, format) do {} while (0)
	#define GT_1trace(mask, class, format, arg1) do {} while (0)
	...


And "GT_TRACE" depends on "CONFIG_BRIDGE_DEBUG" as below,

	drivers/dsp/bridge/Kbuild:
	...
	ifeq ($(CONFIG_BRIDGE_DEBUG),y)
	ccflags-y += -DGT_TRACE -DDEBUG
	endif
	...
