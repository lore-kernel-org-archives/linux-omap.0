From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/5] ARM: OMAP: TLL driver implementation for USB host
 driver
Date: Fri, 16 Mar 2012 17:43:00 +0100
Message-ID: <20120316164300.GC20524@sortiz-mobl>
References: <1330957865-30543-1-git-send-email-keshava_mgowda@ti.com>
 <CAP05o4LKEHtXFzZ0ysV+gNVu-_dh9BrAZb+M5UgaVy6dssMNbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5599 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685Ab2CPQfH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 12:35:07 -0400
Content-Disposition: inline
In-Reply-To: <CAP05o4LKEHtXFzZ0ysV+gNVu-_dh9BrAZb+M5UgaVy6dssMNbA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com

Hi Keshava,

On Mon, Mar 05, 2012 at 08:13:45PM +0530, Munegowda, Keshava wrote:
> On Mon, Mar 5, 2012 at 8:01 PM, Keshava Munegowda <keshava_mgowda@ti.=
com> wrote:
> > From: Keshava Munegowda <Keshava_mgowda@ti.com>
> >
> > The TLL configuration is removed from the UHH driver and implemente=
d as
> > a seperate platform driver. Now, the UHH driver configures the TLL
> > through API's exported by the TLL platform driver. The TLL is an
> > has independent hardware mod structure for in OMAP3 and later chips=
,
> > hence an dedicated platform driver is created.
> >
> > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> >
> > Keshava Munegowda (5):
> > =A0ARM: OMAP: USB: HOST TLL platform driver
> > =A0ARM: OMAP: USB: Build the USB HOST TLL omap device
> > =A0ARM: OMAP: USB: Remove TLL specific code
> > =A0ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
> > =A0ARM: OMAP: change the USB TLL clocks device name
> >
> > =A0arch/arm/mach-omap2/clock3xxx_data.c =A0| =A0 =A08 +-
> > =A0arch/arm/mach-omap2/clock44xx_data.c =A0| =A0 =A04 +-
> > =A0arch/arm/mach-omap2/usb-host.c =A0 =A0 =A0 =A0| =A0 28 ++-
> > =A0arch/arm/plat-omap/include/plat/usb.h | =A0 =A09 +
> > =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
> > =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
> > =A0drivers/mfd/omap-usb-host.c =A0 =A0 =A0 =A0 =A0 | =A0232 +------=
----------
> > =A0drivers/mfd/omap-usb-tll.c =A0 =A0 =A0 =A0 =A0 =A0| =A0463 +++++=
++++++++++++++++++++++++++++
> > =A08 files changed, 513 insertions(+), 235 deletions(-)
> > =A0create mode 100644 drivers/mfd/omap-usb-tll.c
> >
>=20
> Hi Samuel
>         just to get your attention; I have added your mail id in the
> "to" list.
> please let me know  your comments on this patch series;
Here as well, I don't think I was cc'ed on the original submission. Wit=
hout
getting the actual patch, I'll have hard time reviewing it.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
