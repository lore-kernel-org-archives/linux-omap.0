From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] To Cleanup TWL-Core driver
Date: Fri, 10 Aug 2007 02:28:20 -0700
Message-ID: <20070810092819.GL8658@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47016A3486@dlee13.ent.ti.com>
	<46A88273.6090305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46A88273.6090305@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <menon.nishanth@gmail.com> [070726 04:21]:
> Syed Mohammed, Khasim stated on 7/25/2007 7:19 PM:
> > diff -purN linux-omap/include/asm-arm/arch-omap/twl4030.h lin_for_mmc/include/asm-arm/arch-omap/twl4030.h
> >  
> > +/*
> > + * Exported TWL4030 GPIO APIs
> > + */
> > +int twl4030_get_gpio_datain(int gpio);
> > +int twl4030_request_gpio(int gpio);
> > +int twl4030_set_gpio_edge_ctrl(int gpio, int edge);
> > +int twl4030_set_gpio_debounce(int gpio, int enable);
> > +int twl4030_free_gpio(int gpio);
> > +
> >  #endif /* End of __TWL4030_H */
> > _______________________________________________
> >   
> I think twl4030.h is a shared header & twlgpio driver is independent of
> twl core driver. if i disable this, there wont be even a warning for the
> file using this apis. why dont we cover them with the CONFIG macro for
> twl gpio? - Am not sure if that is acceptable as per coding standards OR
> if we need to create another shared header??...

Do you have a patch to combine the headers?

Pushing Khasim's patch today.

Tony
