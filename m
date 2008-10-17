From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated to v2.6.27, some issues remain
Date: Thu, 16 Oct 2008 17:19:37 -0700
Message-ID: <20081017001937.GF15820@atomide.com>
References: <20081010120427.GZ3044@atomide.com> <200810161243.41079.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64958 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbYJQATj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 20:19:39 -0400
Content-Disposition: inline
In-Reply-To: <200810161243.41079.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081016 12:43]:
> On Friday 10 October 2008, Tony Lindgren wrote:
> > Let's try to get the pending issues sorted out and then tag -omap1
> > at the end of next week. So far it looks like we still have the fol=
lowing
> > issues remaining:
> >=20
> > - i2c transfers not working because of i2c-omap.c PM (These also ma=
ke
> > =A0 musb init fail at least on 3430sdp)
>=20
> Resolved ...
>=20
>=20
> > - 24xx/34xx write posting issue
> >=20
> > - 34xx spurious interrupts about 1/20 reboots
>=20
> ... I think I saw patches for at least the posting issue
> get sent ...

I pushed the strongly ordered patch for that.

>=20
> =20
> > Anything else not working right now?
>=20
> The MUSB transceiver-level issues I was aware of (mostly
> on Overo, but minor glitches on Beagle) now seem to be
> fixed by the combination of the IRQ patches I sent last
> week, plus the twl4030-usb patch I just sent.

So I guess we have a go for tagging v2.6.27-omap1 on Friday!
Also, looks like the minimal omap3 patches just hit mainline
few hours ago :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
