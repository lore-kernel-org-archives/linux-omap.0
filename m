From: Tony Lindgren <tony@atomide.com>
Subject: Re: Padconf not working on pm_defconfig?
Date: Mon, 14 Dec 2009 11:26:30 -0800
Message-ID: <20091214192630.GA4575@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4EFC@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E739404372AAB54@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4F0F@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4F23@dbde02.ent.ti.com>
 <87fx7dcx8k.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C86409@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62791 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757102AbZLNT0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 14:26:36 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309C86409@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter De Schrijver <peter.de-schrijver@nokia.com>

* Gadiyar, Anand <gadiyar@ti.com> [091214 09:07]:
> Kevin Hilman wroteL
> > >
> > > Found it - I remember that these lines are muxed with ETK signals
> > > and with the hwdebug signals.
> > >
> > > So I looked at the debobs driver - and that's the culprit!
> > > (Cc-ing the author of that driver)
> > >
> > > How should this be handled? IMO, this driver has should use the
> > > MUX framework for changing the mux modes.
> > >
> > > What say?
> > 
> > Yes, the debobs driver needs to be updated to use the MUX API.
> > 
> > But even with that, AFAICT, the new mux API will still allow
> > the last caller to "win" as there is no request/free API
> > to get pins.
> > 
> 
> At least the debug prints would have pointed me to this driver.
> 
> Okay, I'll try and cook something up for updating the debobs driver.

Sounds like debobs should only set the pins based on platform_data
passed from the board-*.c file. Then maybe allow override from
cmdline on boards that have both debobs and ehci?

Regards,

Tony
