From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] USB: ohci-omap - avoid including mach/irqs.h
Date: Sat, 27 Aug 2016 14:51:19 +0200
Message-ID: <20160827125119.GB24415@kroah.com>
References: <20160826164351.GV5783@n2100.arm.linux.org.uk>
 <Pine.LNX.4.44L0.1608261319550.1794-100000@iolanthe.rowland.org>
 <20160826180519.GW5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160826180519.GW5783@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 26, 2016 at 07:05:19PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 26, 2016 at 01:20:53PM -0400, Alan Stern wrote:
> > On Fri, 26 Aug 2016, Russell King - ARM Linux wrote:
> > 
> > > On Mon, Aug 22, 2016 at 11:28:21AM -0400, Alan Stern wrote:
> > > > On Fri, 19 Aug 2016, Russell King wrote:
> > > > 
> > > > > ohci-omap doesn't need to include mach/irqs.h - nothing within this
> > > > > driver needs anything from this header file.  Remove this include.
> > > > > 
> > > > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > > > ---
> > > > >  drivers/usb/host/ohci-omap.c | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> > > > > index de7c68602a7e..495c1454b9e8 100644
> > > > > --- a/drivers/usb/host/ohci-omap.c
> > > > > +++ b/drivers/usb/host/ohci-omap.c
> > > > > @@ -36,7 +36,6 @@
> > > > >  #include <mach/mux.h>
> > > > >  
> > > > >  #include <mach/hardware.h>
> > > > > -#include <mach/irqs.h>
> > > > >  #include <mach/usb.h>
> > > > 
> > > > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > Thanks.  Will Greg be picking this up?
> > 
> > Yes, he should.  Unless you want it to go via a different tree...
> 
> I'm fine with Greg picking this (and the other two) up as none
> of my (increasing) patch stack depends on these patches.

Ok, I'll take it in my next round, thanks.

greg k-h
