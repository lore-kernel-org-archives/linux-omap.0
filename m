From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v9 01/25] gpio/omap: remove dependency on gpio_bank_count
Date: Thu, 2 Feb 2012 12:16:30 -0700
Message-ID: <20120202191630.GT15343@ponder.secretlab.ca>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
 <1328203851-20435-2-git-send-email-tarun.kanti@ti.com>
 <20120202184106.GC29215@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120202184106.GC29215@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 02, 2012 at 08:41:07PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Feb 02, 2012 at 11:00:27PM +0530, Tarun Kanti DebBarma wrote:
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index 0b05629..6ea7390 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -28,7 +28,10 @@
> >  #include <asm/gpio.h>
> >  #include <asm/mach/irq.h>
> >  
> > +static LIST_HEAD(omap_gpio_list);
> 
> I guess it's now too late because patch is acked and everything, but I
> think if you make the driver handle one bank alone and just instantiate
> it multiple times (omap_gpio.0, omap_gpio.1, omap_gpio.3, etc) driver
> would be faaaaaar simpler.

Is there any shared state between the banks?  On my very cursory glance it
looked like banks still have some interaction between them.  If not, then
yes I agree that multiple instances would be better.

g.
