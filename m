From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND][PATCH 1/2] McSPI Slave and DMA,FIFO support
Date: Thu, 2 Jul 2009 17:03:18 -0700
Message-ID: <200907021703.19021.david-b@pacbell.net>
References: <42142.10.24.255.18.1245765240.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:32904 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751012AbZGCADQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jul 2009 20:03:16 -0400
In-Reply-To: <42142.10.24.255.18.1245765240.squirrel@dbdmail.itg.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Tuesday 23 June 2009, Hemanth V wrote:
> This patch adds support for McSPI slave and FIFO.

Actualy, no it doesn't.  Just adds a few fields to structs.

> DMA and FIFO=20
> could be enabled together for better throughput. Platform config
> parameters have been added to enable these features on any particular
> McSPI controller.
>=20
> FIFO can be enabled by defining fifo_depth parameter. fifo_depth need=
s
> to be a multiple of buffer size that is used for read/write.
>=20
> These features are useful when you have high throughput devices
> like WLAN or Modem connected over SPI.

Yeah, but that's all irrelevant for adding a few fields...

I'd rather see this patch merge with the one that adds FIFO
support.  And get Tony's ack on at least these parts, being
as he's Emperor of OMAP.  ;)


>=20
> Signed-off-by: Hemanth V <hemanthv@ti.com>
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +++++
> =A0arch/arm/plat-omap/include/mach/mcspi.h | =A0 16 ++++++++++++++++
> =A02 files changed, 21 insertions(+)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
