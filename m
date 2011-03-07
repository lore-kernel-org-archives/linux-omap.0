From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 6/7] omap3430: Updating the board file to use TWL4030 scripts
Date: Mon, 07 Mar 2011 11:42:16 -0800
Message-ID: <87sjuy67l3.fsf@ti.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
	<1299072653-13414-7-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:40644 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755820Ab1CGTmV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 14:42:21 -0500
Received: by mail-yx0-f171.google.com with SMTP id 35so2138618yxh.16
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 11:42:20 -0800 (PST)
In-Reply-To: <1299072653-13414-7-git-send-email-leslyam@ti.com> (Lesly A. M.'s
	message of "Wed, 2 Mar 2011 19:00:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> Using TWL4030 power scripts to control the LDOs and DCDC regulators
> while going to low power mode.
>
> Signed-off-by: Lesly A M <leslyam@ti.com>

Minor: Re: Subject: OMAP is an acronym, please capitalize.

> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  arch/arm/mach-omap2/Makefile        |    3 +-
>  arch/arm/mach-omap2/board-3430sdp.c |   93 +----------------------------------
>  2 files changed, 4 insertions(+), 92 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 742ca67..bb11329 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -175,7 +175,8 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
>  					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
>  					   hsmmc.o \
> -					   board-flash.o
> +					   board-flash.o \
> +					   twl4030.o

This should not be board-specific in the Makefile, otherwise it will
have to be added for every single board that uses it.

Rather, it should probably be built as long as CONFIG_TWL4030_POWER=y.
Also, please be sure to build test when that option is disabled as well.

Kevin
