From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Fri, 7 Aug 2015 19:32:30 +0100
Message-ID: <20150807183230.GW7576@n2100.arm.linux.org.uk>
References: <55C47DE1.9020902@ti.com>
 <55C48A1E.3070007@linutronix.de>
 <20150807132241.GN7576@n2100.arm.linux.org.uk>
 <55C4B5AE.10309@linutronix.de>
 <20150807135727.GP7576@n2100.arm.linux.org.uk>
 <55C4CA00.3060206@hurleysoftware.com>
 <20150807152939.GQ7576@n2100.arm.linux.org.uk>
 <55C4D7AF.8060305@hurleysoftware.com>
 <20150807163303.GS7576@n2100.arm.linux.org.uk>
 <55C4F747.1070604@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C4F747.1070604@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg KH <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 07, 2015 at 02:21:59PM -0400, Peter Hurley wrote:
> [ + Heikki ]
> 
> On 08/07/2015 12:33 PM, Russell King - ARM Linux wrote:
> > What you have is a race condition in the code you a responsible for
> > maintaining, caused by poorly implemented code.  Fix it, rather than
> > whinging about drivers outside of your subsystem having never implemented
> > _optional_ things that you choose to merge broken code which relied upon
> > it _without_ checking that the operation succeeded.
> > 
> > It is _entirely_ your code which is wrong here.
> > 
> > I will wait for that to be fixed before acking the omap-dma change since
> > you obviously need something to test with.
> 
> I'm not sure to what you're referring here.
> 
> A WARNing fixes nothing.

The warning can wait.

> If you mean some patch, as yet unwritten, that handles the dma cases when
> dmaengine_pause() is unimplemented without data loss, ok, but please confirm
> that's what you mean.

But the regression needs fixing.

> However, at some point one must look at the api and wonder if the separation
> of concern has been drawn in the right place.

It _is_ in the right place.  dmaengine_pause() always has been permitted
to fail.  It's the responsibility of the user of this API to _check_ the
return code to find out whether it had the desired effect.  Not checking
the return code is a bug in the caller's code.

If that wasn't the case, dmaengine_pause() would have a void return type.
It doesn't.  It has an 'int' to allow failure, or to allow non-
implementation for cases where the underlying hardware can't pause the
channel without causing data loss.

What would you think is better: an API which silently loses data, or
one which refuses to stop the transfer and reports an error code back
to the caller.

You seem to be arguing for the former, and as such, there's no way I
can take you seriously.

In any case, Greg has now commented on the patch adding the feature,
basically refusing it for stable tree inclusion.  So the matter is
settled: omap-dma isn't going to get the pause feature added in stable
trees any time soon.  So a different solution now needs to be found,
which is what I've been saying all along...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
