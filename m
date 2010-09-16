From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] OMAP2/TWL: Fix Sparse warnings
Date: Thu, 16 Sep 2010 12:34:25 -0700
Message-ID: <20100916193425.GM29610@atomide.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65312 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab0IPTea (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 15:34:30 -0400
Content-Disposition: inline
In-Reply-To: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

* G, Manjunath Kondaiah <manjugk@ti.com> [100826 13:50]:
> This patch series fixes sparse warnings for OMAP and TWL code.
> For better readabilty the patches are categorised based on type of
> sparse warnigns.
> 
> The sparse warning logs are embedded with each patch followed
> by fix.
> 
> Build and boot tested on omap3 with omap3_defconfig.
> 
> Manjunatha GK (11):
>   OMAP: mach-omap2: Fix incorrect assignment warnings
>   OMAP: mach-omap2: Fix static declaration warnings
>   OMAP: mach-omap2: Fix static function warnings
>   OMAP: mach-omap2: Fix miscellaneous sparse warnings
>   OMAP: plat-omap: Fix static function warnings
>   OMAP: McBSP: Fix static function warning
>   OMAP: HSMMC: Fix unused variable warning
>   OMAP: NAND: Fix static declaration warning
>   TWL CORE: Fix sparse warning
>   TWL IRQ: Fix fucntion declaration warnings
>   TWL4030: Codec: Fix fucntion declaration error

Looks like these are almost ready to go. Please repost against
v2.6.36-rc4 with linux-arm-kernel list Cc'd. Also check that
the related driver list is Cc'd.

Then, assuming no more comments, can you set up a git
branch somewhere for me to pull? For more info, see
"Merging patches using git" at:

http://www.elinux.org/OMAP_patch_merging_process#Patch_submission_checklist

Regards,

Tony
