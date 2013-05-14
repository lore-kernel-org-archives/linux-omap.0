From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] arm: configs: omap2plus_defconfig: enable USB bits which work
Date: Tue, 14 May 2013 07:09:08 -0700
Message-ID: <87ip2ly7p7.fsf@linaro.org>
References: <1368494600-18953-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:59377 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab3ENOJM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 May 2013 10:09:12 -0400
Received: by mail-pd0-f172.google.com with SMTP id 6so460692pdd.31
        for <linux-omap@vger.kernel.org>; Tue, 14 May 2013 07:09:12 -0700 (PDT)
In-Reply-To: <1368494600-18953-1-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Tue, 14 May 2013 04:23:20 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, kevin.hilman@linaro.org, Roger Quadros <rogerq@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe Balbi <balbi@ti.com> writes:

> those USB bits work fine, so we can enable them
> safely. Plus, without USB_PHY EHCI wouldn't work
> and it would take quite a few bogus error reports
> until all users got the new changes.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>
> comiple tested only. Would be great to have someone
> testing on actual HW. Right now I don't have access
> to my HW.
>
> cheers
>
>  arch/arm/configs/omap2plus_defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index c1ef64b..a1fc0ca 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -74,6 +74,7 @@ CONFIG_CMA=y
>  CONFIG_CONNECTOR=y
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_OMAP_OCP2SCP=y
>  CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_CHAR=y
> @@ -206,10 +207,18 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_DEVICEFS=y
>  CONFIG_USB_SUSPEND=y
>  CONFIG_USB_MON=y
> +CONFIG_USB_EHCI_HCD=y

NAK (on this particular change)

This cannot be enable by default yet as EHCI *still* breaks core
retention[1] (which has been broken since at least v3.5, almost a year
now.)

>  CONFIG_USB_WDM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_LIBUSUAL=y
> +CONFIG_USB_DWC3=m
> +CONFIG_USB_DWC3_DEBUG=y
> +CONFIG_USB_DWC3_VERBOSE=y
>  CONFIG_USB_TEST=y
> +CONFIG_USB_PHY=y
> +CONFIG_NOP_USB_XCEIV=y

These two are needed though since before v3.10, they used to be
selected, and without them USB host doesn't work on Panda anymore.

> +CONFIG_OMAP_USB2=y
> +CONFIG_OMAP_USB3=y

I guess these are for OMAP5?  The changelog should probably describe
which bits are for which platforms for those of us not intimate with
USB.

>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DEBUG=y
>  CONFIG_USB_GADGET_DEBUG_FILES=y

Kevin

[1]
commit 06b4ba529528fbf9c24ce37b7618f4b0264750e2
Author: Kevin Hilman <khilman@ti.com>
Date:   Fri Jul 6 11:20:28 2012 -0700

    ARM: OMAP2+: omap2plus_defconfig: EHCI driver is not stable, disable it
    
    The EHCI driver is not stable enough to be enabled by default.  In v3.5,
    it has at least the following problems:
    
    - warning dump during bootup
    - hang during suspend
    - prevents CORE powerdomain from entering retention during idle (even
      when no USB devices connected.)
    
    This demonstrates that this driver has not been thoroughly tested and
    therfore should not be enabled in the default defconfig.
    
    In addition, the problems above cause new PM regressions which need be
    addressed before this driver should be enabled in the default
    defconfig.
    
    Signed-off-by: Kevin Hilman <khilman@ti.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>


