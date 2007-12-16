From: Tony Lindgren <tony@atomide.com>
Subject: Re: Re: [PATCH Resend 2/3] ARM: OMAP: Add support for TWL4030 USB
	Transceiver on OMAP34xx
Date: Sat, 15 Dec 2007 16:33:36 -0800
Message-ID: <20071216003336.GF7388@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A08805066708@dbde01.ent.ti.com>
	<7b2a1bbeba70d8b080c3473548bc83a6@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <7b2a1bbeba70d8b080c3473548bc83a6@felipebalbi.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [071214 09:18]:
> 
> 
> On Fri, 14 Dec 2007 22:24:02 +0530, "Gadiyar, Anand" <gadiyar@ti.com>
> wrote:
> >> > Index: linux-omap-dec10/drivers/i2c/chips/Makefile
> >> > ===================================================================
> >> > --- linux-omap-dec10.orig/drivers/i2c/chips/Makefile	
> >> 2007-12-14
> >> > 19:06:41.112941439 +0530
> >> > +++ linux-omap-dec10/drivers/i2c/chips/Makefile	2007-12-14
> >> > 19:12:45.826336129 +0530
> >> > @@ -17,8 +17,9 @@
> >> >  obj-$(CONFIG_GPIOEXPANDER_OMAP)	+= gpio_expander_omap.o
> >> >  obj-$(CONFIG_MENELAUS)		+= menelaus.o
> >> >  obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
> >> > -obj-$(CONFIG_TWL4030_CORE)      += twl4030_core.o
> >> > +obj-$(CONFIG_TWL4030_CORE)	+= twl4030_core.o
> >> 
> >> Changing spaces into tab?!? It should come as an extra-patch before or
> >> after usb series.
> > 
> > Can do. But is it really worth making it a separate patch, given that
> this
> > is 
> > not a functional change. If it were, I would gladly make it a separate
> > patch.
> > 
> > The idea behind separate patches is to keep functionally separate units
> > physically separate. In this case, I don't think that extra patch is
> going
> > to
> > add any extra value and the cost is the additional overhead of pushing
> > it.
> > 
> > In my opinion, the costs exceed the benefits and it is not worth the
> > time.
> > If you really insist, I'll make it a separate patch. (And this is not
> > lazy developer syndrome. :-) )
> 
> Well there isn't additional overhead at all as Tony will probably run
> "git-am mbox" and git will apply each patch by itself.
> The idea on providing a separate patch is that change has nothing to do
> with usb support on omap34xx. That's my opinion, let's wait someone else
> comment on this.
> 
> I'd rather see a separate patch but if Tony or any other guy here is ok
> with applying it together with your patch, I can live with it. ;-)


Yeah, let's do all clean-up as separate patches. The reason being that
we want to be able to use the patches as they are for sending upstream
also. Rewriting the patches for sending upstream is pointless work.

Tony
