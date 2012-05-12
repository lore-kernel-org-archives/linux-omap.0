From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4-alt 3/6] ARM: OMAP3: hwmod data: add gpmc
Date: Sat, 12 May 2012 04:23:18 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98B514@DBDE01.ent.ti.com>
References: <cover.1335941443.git.afzal@ti.com>
 <99ffbbcc634022ed3c781c37e03989f1d898003e.1335941444.git.afzal@ti.com>
 <alpine.DEB.2.00.1205051949290.20926@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987188@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205080915220.9984@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98A2F3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54849 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab2ELEXZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 May 2012 00:23:25 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E98A2F3@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

On Thu, May 10, 2012 at 11:33:44, Mohammed, Afzal wrote:
> Hi Paul,
> 
> On Tue, May 08, 2012 at 21:02:33, Paul Walmsley wrote:
> 
> > > Major reason was that there are some boards that rely on bootloader
> > > settings, eg. kernel does not do any setting for smsc911x. I did not
> > > want to break those, at least it causes problem with omap3evm, see below
> > 
> > But this is the whole point.  The Linux GPMC driver and integration code 
> > should be setting up the GPMC registers based on board file and/or DT 
> > data, before the kernel touches any GPMC devices.
> > 
> > We don't want to rely on the bootloader settings unless we absolutely have 
> > no other choice.  Otherwise, the stability of the kernel could easily be 
> > impacted by the bootloader's GPMC timings and other register settings, and 
> > we want to minimize those potential sources of variation.
> > 
> > So if we absolutely have no choice than to keep HWMOD_INIT_NO_RESET here, 
> > which doesn't sound like the case so far, we need to understand exactly 
> > why this is so.
> 
> There are 14 out of 20 boards partially or fully relying on bootloader
> settings. I will try to do configuration for smsc911x in Kernel itself,
> this is the only one that can be tested from my side (on omap3evm), but
> there are other peripherals like NOR, quaduart, onenand-flash (different
> from omap-onenand), then smc91x (timings are not set from kernel for
> sdp boards), these would affect 7 boards of both omap2 & omap3. To
> get configuration done from Kernel properly without having these boards
> is too tough for me.
> 
> So I request you to keep HWMOD_INIT_NO_RESET (I will add configuration
> for smsc911x), please let me know your comments.

ping

Regards
Afzal
