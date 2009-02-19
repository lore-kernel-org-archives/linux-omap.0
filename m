From: Gregoire Gentil <gregoire@gentil.com>
Subject: Re: McSPI3 on the BeagleBoard
Date: Thu, 19 Feb 2009 00:22:27 -0800
Message-ID: <1235031747.13828.1.camel@localhost>
References: <499B4B64.30109@balister.org>
	 <200902171918.45146.david-b@pacbell.net>  <499CAA27.5020500@balister.org>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:30083 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbZBSIWa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 03:22:30 -0500
Received: by wa-out-1112.google.com with SMTP id v33so161514wah.21
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2009 00:22:30 -0800 (PST)
In-Reply-To: <499CAA27.5020500@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Philip,

Can you please post here or on the Beagleboard mailing list the u-boot
patch? This muxpin is very tricky and I have experienced many problems
when set up in the kernel while it seems to work better from u-boot -
don't know why,

Gr=C3=A9goire


On Wed, 2009-02-18 at 19:39 -0500, Philip Balister wrote:
> David Brownell wrote:
> > On Tuesday 17 February 2009, Philip Balister wrote:
> >> A number of people have tried using the McSPI3 interface with the =
spidev=20
> >> driver. Running the spidev_test program shows data coming out of t=
he=20
> >> interface, but when we connect the SIMO to SOMI pins, the spidev_t=
est=20
> >> program shows only 0's. Someone tried wiring SOMI to +volts and st=
ill=20
> >> only saw 0 read.
> >=20
> > I took a quick glance, and the pinmuxing looks sort of OK if
> > you ignore the names ... use the right balls, not XXX:
> >=20
> > +       AE2_3430_MCSPI3_CLK,
> > +       AG5_3430_MCSPI3_SIMO,
> > +       AH5_3430_MCSPI3_SOMI,
> > +       AF4_3430_MCSPI3_CS0,
> > +       AG4_3430_MCSPI3_CS1,
> >=20
> > I suggest you start with a more focussed patch, only setting
> > up McSPI3.  For one thing, the MMC2 pinmuxing will interfere
> > with this set of MCSPI3 configurations.
> >=20
> > Also, start with a less aggressive bit rate than 48 MHz; that
> > may be OK on a well designed board, but breadboards tend to
> > show flakiness at much over 10 MHz.
>=20
> OK, more results:
>=20
> 1) I do not intend for this to go into the kernel, well unless there =
is=20
> an outcry from beagle users :)
>=20
>=20
> Steve Sakoman suggested I do the pinmux setup in u-boot and furnished=
 me=20
> with a small u-boot patch. Using this patch and removing the pinmux=20
> stuff from the kernel patch lead to working spidev_test.
>=20
> The 48 MHz is the max rate, spidev_test defaults to 500 kHz. (but it=20
> appears to work at 48 MHz also.
>=20
> Thanks for taking a look at this!
>=20
> Philip
>=20
> PS: I love photos: http://www.flickr.com/photos/32615155@N00/32913048=
54/

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
