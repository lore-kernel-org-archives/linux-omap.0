From: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Thu, 18 Oct 2012 09:51:13 +0300
Message-ID: <1350543073.2014.35.camel@kj-X230>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
	 <87ipag90om.fsf@deeprootsystems.com>
	 <20121017160200.GA6567@arwen.pp.htv.fi>
Reply-To: kalle.jokiniemi-ieSKYCWCyXoAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121017160200.GA6567-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

ke, 2012-10-17 kello 19:02 +0300, Felipe Balbi kirjoitti:
> Hi,
> 
> On Thu, Oct 11, 2012 at 02:08:25PM -0700, Kevin Hilman wrote:
> > Hi Kalle,
> > 
> > Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org> writes:
> > 
> > > The resume_noirq enables interrupts one-by-one starting from
> > > first one. Now if the wake up event for suspend came from i2c
> > > device, the i2c bus irq gets enabled before the threaded
> > > i2c device irq, causing a flood of i2c bus interrupts as the
> > > threaded irq that should clear the event is not enabled yet.
> > >
> > > Fixed the issue by adding suspend_noirq and resume_early
> > > functions that keep i2c bus interrupts disabled until
> > > resume_noirq has run completely.
> > >
> > > Issue was detected doing a wake up from autosleep with
> > > twl4030 power key on N9. Patch tested on N9.
> > >
> > > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
> > 
> > This version looks good, thanks for the extra comments.
> > 
> > Reviewed-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> > Tested-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> > 
> > Wolfram, This should also probably be Cc'd to stable since it affects
> > earlier kernels as well.  Thanks,
> 
> just to make sure we're not fixing the wrong problem... does [1] help in
> any way ?

Yes, I was fixing the wrong problem, this patch is obsolete. But the
problem was in the TWL interrupt handling (PIH was run before SIH), not
in i2c. See my other patch "twl4030: Fix chained irq handling on resume
from suspend"

> 
> [1] http://marc.info/?l=linux-omap&m=135048839915719&w=2
> 

Could be related, though if I understood correctly, that runtime pm
stuff gets run at noirq phase, so it probably does not help.

- Kalle
