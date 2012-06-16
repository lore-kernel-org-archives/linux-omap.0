From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Sat, 16 Jun 2012 09:15:23 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99A9E7@DBDE01.ent.ti.com>
References: <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
 <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
 <4FD8A906.8080202@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999582@DBDE01.ent.ti.com>
 <4FD9E5AF.6010201@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999CA6@DBDE01.ent.ti.com>
 <4FDA3464.4040704@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A511@DBDE01.ent.ti.com>
 <20120615124520.GS12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35457 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab2FPJPd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jun 2012 05:15:33 -0400
In-Reply-To: <20120615124520.GS12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Fri, Jun 15, 2012 at 18:15:20, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120615 03:26]:

> > Here clock is required even before driver is probed, i.e for platform to
> > calculate timings, that has to be passed through platform data.
> 
> Eventually we should be able to move the gpmc registration to the driver
> probe, especially with device tree. There's no need to set up gpmc
> before the driver probe runs for the device using gpmc. Just how the
> gpmc init gets called from the driver probe is still a bit open though..

Sorry, I did not get you, can you please clarify

By gpmc registration, if you meant registering platform device for
gpmc peripherals, for a board that uses the new gpmc driver interface*,
it will be done in probe only.

All the responsibilities of old gpmc init is now taken care by probe;
probe in addition does setting up gpmc for each peripheral, registering
platform device (if the board makes use of new driver interface). If
a board uses new gpmc driver interface, gpmc for that device is not
setup before gpmc probe.

> It may require some bus level hooks, or wrapper drivers for the generic
> device drivers like smsc911x.

This too, not sure whether I follow you

>  
> > I understand the necessity for clk rate information in driver, but seems
> > unless we have a generic way to scale timings for all the kinds of
> > peripheral, having it may not be of much help.
> 
> We should not need to pass clock handles around. It's better to
> export some helper functions in the gpmc code for the calculation.

Currently we have helper function in gpmc.c for the same, were you
referring those ?

Regards
Afzal

*: [1] converts omap3evm & beagle board to use new interface, in addition
 to [1], similar to it, one more series would be posted to convert remaining
 boards also to use the new gpmc driver interface. As these cannot be tested
 by me and as it depends on final shape of this basic driver conversion
 series (or the present series), they have not yet been converted

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69917.html

