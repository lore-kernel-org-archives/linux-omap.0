From: "B, Ravi" <ravibabu@ti.com>
Subject: RE: [PATCH 0/5] usb: musb: am335x support
Date: Thu, 4 Apr 2013 05:10:43 +0000
Message-ID: <6C6B28D4DC342643927BEAFCE8707BF63EAA07D7@DBDE01.ent.ti.com>
References: <51312430.6060306@gmail.com> <87sj4cunp6.fsf@dell.be.48ers.dk>
 <5133E268.5010604@gmail.com> <51388D64.9000005@gmail.com>
 <513A1580.90303@gmail.com> <514863BD.5010503@gmail.com>
 <87620nwmd2.fsf@dell.be.48ers.dk> <515C19D7.6080702@gmail.com>
 <20130403120454.GX25837@arwen.pp.htv.fi> <515C23D4.3010206@gmail.com>
 <20130403130807.GB14680@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50343 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763299Ab3DDFLH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 01:11:07 -0400
In-Reply-To: <20130403130807.GB14680@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Daniel Mack <zonque@gmail.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, "Mohammed, Afzal" <afzal@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Santhapuri, Damodar" <damodar.santhapuri@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

Felipe

> 
> Hi,
> 
> On Wed, Apr 03, 2013 at 02:43:00PM +0200, Daniel Mack wrote:
> > On 03.04.2013 14:04, Felipe Balbi wrote:
> > > On Wed, Apr 03, 2013 at 02:00:23PM +0200, Daniel Mack wrote:
> >
> > >> Felipe, could you explain the background on how the dsps driver is
> > >> supposed to work in host mode at boot time with the rework of the
> driver
> > >> you did for 3.7? It might just be me not understanding the rationale
> > >> behind all these changes, but appearantly, I'm not the only one who's
> > >> affected by that.
> > >
> > > right, so the idea with that was to drop the huge amount of ifdeferry
> > > hack from the MUSB driver. It would be great if someone would send
> > > *CLEAN* patches adding Kconfig-based role choices again.
> >
> > Are Kconfig-based rules really what we want here after all? Wouldn't
> > run-time configured settings make much more sense, considering that
> 
> we need both. Say that you want to build a product with MUSB hardwired
> as host, why would you enable gadget framework ?
> 
> I can think of at least am335x where this would be perfectly plausible
> (no EHCI available, only MUSB).
> 
> > people might want to run a single kernel image on multiple platforms? I
> > believe it should be up to the DT to define the actual hardware wiring.
> 
> Right, for runtime decision Ravi pointed me to a patch implementing that
> (Ravi, could you post it by any chance as RFC ?) which we could start a
> discussion and hopefully merge for v3.11

Ok. 

--
Ravi B
