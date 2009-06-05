From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 04/20] omapfb: Add support for the Amstrad Delta LCD
Date: Fri, 5 Jun 2009 16:39:17 +0100
Message-ID: <20090605153917.GK31770@earth.li>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com> <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com> <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com> <200906051238.23755.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from the.earth.li ([217.147.81.2]:50614 "EHLO the.earth.li"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbZFEPjS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Jun 2009 11:39:18 -0400
Content-Disposition: inline
In-Reply-To: <200906051238.23755.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Imre Deak <imre.deak@nokia.com>, Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>

On Fri, Jun 05, 2009 at 12:38:22PM +0200, Janusz Krzysztofik wrote:
> Thursday 04 June 2009 19:52:29 Imre Deak napisa=C5=82(a):
> > From: Jonathan McDowell <noodles@earth.li>
> >
> > This is an updated version of the LCD driver for the Amstrad Delta =
to
> > take into account the recent changes to the omapfb infrastructure. =
The
> > Delta features a 480x320 12 bit DSTN panel.
>=20
> I'd really love to see the lcd_ams_delta support included in the main=
line=20
> kernel, but I am not sure if it is ready for submission, as I still h=
ave=20
> issues with it. It does work perfectly unless power management is tur=
ned on.
> With CONFIG_PM=3Dy, the omapfb device, after initially starting corre=
ctly,=20
> breaks with the following error messages:
>=20
> omapfb omapfb: resetting (status 0xffffff96,reset count 1)
> ...
> omapfb omapfb: resetting (status 0xffffff96,reset count 100)
> omapfb omapfb: too many reset attempts, giving up.
>=20
> Tested with linux-2.6.30-rc5 and linux-omap revision=20
> 90e758af52ba803cba233fabee81176d99589f09. Error messages do not appea=
r when=20
> CONFIG_PM=3Dn or lcd_ams_delta.o is removed from omapfb-objs.
>=20
> Please let me know what else I can do to help in resolving this issue=
=2E
=20
Reporting it was a good start; it's the first I've heard of this issue.
Looking at the E3 configs I have lying around it looks like none of the=
m
have CONFIG_PM set, so it's possible most people have just been using
the defconfig or a minor variation of it. I don't have my E3 convenient
at present to investigate however.

J.

--=20
101 things you can't have too much of : 14 - Paperclips.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
