From: "Menon, Nishanth" <nm@ti.com>
Subject: mux strategy (was RE: [PATCH] [OMAP1] mux: Add MMC mux pins for
 omap7xx)
Date: Tue, 6 Oct 2009 16:52:37 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012A67976D@dlee02.ent.ti.com>
References: <6cb013310910060653u4825da1cwf738a9acef5835b2@mail.gmail.com>
	<4ACB7EC0.3010401@ti.com>
	<6cb013310910061244q40b78c0ubad1932578e75bd3@mail.gmail.com>
 <87hbucp6ng.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40606 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933234AbZJFVxR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 17:53:17 -0400
In-Reply-To: <87hbucp6ng.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Cory Maccarrone <darkstar6262@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>=20
> >>> =A0 =A0 =A0 =A0W17_7XX_USB_VBUSI,
> >>> +
> >>> + =A0 =A0 =A0 /* MMC */
> >>> + =A0 =A0 =A0 MMC_7XX_CMD,
> >>> + =A0 =A0 =A0 MMC_7XX_CLK,
> >>> + =A0 =A0 =A0 MMC_7XX_DAT0,
> >>
> >> probably a dumb question -> but should'nt these go off to bootload=
er
> >> perhaps?
> >>
> >
> > Perhaps, although we use either EOL (for HTC Wizard) or Haret to bo=
ot,
> > and they don't set up the right mux configuration for our board.
> >
> > This way though, we don't have to worry about the boot loader -- we
> > can set it up right regardless of who boots us.
>=20
> I agree with Cory.
>=20
> I prefer that mux settings go into the kernel, even if they are setup
> in the bootloader already.  It's better to have redundancy than wonde=
r
> what to do if changing boot loaders.
>=20
Probably opening up a can of worms.. Are the rules different for OMAP3?=
=20
Should'nt we have all mux done at kernel so that kernel is loader=20
independent?

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
