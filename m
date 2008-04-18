From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] Add usb support to omap3beagle
Date: Fri, 18 Apr 2008 11:50:01 -0700
Message-ID: <20080418185000.GG12099@atomide.com>
References: <CE83D2E2-7DC8-471C-AD14-14A6FED413A9@student.utwente.nl> <200804171126.54874.david-b@pacbell.net> <7F9BB0C5-23DD-4F44-904C-EF3F70324421@student.utwente.nl> <200804171236.07509.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:62046 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759168AbYDRSuE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 14:50:04 -0400
Content-Disposition: inline
In-Reply-To: <200804171236.07509.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080417 12:36]:
> On Thursday 17 April 2008, Koen Kooi wrote:
> > >>
> > >> @@ -69,6 +70,7 @@
> > >> =A0=A0=A0=A0=A0omap_board_config_size =3D ARRAY_SIZE(omap3_beagl=
e_config);
> > >> =A0=A0=A0=A0=A0omap_serial_init();
> > >> =A0=A0=A0=A0=A0sdp_mmc_init();
> > >> +=A0=A0=A0=A0sdp3430_usb_init();
> > >> }
> > >>
> > >> arch_initcall(omap3_beagle_i2c_init);
> > >
> > > I hope someone makes those sdp_*() routines generic ... or does
> > > "SDP" not stand for "Software Development Platform" (different bo=
ard)?
> >=20
> > Those routines are indeed name after the sdp board, but they seem
> > generic enough to get reused in other boards (e.g. omap3evm or omap=
3
> > beagle) without change :)
>=20
> They aren't quite generic enough ... with those names!  :)

Yeah the files should be just twl4030-hsmmc.c instead of
board-sdp-hsmmmc.c.

And usb-musb.c instead of board-2430sdp-usb.c and board-3430sdp-usb.c.

I guess let's do that change next week after we've tagged 2.6.25-omap1.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
