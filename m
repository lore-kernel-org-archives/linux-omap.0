From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] alsa: add Beagleboard SoC configuration.
Date: Mon, 6 Oct 2008 11:01:53 -0700
Message-ID: <200810061101.54350.david-b@pacbell.net>
References: <1221597643-29601-1-git-send-email-felipe.contreras@gmail.com> <200810032334.04565.david-b@pacbell.net> <alpine.DEB.2.00.0810060906140.354@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:36129 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751244AbYJFSCB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 14:02:01 -0400
In-Reply-To: <alpine.DEB.2.00.0810060906140.354@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org

On Monday 06 October 2008, Paul Walmsley wrote:
> > [ INFO: possible recursive locking detected ]
> > 2.6.27-rc8-omap1 #174
> > ---------------------------------------------
> > aplay/1816 is trying to acquire lock:
> > =A0(clockfw_lock){....}, at: [<c0036be4>] clk_enable+0x24/0x70
> >=20
> > but task is already holding lock:
> > =A0(clockfw_lock){....}, at: [<c0036be4>] clk_enable+0x24/0x70
>=20
> Yeah, the code that's in that driver is broken. =A0The driver=20
> sets up a custom clk_enable() function that calls clk_enable() again.=
 =A0And=20
> clk_enable() takes clockfw_lock.

I don't follow.  Could you point at those lines of code?
The only clkfw_lock I see is in plat-omap/clock.c code ...
which isn't part of this ASoC driver or even its board glue.

=20
> The omap_clk_associate() code should resolve this problem.

Time to resolve that, then... are you saying that the patches
=46elipe posted will, if merged, make this lockdep report go
away so it's safe to run lockdep and ALSA on twl4030 codecs?

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
