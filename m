From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Wed, 11 Mar 2009 21:30:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903112118140.26959@utopia.booyaka.com>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com> <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com> <20090310005222.GE19758@fluff.org.uk> <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com> <20090311235908.GC19038@gandalf>
 <alpine.DEB.2.00.0903111804510.26959@utopia.booyaka.com> <20090312002353.GD19038@gandalf>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090312002353.GD19038@gandalf>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: Ari Kauppi <Ext-Ari.Kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Thu, 12 Mar 2009, Felipe Balbi wrote:

> This is the link where Ingo discusses why !IRQF_DISABLED could cause
> stack overflow:
> 
> http://lkml.org/lkml/2009/3/3/71
> 
> You probably wanna take a look at the whole thread to figure out the
> discussion, but basically Ingo and Peter (Zijlstra) believe
> !IRQF_DISABLED is a bug and drivers needing that probably should be
> using threaded irqs (which is not yet merged) or the hw is broken, and
> for those an IRQF_ENABLED flag will be created and a TAINT will also be
> placed.
> 
> Once that gets merged, all drivers will be forced (at some point) to
> IRQF_DISABLED and those which don't want that will be moved gradually to
> threaded irq.
> 
> This patch is also interesting:
> 
> http://lkml.org/lkml/2009/3/2/33

Thanks for the links.  Those issues are indeed distinct from the spurious 
IRQ problem that Ari is reporting.


- Paul
