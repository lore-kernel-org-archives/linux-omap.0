From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Added craneboard support 1/1] Added-craneboard-basic-support
Date: Fri, 15 Oct 2010 08:49:37 -0700
Message-ID: <20101015154937.GO18869@atomide.com>
References: <1287138432-23880-1-git-send-email-srinath@mistralsolutions.com>
 <1287138432-23880-2-git-send-email-srinath@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56332 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013Ab0JOPtk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Oct 2010 11:49:40 -0400
Content-Disposition: inline
In-Reply-To: <1287138432-23880-2-git-send-email-srinath@mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: srinath@mistralsolutions.com
Cc: linux-omap@vger.kernel.org, jdk@ti.com, nagendra@mistralsolutions.com, umeshk@mistralsolutions.com

* srinath@mistralsolutions.com <srinath@mistralsolutions.com> [101015 03:30]:
> From: Srinath <srinath@mistralsolutions.com>
> 
> 
> Signed-off-by: Srinath <srinath@mistralsolutions.com>
> ---
>  arch/arm/configs/omap2plus_defconfig    |    1 +
>  arch/arm/mach-omap2/Kconfig             |    6 +++
>  arch/arm/mach-omap2/Makefile            |    2 +
>  arch/arm/mach-omap2/board-am3517crane.c |   68 +++++++++++++++++++++++++++++++
>  4 files changed, 77 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-am3517crane.c

Looks like you're missing the entry in uncompress.h for the uart?

To low-level debug, enable CONFIG_DEBUG_LL and CONFIG_EARLY_PRINTK,
then have earlyprintk in your kernel cmdline.

Regards,

Tony
