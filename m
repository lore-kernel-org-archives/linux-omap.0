From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] alsa: add Beagleboard SoC configuration.
Date: Mon, 6 Oct 2008 21:32:19 +0300
Message-ID: <20081006183216.GB8273@frodo>
References: <1221597643-29601-1-git-send-email-felipe.contreras@gmail.com> <200810032334.04565.david-b@pacbell.net> <alpine.DEB.2.00.0810060906140.354@utopia.booyaka.com> <200810061101.54350.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57156 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbYJFScl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 14:32:41 -0400
Content-Disposition: inline
In-Reply-To: <200810061101.54350.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Paul Walmsley <paul@pwsan.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org

On Mon, Oct 06, 2008 at 11:01:53AM -0700, David Brownell wrote:
> On Monday 06 October 2008, Paul Walmsley wrote:
> > > [ INFO: possible recursive locking detected ]
> > > 2.6.27-rc8-omap1 #174
> > > ---------------------------------------------
> > > aplay/1816 is trying to acquire lock:
> > > =A0(clockfw_lock){....}, at: [<c0036be4>] clk_enable+0x24/0x70
> > >=20
> > > but task is already holding lock:
> > > =A0(clockfw_lock){....}, at: [<c0036be4>] clk_enable+0x24/0x70
> >=20
> > Yeah, the code that's in that driver is broken. =A0The driver=20
> > sets up a custom clk_enable() function that calls clk_enable() agai=
n. =A0And=20
> > clk_enable() takes clockfw_lock.
>=20
> I don't follow.  Could you point at those lines of code?
> The only clkfw_lock I see is in plat-omap/clock.c code ...
> which isn't part of this ASoC driver or even its board glue.
>=20
> =20
> > The omap_clk_associate() code should resolve this problem.
>=20
> Time to resolve that, then... are you saying that the patches
> Felipe posted will, if merged, make this lockdep report go
> away so it's safe to run lockdep and ALSA on twl4030 codecs?

heh, I'll repost tomorrow changing the name to omap_clk_associate()

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
