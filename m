From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [PATCH] omapfb vsync support
Date: Tue, 28 Feb 2006 12:47:42 +0200
Message-ID: <1141123662.783.36.camel@mammoth.research.nokia.com>
References: <EA12F909C0431D458B9D18A176BEE4A50481E3A8@dlee02.ent.ti.com>
	<20060227223019.GA29436@localhost.localdomain>
	<6D300222-0883-4013-9E7D-8A827BB0D446@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <6D300222-0883-4013-9E7D-8A827BB0D446@google.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Mathias Agopian <mathias@google.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, 2006-02-27 at 15:27 -0800, ext Mathias Agopian wrote:
> Hello,
> 
> I'm the one to blame for the omapfb vsync patch :-)
> 
> > ["Woodruff, Richard" <r-woodruff2@ti.com>]
> >> How come there is no disable of the interrupt?
> >>
> >> Seems like at ioctrl the caller needs to be tracked so when he does a
> >> close the interrupt can be disabled.
> 
> I decided not to bother too much about tracking the clients because  
> the omapfb driver is not thread-safe in a lot of ways, which means it  
> cannot really support more than one client anyway (or in very basic  
> situations). In other words, I assumed there would only always be one  
> client.

Please be more specific. Then we could fix those places.

> 
> Nevertheless, we wouldn't really need to track the clients because I  
> think it would be fine to turn the IRQ off when any client closes the  
> driver (provided that no other client is currently waiting on it),  
> since it is re-enabled when a client calls the FBIO_WAITFORSYNC ioctl.
> 
> >> This will cause a VST enabled kernel to wake up for no good reason if
> >> there is no application requesting it anymore.  Someone pointed  
> >> out this
> >> fact to me recently while doing power measurements.  If you have a  
> >> low
> >> power screen saver mode this can mess up expected power savings.
> >
> > Hmm.  I wonder if there's some happy medium between disabling the
> > interrupt every time the ioctl returns and having to close and reopen
> > the driver when going into and returning from low power mode.
> >
> > Brian
> 
> Maybe we could simply disable the IRQ from the IRQ handler after a  
> second or so if no client has requested a FBIO_WAITFORSYNC ioctl?
> 
> That, combined with disabling the interrupt when a client closes the  
> driver should take care of most cases.
> 
> Alternatively, we could disable the IRQ each time, if it's not a too  
> heavy operation?

How about taking the lock for the IOCTL and handling the vsync
completely in the controller:

static int omapfb_wait_for_vsync(struct omapfb_device *fbdev)
{
	omapfb_rqueue_lock(fbdev);
	ctrl->vsync();
	omapfb_rqueue_unlock(fbdev);
}

And the controller could enable the IRQ wait for it then disable the
IRQ.

--Imre

> 
> On Feb 27, 2006, at 3:10 PM, Woodruff, Richard wrote:
> 
> > Two bits, one is I don't see the disable being called in the code when
> > you wake the process up.  I see you have the function, at interrupt  
> > wake
> > up time it should likely be disabled.
> 
> Yes, I added the function for completeness, I thought it might be  
> useful at some point (I thought the issue of not disabling it each  
> time would come up ;-) ).
> 
> 
> Mathias
> 
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
