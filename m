From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH REBASE 0/6] i2c: omap: misc changes
Date: Wed, 23 Jan 2013 10:58:13 +0100
Message-ID: <20130123095813.GG3767@nekote.pengutronix.de>
References: <1355502849-9289-1-git-send-email-balbi@ti.com>
 <20130114191628.GB9402@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130114191628.GB9402-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 14, 2013 at 09:16:28PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Dec 14, 2012 at 06:34:03PM +0200, Felipe Balbi wrote:
> > this is just a rebase of the previous series adding support
> > for amount of bytes transferred upon NACK.
> > 
> > Well, actually the patches implementing transferred bytes
> > reporting aren't here because we need to discuss how to move
> > forward.
> > 
> > This series is just a preparation for that, but it also
> > contains a at least one bugfix.
> > 
> > Each and every patch has been tested with pandaboard, it
> > would be nice to get Tested-bys from other folks on other
> > platforms before pushing this for v3.9 (there's more than
> > enough time for that).
> > 
> > Note that we're also dropping b_hw flag since that becomes
> > useless since we'll never set STT and STP together anymore.
> > 
> > Give it a good round of test, please.
> 
> Wolfram, I have these patches rebased on top of v3.8-rc3 if you wish.
> Let me know if I should resend them (again).

Yes, please rebase on top of Aaro's patches (probably in v3.8-rc5).
Patches look mostly good, have to think more about what Patch 5 is
wanting to achieve at the end of the day.
