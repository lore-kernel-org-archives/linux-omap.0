From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH] serial: Add OMAP high-speed UART driver.
Date: Tue, 2 Mar 2010 19:28:34 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026ED96358__15874.7744783343$1267538359$gmane$org@dbde02.ent.ti.com>
References: <41322.192.168.10.89.1267454612.squirrel@dbdmail.itg.ti.com>
	 <20100301184600.GC3389@atomide.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E94026ED95FC1@dbde02.ent.ti.com>
	 <20100302060821.GI3389@atomide.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E94026ED9600D@dbde02.ent.ti.com>
	 <20100302065224.GL3389@atomide.com>
 <618f0c911003020546mb7c8412o2bac4e86a081332b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57358 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab0CBN6m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 08:58:42 -0500
In-Reply-To: <618f0c911003020546mb7c8412o2bac4e86a081332b@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, Tony Lindgren <tony@atomide.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, Greg KH <greg@kroah.com>, "linux-serial@vger.kernel.org" <linux-seria>

=20

> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On=20
> Behalf Of Venkatraman S
> Sent: Tuesday, March 02, 2010 7:16 PM
> To: Tony Lindgren; G, Manjunath Kondaiah; Raja, Govindraj;=20
> Greg KH; linux-serial@vger.kernel.org;=20
> linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org;=20
> Kevin Hilman; Olof Johansson
> Subject: Re: [PATCH] serial: Add OMAP high-speed UART driver.
>=20
> On Tue, Mar 2, 2010 at 12:22 PM, Tony Lindgren=20
> <tony@atomide.com> wrote:
> > * G, Manjunath Kondaiah <manjugk@ti.com> [100301 22:24]:
> >>
> >>
> >>
> >> > > > > + =A0 =A0 up->uart_dma.prev_rx_dma_pos =3D
> >> > up->uart_dma.rx_buf_dma_phys;
> >> > > > > + =A0 =A0 if (cpu_is_omap44xx())
> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(0, OMAP44XX_DMA4_BAS=
E
> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +
> >> > OMAP_DMA4_CDAC(up->uart_dma.rx_dma_channel));
> >> > > > > + =A0 =A0 else
> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(0, OMAP34XX_DMA4_BAS=
E
> >> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +
> >> > OMAP_DMA4_CDAC(up->uart_dma.rx_dma_channel));
> >> > > >
> >> > > > NAK. Please don't use omap_read/write for for new=20
> code. And do not
> >> > > > tinker with the omap hardware registers directly in=20
> the driver.
> >> > > >
> >> > > > This needs to be done properly in
> >> > arch/arm/plat-omap/dma.c instead.
> >> > >
> >> > > Thanks for the suggestion.
> >> > >
> >> > > Currently, dma_read/dma_write are #define's in dma.c which
> >> > cannot be
> >> > > accessed outside dma.c. I don't see any API's in dma.c for
> >> > setting required
> >> > > value for this register?
> >> >
> >> > Hmm isn't this the same as omap_get_dma_dst_pos(int=20
> lch)? If you're
> >> > trying do something that's not in dma.c, we can add a=20
> new function
> >> > for it.
> >>
> >> The omap_get_dma_dst_pos(int lch) is for read operation in=20
> CDAC register.
> >> But, We need to write required value into CDAC register.=20
> For this, I propose:
> >>
> >> omap_set_dma_dst_pos(int lch, int value) which does not=20
> exist in current dma
> >> driver.
> >
> > OK, it that's needed.
> >
> > Tony
> > --
> CDAC is a shadow register used for monitoring the DMA channel.
>  I think it would be a lot
> simpler if omap_start_dma() always resets CDAC to 0, and the=20
> UART driver
> just not set it explicitly.

This seems to be better option than exposing CDAC read/write API
to other drivers since user need to write '0' before starting any DMA
transfer which can be be done in omap_start_dma().

I am wondering how other drivers are using DMA transfer API's without=20
resetting CDAC to zero.=20

-Manjunath


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
