From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [RESEND][PATCH 0/5] arm: omap: usb: Runtime PM support for EHCI
 and OHCI drivers
Date: Mon, 16 May 2011 18:08:30 +0530
Message-ID: <BANLkTin6SMZ_osDV8cxw7O1u9bHTtHfRyw@mail.gmail.com>
References: <1305538430-20957-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305538430-20957-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 16, 2011 at 3:03 PM, Keshava Munegowda
<keshava_mgowda@ti.com> wrote:
> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>
> The Hwmod structures and Runtime PM features are implemented
> For EHCI and OHCI drivers of OMAP3 and OMAP4.
> The global suspend/resume of EHCI and OHCI
> is validated on OMAP3430 sdp board with these patches.
>
> Keshava Munegowda (5):
> =A0arm: omap: usb: ehci and ohci hwmod structures for omap3 and omap4
> =A0arm: omap: usb: register hwmods of usbhs
> =A0arm: omap: usb: device name change for the clk names of usbhs
> =A0arm: omap: usb: Runtime PM support
> =A0arm: omap: usb: global Suspend and resume support of ehci and ohci
>
> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 | =A0 28 ++--
> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0 | =A0 10 +-
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0184 ++++++++++++++=
++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0153 ++++++++++++++=
++++
> =A0arch/arm/mach-omap2/usb-host.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 99 ++=
++--------
> =A0drivers/mfd/omap-usb-host.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A023=
6 +++++++++++++---------------
> =A06 files changed, 504 insertions(+), 206 deletions(-)
>

balbi

need your decision (ACK / review comments) on this series too.


Regards
Keshava
