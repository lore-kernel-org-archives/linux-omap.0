From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 0/5] ARM: OMAP: TLL driver implementation for USB host driver
Date: Mon, 5 Mar 2012 20:13:45 +0530
Message-ID: <CAP05o4LKEHtXFzZ0ysV+gNVu-_dh9BrAZb+M5UgaVy6dssMNbA@mail.gmail.com>
References: <1330957865-30543-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:50461 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932348Ab2CEOnu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Mar 2012 09:43:50 -0500
Received: by mail-gy0-f178.google.com with SMTP id f1so1907596ghb.37
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 06:43:45 -0800 (PST)
In-Reply-To: <1330957865-30543-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com

On Mon, Mar 5, 2012 at 8:01 PM, Keshava Munegowda <keshava_mgowda@ti.co=
m> wrote:
> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>
> The TLL configuration is removed from the UHH driver and implemented =
as
> a seperate platform driver. Now, the UHH driver configures the TLL
> through API's exported by the TLL platform driver. The TLL is an
> has independent hardware mod structure for in OMAP3 and later chips,
> hence an dedicated platform driver is created.
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>
> Keshava Munegowda (5):
> =A0ARM: OMAP: USB: HOST TLL platform driver
> =A0ARM: OMAP: USB: Build the USB HOST TLL omap device
> =A0ARM: OMAP: USB: Remove TLL specific code
> =A0ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
> =A0ARM: OMAP: change the USB TLL clocks device name
>
> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0| =A0 =A08 +-
> =A0arch/arm/mach-omap2/clock44xx_data.c =A0| =A0 =A04 +-
> =A0arch/arm/mach-omap2/usb-host.c =A0 =A0 =A0 =A0| =A0 28 ++-
> =A0arch/arm/plat-omap/include/plat/usb.h | =A0 =A09 +
> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02=
 +-
> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 +-
> =A0drivers/mfd/omap-usb-host.c =A0 =A0 =A0 =A0 =A0 | =A0232 +--------=
--------
> =A0drivers/mfd/omap-usb-tll.c =A0 =A0 =A0 =A0 =A0 =A0| =A0463 +++++++=
++++++++++++++++++++++++++
> =A08 files changed, 513 insertions(+), 235 deletions(-)
> =A0create mode 100644 drivers/mfd/omap-usb-tll.c
>

Hi Samuel
        just to get your attention; I have added your mail id in the
"to" list.
please let me know  your comments on this patch series;

This change was strongly suggested by Paul Walmsley during the
OMAP USB host runtime pm adaptations.

Regards
Keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
