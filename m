From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4430 SDP with KS8851: very slow networking
Date: Fri, 7 Dec 2018 11:03:12 -0800
Message-ID: <20181207190312.GT6707@atomide.com>
References: <20181206132256.GT30658@n2100.armlinux.org.uk>
 <20181206163154.GK6707@atomide.com>
 <20181206180806.GV6920@n2100.armlinux.org.uk>
 <20181206221447.GM6707@atomide.com>
 <20181207180020.GA9507@n2100.armlinux.org.uk>
 <20181207181420.GS6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181207181420.GS6707@atomide.com>
Sender: netdev-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [181207 18:14]:
> Hi,
> 
> * Russell King - ARM Linux <linux@armlinux.org.uk> [181207 18:01]:
> > Hi Tony,
> > 
> > You know most of what's been going on from IRC, but here's the patch
> > which gets me:
> > 
> > 1) working interrupts for networking
> > 2) solves the stuck-wakeup problem
> > 
> > It also contains some of the debug bits I added.
> 
> This is excellent news :) Will test today.

Yes your patch seems to work great based on brief testing :)

> > I think what this means is that we should strip out ec0daae685b2
> > ("gpio: omap: Add level wakeup handling for omap4 based SoCs").
> 
> Yes the only reason for the wakeup quirk was the stuck wakeup
> state seen on omap4, it can be just dropped if this works.
> Adding Grygorii to Cc too.

I'll post a partial revert for commit ec0daae685b2 ("gpio: omap:
Add level wakeup handling for omap4 based SoCs") shortly.

Thanks,

Tony
