From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: musb OTG broken in 2.6.29-rc3?
Date: Tue, 10 Feb 2009 16:34:26 +0200
Message-ID: <20090210163426.bb9c1420.jarkko.nikula@nokia.com>
References: <5e088bd90902090940s3c6de0eqac55e21acd4490bc@mail.gmail.com>
	<19F8576C6E063C45BE387C64729E739403FA81B5E5@dbde02.ent.ti.com>
	<5e088bd90902092043u913d35axe658e784d4befb59@mail.gmail.com>
	<19F8576C6E063C45BE387C64729E739403FA81B610@dbde02.ent.ti.com>
	<20090210073525.GE3166@scadufax.research.nokia.com>
	<20090210104634.40706b4f.jarkko.nikula@nokia.com>
	<5e088bd90902100627m746674d7mb7d929c584c7515a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43260 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbZBJOmj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 09:42:39 -0500
In-Reply-To: <5e088bd90902100627m746674d7mb7d929c584c7515a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Steve Sakoman <sakoman@gmail.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Tue, 10 Feb 2009 15:27:18 +0100
ext Steve Sakoman <sakoman@gmail.com> wrote:

> > But for me Beagle work. Ethernet gadget just fine and HS HUB by
> > kicking the session on.
> 
> What method did you use to kick the session on?  Was this always
> required?  I might be misremembering, but I seem to recall that
> plugging in a miniA cable resulted in musb automatically switching
> modes to host.
> 
I used Felipe's patch and "echo 1 >/sys/...musb_something/session". That
was required each time I reconnected the cable.

> Sorry for the perhaps stupid questions, I am *far* from being a USB
> expert :-)
> 
Me too :-)


Jarkko
