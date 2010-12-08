From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: Re: [PATCH 0/7] usb: otg: TWL6030: OMAP4430: musb & transceiver
 driver support for OMAP4
Date: Wed, 8 Dec 2010 11:37:42 +0530
Message-ID: <AANLkTinHhwdKiACKDMYj-xGPzb+=y5cyv8tQ1pzZVR1_@mail.gmail.com>
References: <1291766971-9986-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:59925 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752714Ab0LHGHn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Dec 2010 01:07:43 -0500
In-Reply-To: <1291766971-9986-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb-owner@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Samuel Ortiz <sameo@linux.intel.com>

Please ignore this series of patches.

I sent the older version the patches by mistake. I will send new versio=
ns again.
Sorry for cluttering ......

Regards,
Hema


On Wed, Dec 8, 2010 at 5:39 AM, Hema HK <hemahk@ti.com> wrote:
> This patch series has the support for TWL6030-usb
> transceiver driver and changes in the musb driver to make it function=
al
> with OMAP4430.
>
> OMAP4 musb support UTMI and ULPI transceiver interfaces.
>
> In UTMI mode, the transceiver functionality is split between
> the TWL6030 PMIC chip and OMAP4 embedded PHY.
> The TWL6030 transceiver driver code is under otg folder and
> internal UTMI PHY specific code changes are defined under
> mach-omap2 directory and functions are passed through platform_data
> structure.
>
> This patch series is based on V2.6.37-rc4 + [1]+[2]+[3]+[4].
>
> [1] http://www.listware.net/201011/linux-usb/
> 65625-patch-resend-v3-usb-musb-do-not-use-dma-for-control-transfers.h=
tml
>
> [2] http://www.spinics.net/lists/linux-usb/msg37105.html
>
> [3] http://permalink.gmane.org/gmane.linux.usb.general/37123
>
> [4] Felipe's musb-reorg patch series.
> =A0 =A0 =A0 =A0http://gitorious.org/usb/usb/commits/musb-hw
>
> Tested musb device and host mode functionality with OMAP4430SDP
> and OMAP3630 ZOOM3.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>
> Hema HK (7):
> =A0mfd: TWL6030: USBOTG VBUS event generation on charger VBUS events.
> =A0usb: otg: Adding twl6030-usb transceiver driver for OMAP4430 musb
> =A0usb: otg: Kconfig: Add Kconfig option for TWL6030 transceiver.
> =A0mfd: TWL6030: OMAP4: Registering the TWL6030-usb device
> =A0usb: musb: TWL6030: Selecting TWL6030_USB transceiver for OMAP4
> =A0usb: musb: Adding musb support for OMAP4430
> =A0arm: OMAP4430: musb: Enable musb device initialization for OMAP443=
0
>
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0 | =A0 15 +-
> =A0arch/arm/mach-omap2/board-omap4panda.c =A0| =A0 =A09 +-
> =A0arch/arm/mach-omap2/omap_phy_internal.c | =A0123 +++++++
> =A0arch/arm/plat-omap/include/plat/usb.h =A0 | =A0 =A04 +
> =A0drivers/mfd/twl-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 44=
 +++-
> =A0drivers/mfd/twl6030-irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +=
-
> =A0drivers/usb/musb/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01=
 +
> =A0drivers/usb/musb/musb_core.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 +
> =A0drivers/usb/musb/musb_core.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/usb/musb/musb_gadget.c =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/usb/musb/omap2430.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 85 +++++=
-
> =A0drivers/usb/otg/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +
> =A0drivers/usb/otg/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01=
 +
> =A0drivers/usb/otg/twl6030-usb.c =A0 =A0 =A0 =A0 =A0 | =A0527 +++++++=
++++++++++++++++++++++++
> =A0include/linux/i2c/twl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06=
 +
> =A016 files changed, 824 insertions(+), 19 deletions(-)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
