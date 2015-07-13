From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: dra7x-evm: Prevent glitch on DCAN1 pinmux
Date: Sun, 12 Jul 2015 23:29:06 -0700
Message-ID: <20150713062906.GA26485@atomide.com>
References: <1436279277-3386-1-git-send-email-rogerq@ti.com>
 <1436279277-3386-3-git-send-email-rogerq@ti.com>
 <559EBEC8.1070609@pengutronix.de>
 <55A2BD97.8080006@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55A2BD97.8080006@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Roger Quadros <rogerq@ti.com>, wg@grandegger.com, jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Marc Kleine-Budde <mkl@pengutronix.de> [150712 12:22]:
> On 07/09/2015 08:34 PM, Marc Kleine-Budde wrote:
> > On 07/07/2015 04:27 PM, Roger Quadros wrote:
> >> Driver core sets "default" pinmux on on probe and CAN driver
> >> sets "sleep" pinmux during register. This causes a small window
> >> where the CAN pins are in "default" state with the DCAN module
> >> being disabled.
> >>
> >> Change the "default" state to be like sleep so this glitch is
> >> avoided. Add a new "active" state that is used by the driver
> >> when CAN is actually active.
> > 
> > Who is taking care of this patch? I'm applying 1/2 (v2) to linux-can,
> > should I take this patch, too?
> 
> I've included this patch in my pull request.

That's fine thanks there should not be any merge conflicts.

For things going in during the merge windows we need to worry
about the dts merge conflicts. Usually not a problem for fixes.

Regards,

Tony
