From: David Brownell <david-b@pacbell.net>
Subject: RE: [PATCH] ARM: OMAP: Fix board data to support device only, host only and OTG roles.
Date: Thu, 20 May 2010 08:40:19 -0700 (PDT)
Message-ID: <447725.43123.qm@web180306.mail.gq1.yahoo.com>
References: <19F8576C6E063C45BE387C64729E7394044DCC5F46@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n3-vm1.bullet.mail.gq1.yahoo.com ([67.195.23.157]:43116 "HELO
	n3-vm1.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752146Ab0ETPkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 11:40:20 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DCC5F46@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maulik OjasMankad <x0082077@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ajay KumarGupta <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>


> > Subject: [PATCH] ARM: OMAP: Fix board data to support
> device only, host only and OTG roles.
> 
> > Fix board data to support device only, host only and
> OTG roles.
> 
>  >The board data hardcodes the mode to OTG or
> Peripheral.

Or host.  That's correct... because the *BOARD* is hard-wired
 that way.  Based on what connector is present, the driver uses
that board-specific data to ensure it's exposing the right
capabilities.  (Example, a host-only board won't expose either
OTG or peripheral capabilities, etc.)


>  >This fix will allow to use Peripheral, Host and OTG
>  >roles independently.

The driver has had that capability almost forever...

If you're saying that somebody broke the mode setup logic in the
driver, which originally tested the board capabilities before it
enabled the relevant driver capabilities, then the solution is to
un-break that code ... not to further break it.

ISTR it was pretty straightforward: boards with a host or peripheral
connector could only enter that driver mode, but boards with an OTG
connector could enter either driver mode.  This affected initialization
(one or both sides of the USB stack needed initialization before the
driver could properly start) as well as role switching at runtime
(either based on ID-sensing in the connector, or HNP).

As of something like a year and a half ago, the cable based role switching worked pretty well (ID sensing) and HNP behaved at least
partially, although there were some OTG conformance test failures
(timing etc, but the roles did switch correctly via HNP, verified
with both OMAP3 and DaVinci boards).

Now the PITA was that the Mentor IP doesn't clearly document some of
the key initialization or role switching steps.  I recall losing over
a month trying to make sense of what they wanted, since their state
machine didn't match the OTG spec.  I could easily believe that some
patch broke that again.  Which means someone might need to bisect
things to fix a bug they inserted...  Peripheral mode init was fragile to an extreme; changing the sequence was almost guaranteed to break
something.

