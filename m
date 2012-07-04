From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V3 1/3] ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses
 omap-device.o target so add one entry
Date: Wed, 4 Jul 2012 00:27:58 -0700
Message-ID: <20120704072758.GP1122@atomide.com>
References: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
 <1340895567-22766-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64396 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961Ab2GDH2A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 03:28:00 -0400
Content-Disposition: inline
In-Reply-To: <1340895567-22766-2-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi

Applying these, but few comments below to make my life easier..

* Vaibhav Hiremath <hvaibhav@ti.com> [120628 08:04]:
> All OMAP2PLUS based devices, builds omap-device.o target;
> so just add one entry so that there is no need to patch this file
> for any future OMAP2+ devices.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> 
> NOTE: No code change from last version.

Extra comments like this should be within the --- sections so they
down't show up when applying the patch. Otherwise I have to manually
edit every patch, which sucks.

Then, I'm leaving out the CLEANUP part in $Subject, that alone is not
a reason to patch anything. The description should say why the patch
is needed, which it does. If you want to specify that this should be
grouped in the clean-up branch, then that too could be mentioned within
the --- sections.

> ---
>  arch/arm/plat-omap/Makefile |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 6d87532..961bf85 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -10,9 +10,7 @@ obj-n :=
>  obj-  :=
> 
>  # omap_device support (OMAP2+ only at the moment)
> -obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
> -obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
> -obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
> +obj-$(CONFIG_ARCH_OMAP2PLUS) += omap_device.o
> 
>  obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
>  obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
> --
> 1.7.0.4
> 

This patch did not apply for some reason, I got:

patching file arch/arm/plat-omap/Makefile
patch: **** malformed patch at line 73: 1.7.0.4

So please tune up your scripts a bit to the patches can be applied
as they are without manual editing ;)

Thanks,

Tony
