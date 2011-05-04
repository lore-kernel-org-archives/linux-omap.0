From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 04/12] Serial: OMAP: Add runtime pm support for
 omap-serial driver
Date: Wed, 4 May 2011 15:05:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1105041503260.30136@utopia.booyaka.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com> <1304080796-625-5-git-send-email-govindraj.raja@ti.com> <87hb9aqk53.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87hb9aqk53.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Govindraj,

On Wed, 4 May 2011, Kevin Hilman wrote:

> "Govindraj.R" <govindraj.raja@ti.com> writes:
> 
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -189,6 +189,21 @@ static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
> >  	}
> >  }
> >  
> > +static void omap_uart_wakeup_enable(struct platform_device *pdev, bool enable)
> > +{
> > +	struct omap_uart_port_info *up = pdev->dev.platform_data;
> > +
> > +	/* Set or clear wake-enable bit */
> > +	if (up->wk_en && up->wk_mask) {
> > +		u32 v = __raw_readl(up->wk_en);
> > +		if (enable)
> > +			v |= up->wk_mask;
> > +		else
> > +			v &= ~up->wk_mask;
> > +		__raw_writel(v, up->wk_en);
> > +	}
> > +}

To be a little more direct: there should be no PRCM register interactions 
in the driver, absolutely none.  This stuff needs to go through 
omap_device/omap_hwmod functions if it's really needed.


- Paul
