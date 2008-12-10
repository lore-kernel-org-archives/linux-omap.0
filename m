From: David Brownell <david-b@pacbell.net>
Subject: Re: status of USB on omap35xx ?
Date: Wed, 10 Dec 2008 10:28:25 -0800
Message-ID: <200812101028.25235.david-b@pacbell.net>
References: <1228870250.32014.148.camel@localhost.localdomain> <1228926833.32014.162.camel@localhost.localdomain> <20081210174030.GD9799@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:28447 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756521AbYLJS22 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Dec 2008 13:28:28 -0500
In-Reply-To: <20081210174030.GD9799@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

The OTG link is in usable shape, but the EHCI one isn't.


On Wednesday 10 December 2008, Felipe Balbi wrote:
> > 
> > What are the issues ? 

I have a prototype Overo and one issue there is that the
GPIO to let the EHCI port supply VBUS power isn't hooked
up!  I know how to modify that board, but somehow that
keeps slipping off my radar ... :)

I don't know the details, but the big problem with EHCI
on OMAP3 is evidently some kind of silicon issue that
shows up through the transceiver hookup and prevents the
link from being reliable.  I'm told that some boards using
that without a transceiver -- for on-board communication,
not for an external link -- have been successful.

Folk at TI were looking at those issues; I don't know if
they've been resolved yet, e.g. in the ES 3.0 silicon.


> It think it still has a problem during probe. If you read the driver
> you'll see there are some infinite while loops without timeout actions.
> And one of them is looping forever due to clock issues.
 
That's a newish problem, but is not -- from what I've
been told -- the Real Issue with EHCI on OMAP3.

- Dave


