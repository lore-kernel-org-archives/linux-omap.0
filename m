From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 0/5 v12] mfd: omap: usb: Runtime PM support for EHCI and
 OHCI drivers
Date: Fri, 30 Sep 2011 11:17:31 +0530
Message-ID: <CAP05o4+32E5m=otQgSoNf2xSgK1F1nkvm+VyoDRxKdRQkF4OGw@mail.gmail.com>
References: <1317306247-1103-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:56975 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932154Ab1I3Frd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 01:47:33 -0400
In-Reply-To: <1317306247-1103-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, paul@pwsan.com
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, "Basak, Partha" <p-basak2@ti.com>, linux-omap@vger.kernel.org, Linux USB Devel <linux-usb@vger.kernel.org>

On Thu, Sep 29, 2011 at 7:54 PM, Keshava Munegowda
<keshava_mgowda@ti.com> wrote:
> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>
> The Hwmod structures and Runtime PM features are implemented
> For EHCI and OHCI drivers of OMAP3 and OMAP4.
> The global suspend/resume of EHCI and OHCI
> is validated on OMAP3430 sdp board with these patches.
>
> TODO:
> =A0- Adding mux-information to Hwmods.
> =A0- Aggressive Clock Management around USB bus suspend/resume.
> =A0- Remote Wakeup support implementation using IO-ring Wakeup
> =A0 =A0on EHCI/OHCI pads via PRCM IRQ chain handler.
>
>
> In version 12:
> =A0- The ehci, ohci and usb_host_hs hwmods combined as a single hwmod
> =A0 =A0usb_host_hs.
> =A0- for omap3
> =A0 =A0 =A0 =A0the usbhost_ick and and usbtll_ick clocks are changed =
as interface
> =A0 =A0 =A0 =A0clocks. The usbtll_fck, usbhost_48m_fck clocks are cha=
nged as main
> =A0 =A0 =A0 =A0clocks and the 120mhz functional clock is changed to o=
ptional clock
> =A0- the usbhs mfd driver enable/disable this optional clock in
> =A0 =A0runtime_resume and runtime_suspend callbacks of pm_runtime_get=
_sync
> =A0 =A0and pm_runtime_put_sync APIs.
>
> Benoit Cousson (1):
> =A0arm: omap: usb: ehci and ohci hwmod structures for omap4
>
> Keshava Munegowda (4):
> =A0arm: omap: usb: ehci and ohci hwmod structures for omap3
> =A0arm: omap: usb: register hwmods of usbhs
> =A0arm: omap: usb: device name change for the clk names of usbhs
> =A0mfd: omap: usb: Runtime PM support
>
> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 | =A0 26 +-
> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0 | =A0 10 +-
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0195 ++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0171 +++++++-
> =A0arch/arm/mach-omap2/usb-host.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0100 ++=
---
> =A0arch/arm/plat-omap/include/plat/usb.h =A0 =A0 =A0| =A0 =A03 -
> =A0drivers/mfd/omap-usb-host.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A074=
8 +++++++++++-----------------
> =A0drivers/usb/host/ehci-omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 17 =
+-
> =A0drivers/usb/host/ohci-omap3.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 18 =
+-
> =A09 files changed, 727 insertions(+), 561 deletions(-)
>

Hi Paul/Benoit

due to Google mail box problems; the patches were not sent with proper =
version;
hence , i have re posted the patches again now.
please review this latest series.

regards
Keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
