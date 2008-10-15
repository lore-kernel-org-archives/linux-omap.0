From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Wed, 15 Oct 2008 07:08:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810150706140.14740@utopia.booyaka.com>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com> <alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com> <20081014172921.GJ20247@frodo> <200810141047.44803.david-b@pacbell.net> <20081014180634.GL20247@frodo> <20081014205925.GK8150@atomide.com>
 <1224018598.4977.27.camel@localhost> <20081014212409.GL8150@atomide.com> <87wsgabcp0.fsf@trdhcp146196.ntc.nokia.com> <alpine.DEB.2.00.0810150106370.8581@utopia.booyaka.com> <87wsga9fip.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1387231235-1224076119=:14740"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44268 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYJONIk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 09:08:40 -0400
In-Reply-To: <87wsga9fip.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, r-woodruff2@ti.com
Cc: ext Tony Lindgren <tony@atomide.com>, Igor Stoppa <igor.stoppa@nokia.com>, Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1387231235-1224076119=:14740
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 15 Oct 2008, H=C3=B6gander Jouni wrote:

> L3 and L4 are anyway on when not in wfi, because of sleep/wkdep, so no
> power save. This is the case at least with OMAP3 not sure about OMAP2.

I thought that disabling the iclken bit still disabled some gates=20
in the OCP interface.  Richard, do you know if that is the case?

> > There also was some discussion last year that modules like GPTIMER can=
=20
> > have their functional clocks enabled, but their interface clocks disabl=
ed=20
> > when register access is not needed.  Wakeups from the module are still=
=20
> > sent asynchronously to the PRCM.  Again the motivation is to save power=
=2E =20
> > I don't think the current code tries to do this.
> >
>=20
> In many modules there is also possibility to gate ick by HW when not
> in wfi (see AUTOIDLE in SYCONFIG). I'm not sure about this but
> extremely also fcks could be taken care by HW (see CLOCKACTIVITY in
> SYSCONFIG).

How will the PRCM know when the device driver is accessing the module=20
registers?


- Paul
--155748971-1387231235-1224076119=:14740--
