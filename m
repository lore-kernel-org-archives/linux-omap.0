From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/7 V2] usb: musb: TWL6030: Selecting TWL6030_USB
 transceiver
Date: Fri, 10 Dec 2010 12:31:38 +0200
Message-ID: <20101210103138.GD6027@legolas.emea.dhcp.ti.com>
References: <1291964704-7190-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:59857 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754951Ab0LJKbm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 05:31:42 -0500
Content-Disposition: inline
In-Reply-To: <1291964704-7190-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On Fri, Dec 10, 2010 at 12:35:04PM +0530, Hema HK wrote:
>Selecting the twl6030-usb for OMAP4430SDP and OMAP4PANDA boards and
>adding OMAP4 internal phy code for compilation
>
>Signed-off-by: Hema HK <hemahk@ti.com>
>Cc: Felipe Balbi <balbi@ti.com>
>Cc: Tony Lindgren <tony@atomide.com>
>---
> arch/arm/mach-omap2/Makefile |    6 ++++--
> drivers/usb/musb/Kconfig     |    1 +
> 2 files changed, 5 insertions(+), 2 deletions(-)
>
>Index: usb/arch/arm/mach-omap2/Makefile
>===================================================================
>--- usb.orig/arch/arm/mach-omap2/Makefile
>+++ usb/arch/arm/mach-omap2/Makefile
>@@ -168,9 +168,11 @@ obj-$(CONFIG_MACH_IGEP0030)		+= board-ig
> obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
> 					   hsmmc.o
> obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o \
>-					   hsmmc.o
>+					   hsmmc.o \
>+					   omap_phy_internal.o
> obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
>-					   hsmmc.o
>+					   hsmmc.o \
>+					   omap_phy_internal.o
>
> obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o

Wow, quite late on the series. You're breaking git bisect.

-- 
balbi
