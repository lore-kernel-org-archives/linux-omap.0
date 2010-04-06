From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] omap: select ARCH_OMAP_OTG for OMAP2430
Date: Tue, 6 Apr 2010 09:48:47 +0300
Message-ID: <20100406064847.GS16297@nokia.com>
References: <70376CA23424B34D86F1C7DE6B9973430254343A3C@VSHINMSMBX01.vshodc.lntinfotech.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59350 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757255Ab0DFGuc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 02:50:32 -0400
Content-Disposition: inline
In-Reply-To: <70376CA23424B34D86F1C7DE6B9973430254343A3C@VSHINMSMBX01.vshodc.lntinfotech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Viral Mehta <Viral.Mehta@lntinfotech.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Apr 06, 2010 at 08:26:30AM +0200, ext Viral Mehta wrote:
>Configuration for OMAP2430 should select ARCH_OMAP_OTG just like
>it is done for OMAP2420
>
>Signed-off-by: Viral Mehta <viral.mehta@lntinfotech.com>

and this

>---
> arch/arm/mach-omap2/Kconfig |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>index a8a3d1e..8f9d9c9 100644
>--- a/arch/arm/mach-omap2/Kconfig
>+++ b/arch/arm/mach-omap2/Kconfig
>@@ -10,6 +10,7 @@ config ARCH_OMAP2420
> config ARCH_OMAP2430
>        bool "OMAP2430 support"
>        depends on ARCH_OMAP2
>+       select ARCH_OMAP_OTG
>
> config ARCH_OMAP3430
>        bool "OMAP3430 support"
>--
>1.6.6
>
>This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
>
>______________________________________________________________________
>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
