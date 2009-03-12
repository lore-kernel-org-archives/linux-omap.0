From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Wed, 11 Mar 2009 18:07:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903111804510.26959@utopia.booyaka.com>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com> <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com> <20090310005222.GE19758@fluff.org.uk> <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com>
 <20090311235908.GC19038@gandalf>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090311235908.GC19038@gandalf>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: Ari Kauppi <Ext-Ari.Kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Thu, 12 Mar 2009, Felipe Balbi wrote:

> On Wed, Mar 11, 2009 at 05:55:50PM -0600, Paul Walmsley wrote:
> > Ben's right, there shouldn't be any need for this.  This patch could cause
> > some unnecessary interrupt service latency.
> 
> That's not what Thomas Gleixner thinks. How about the possibility of
> stack overflow ?

That sounds like a separate issue from the spurious IRQ problem that the 
patch was intended to fix.   

I'm not familiar with the discussion on the stack overflow issue.  Could 
you send a link?

> According to Thomas (and Ingo, I'd say) all drivers should call
> request_irq() with IRQF_DISABLED and that's gonna be true as soon as the
> threaded irq handler support gets merged, if I'm not wrong.


- Paul
