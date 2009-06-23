From: David Brownell <david-b@pacbell.net>
Subject: Re: musb otg changes break booting on omaps
Date: Tue, 23 Jun 2009 15:50:08 -0700
Message-ID: <200906231550.08495.david-b@pacbell.net>
References: <20090623125700.GM7352@atomide.com> <19F8576C6E063C45BE387C64729E739404327A1514@dbde02.ent.ti.com> <20090623161040.GC23234@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n22a.bullet.mail.mud.yahoo.com ([68.142.207.188]:27436 "HELO
	n22a.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754449AbZFWWz3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jun 2009 18:55:29 -0400
In-Reply-To: <20090623161040.GC23234@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com, Tony Lindgren <tony@atomide.com>
Cc: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@atomide.com" <linux-usb@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 23 June 2009, Felipe Balbi wrote:
> 
> > > Looks like commit 84e250ffa76dddc1bad84e04248a27f442c25986
> > > "musb: proper hookup to transceiver drivers" breaks booting on omaps
> > > if no transceiver is configured. Got any patches for that?
> > 
> > Tony,
> > 
> > Is this on OMAP35x EVM? If so then the below patch should help.
> > 
> > http://marc.info/?l=linux-omap&m=123907915211910&w=2

The problem with that patch is that the transceiver config is
board-specific.  So the omap2430.c change is wrong.

Just register the NOP transceiver in the EVM setup code.


> and omap3x30-based hardware will most likely use twl4030-usb and in some
> cases (like evm) use the no-op trasceiver.

I think I've got an SX51 patch somewhwere, I'll dig it up.

- Dave


