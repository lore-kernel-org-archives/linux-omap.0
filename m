From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] OMAP3EVM: Made backlight GPIO default state to off
Date: Mon, 12 Apr 2010 17:17:39 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E053D82@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1269263470-13814-1-git-send-email-hvaibhav@ti.com>
	 <1270122886.2704.100.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044DF7EF68@dbde02.ent.ti.com>
 <1270128754.2704.107.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45143 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030Ab0DLLry convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Apr 2010 07:47:54 -0400
In-Reply-To: <1270128754.2704.107.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, April 01, 2010 7:03 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: RE: [PATCH 1/2] OMAP3EVM: Made backlight GPIO default state to off
> 
> On Thu, 2010-04-01 at 14:11 +0200, ext Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > Sent: Thursday, April 01, 2010 5:25 PM
> > > To: Hiremath, Vaibhav
> > > Cc: linux-omap@vger.kernel.org; tony@atomide.com
> > > Subject: Re: [PATCH 1/2] OMAP3EVM: Made backlight GPIO default state to
> off
> > >
> > > Hi,
> > >
> > > On Mon, 2010-03-22 at 14:11 +0100, ext hvaibhav@ti.com wrote:
> > > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > > >
> > > > If you choose default output to DVI, the LCD backlight still
> > > > gets powered, since panel->disable function never gets called for LCD.
> > > >
> > > > So, during init put backlight GPIO to off state and the driverr
> > > > code will decide which output to enable explicitly.
> > >
> > > I'm not sure I understand this patch. You talk about choosing default
> > > output (via kernel boot args, I presume),
> > [Hiremath, Vaibhav] yes you are correct. I am talking about default output
> selection using bootargs.
> >
> > > but the code checks for EVM
> > > revision. What is the connection between EVM revision and selecting
> > > display output?
> > [Hiremath, Vaibhav] Ohh ok, I think you are not aware that we do have 2
> version of EVM's. EVM-1 with positive (backlight gpio) polarity and EVM-2
> with negative (backlight gpio) polarity.
> >
> > The code is doing exactly same.
> 
> Ok. But I still don't understand the relation with the patch comment,
> and the code. Shouldn't you anyway initialize the backlight gpio
> properly depending on the EVM revision, no matter if DVI is the default
> output or not?
[Hiremath, Vaibhav] Yes, exactly that's what this patch does. During bootup, when board_init function gets executed this patch puts the default state of LCD backlight to off.
I just tried to explain the scenario where this change is required, where the default output is DVI out and init code as usual will put LCD backlight to on state (keeping it on infinitely).

> 
> Perhaps the comment could be clarified. But the code looks fine:
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> 

[Hiremath, Vaibhav] Thanks for Acking.

Tony,

Can we merge this patch? This patch still gets applied cleanly on top of linux-omap/master, so should not be an issue at all. 
Also similar patch is submitted for AM3517 that should also get merged.


Thanks,
Vaibhav

>  Tomi
> 

