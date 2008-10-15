From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Wed, 15 Oct 2008 01:49:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810150106370.8581@utopia.booyaka.com>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com> <alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com> <20081014172921.GJ20247@frodo> <200810141047.44803.david-b@pacbell.net> <20081014180634.GL20247@frodo> <20081014205925.GK8150@atomide.com>
 <1224018598.4977.27.camel@localhost> <20081014212409.GL8150@atomide.com> <87wsgabcp0.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1377310186-1224056956=:8581"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43539 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbYJOHtS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 03:49:18 -0400
In-Reply-To: <87wsgabcp0.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Igor Stoppa <igor.stoppa@nokia.com>, Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, r-woodruff2@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1377310186-1224056956=:8581
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Jouni,

On Wed, 15 Oct 2008, H=C3=B6gander Jouni wrote:

> "ext Tony Lindgren" <tony@atomide.com> writes:
>=20
> > * Igor Stoppa <igor.stoppa@nokia.com> [081014 14:12]:
> >> On Tue, 2008-10-14 at 13:59 -0700, ext Tony Lindgren wrote:
> >>=20
> >> > And that we can use same naming in the driver no matter which omap :=
)
> >>=20
> >> Wasn't that one of the main features of the clock FW, when it was
> >> designed?
> >
> > Yes. But we adding separate ick and fck during omap2420 confused
> > that.
>=20
> Why this was originally done? I mean we have possibility to autogate
> interface clocks. AFAIK those could be just fine be enabled on boot and l=
et
> the hw to take care of them.

Richard is really the best person to ask about this, so he's been added to=
=20
the cc.  My current understanding is below.  Perhaps he can respond with=20
more detail and correct any errors.

In terms of original motivation, you might want to look at 34xx TRM=20
4.12.2.4.3.  I don't think this actually works in practice on OMAP3.

Current practical use is different.  Autogating only takes effect during=20
sleep & wakeup transitions for the entire CORE_Lx clockdomain (34xx TRM=20
4.12.2.4.4).  So even if a module's functional clocks are disabled, the=20
PRCM won't autogate the module's interface clock until the entire CORE_Lx=
=20
clockdomain transitions to inactive.  The theory here is that this wastes=
=20
power and that manually disabling the interface clock when the device is=20
known to be inactive should save some power.

There also was some discussion last year that modules like GPTIMER can=20
have their functional clocks enabled, but their interface clocks disabled=
=20
when register access is not needed.  Wakeups from the module are still=20
sent asynchronously to the PRCM.  Again the motivation is to save power. =
=20
I don't think the current code tries to do this.


- Paul
--155748971-1377310186-1224056956=:8581--
