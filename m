From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP2430: MUSB: Ethernet Gadget Issue
Date: Thu, 29 Nov 2007 13:07:50 -0800
Message-ID: <200711291307.50717.david-b@pacbell.net>
References: <F3AC19E99E5D024AB9E6FB2A01683D8A02C381EE@dlee10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <F3AC19E99E5D024AB9E6FB2A01683D8A02C381EE@dlee10.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Foale, Jeff" <j-foale@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thursday 29 November 2007, Foale, Jeff wrote:
> We discovered the root cause is that on the OMAP TX side, a DMA transfer
> is initiated but never completes due to the completion interrupt never
> happening.
> 
> We still do not know why the interrupt doesn't happen.

Curious.  On DaVinci I observed similar problems ... at best,
documentation on the synchronization between DMA and rest of
the chip is incomplete, and in some cases the behavior seemed
more than a little bit confused.

Does that INVENTRA_DMA logic *really* need to be so different
from support for the two other DMA engines?  Seeing three very
different chunks of DMA logic has always made me suspicious.
I don't want to believe that the DMA integration is so wildly
unconstrained that each silicon team *needed* incompatibility.

- Dave



> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
> David Brownell
> Sent: Friday, November 23, 2007 2:27 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Re: OMAP2430: MUSB: Ethernet Gadget Issue
> 
> Your test scenario sounds not unlike the "run TTCP in both
> directions" test, except that it uses UDP.  The last time
> I ran that test with the MUSB code was with DaVinci ... at
> that time, it worked OK.  That's older RTL than found in
> the OMAP chips, and thus "different bugs".
> 
> Not entirely for kicks, it would be good to know whether
> the use of TTCP vs your test program matters.  TCP does
> have some flow control, afster all!
> 
> 
> On Wednesday 21 November 2007, Hunter, Jon wrote:
> >	 
> > When I run the applications one at a time, they will run all night and
> > all is well. However, when I run them at the same time the transfer
> will
> > stop after anywhere from a few secs to a few minutes. When the
> transfers
> > stop I observe the the MUSB driver is no longer generating interrupts
> > (viewing the /proc/interrupts). It appears to be some short of race
> > condition but I have not been able to track down exactly when things
> > stop.
> 
> A "cat /proc/driver/musb_hdrc" to see various state should
> be informative.
> 
> - Dave
> 
> 
