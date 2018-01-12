From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression in next
Date: Fri, 12 Jan 2018 06:14:56 -0800
Message-ID: <20180112141456.GB4821@atomide.com>
References: <20180112000037.GA3875@atomide.com>
 <20180112013257.GB4059@atomide.com>
 <4913146.sVL6sFxzC8@aspire.rjw.lan>
 <4745593.FguGN2uIkX@aspire.rjw.lan>
 <e7a673e1-b28d-f84e-c6c1-c5b896e92aeb@metafoo.de>
 <20180112131623.GA29734@lunn.ch>
 <20180112135203.GA4821@atomide.com>
 <20180112135526.GC29734@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112135526.GC29734@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux PM <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Andrew Lunn <andrew@lunn.ch> [180112 13:55]:
> > Thanks that fixes the suspend error. And I was able to confirm
> > that the suspend power consumption is OK.
> > 
> > That still leaves the mystery of the runtime idle power consumption
> > being much higher with commit e130bc1d00a4.
> 
> Did you re-measure the runtime power? Do you have an unused PHY? It
> could be it is not getting shut down. 1G PHYs can be quite power
> hungry.

Yes this is a different issue, the increase in runtime PM
consumption measurement I'm measuring is for a SoM board.
It contains the SoC + memory + PMIC and few devices. The
Ethernet controller is on a separate optional base board
and not related to the runtime PM issue.

Regards,

Tony
