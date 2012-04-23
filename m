From: Tero Kristo <t-kristo@ti.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Mon, 23 Apr 2012 13:13:22 +0300
Message-ID: <1335176002.2149.65.camel@sokoban>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
	 <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com>
	 <1335173044.2149.64.camel@sokoban>
	 <C8443D0743D26F4388EA172BF4E2A7A93E96E75A@DBDE01.ent.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32780 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591Ab2DWKNZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 06:13:25 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E96E75A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2012-04-23 at 12:07 +0200, Mohammed, Afzal wrote:
> Hi Tero,
> 
> With "this branch" you meant,
> 
> HEAD @ 297624c ARM: OMAP3: PM: Remove IO Daisychain control from cpuidle,
> 
> right ? (the one Paul suggested to try)

Yeah, thats right. My patch applies right on top of it.

-Tero

> 
> Regards
> Afzal
> 
> On Mon, Apr 23, 2012 at 14:54:04, Kristo, Tero wrote:
> > On Fri, 2012-04-06 at 07:52 +0000, Mohammed, Afzal wrote:
> > > Hi Paul,
> > > 
> > > On Fri, Apr 06, 2012 at 12:43:06, Paul Walmsley wrote:
> > > > Perhaps you might be willing to add some debugging to omap_mux_late_init() 
> > > > to find out what part of that function is causing it to hang?
> > > 
> > > It is getting hung as interrupt handler "omap_hwmod_mux_handle_irq"
> > > is being repeatedly called.
> > > 
> > 
> > Hi Afzal,
> > 
> > can you try the attached patch with this branch and omap3evm board? I
> > don't have the board myself so I can't test it myself (I tested this
> > with omap3beagle and it works with that one.)
> > 
> > -Tero
> > 
> > 
> 


