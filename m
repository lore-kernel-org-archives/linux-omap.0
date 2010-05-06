From: "Arce, Abraham" <x0066660-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 2/3] OMAP4: Ethernet: KS8851
	Board Support
Date: Wed, 5 May 2010 23:18:52 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DEEC1CE@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043DEEB8C1@dlee03.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F8C7096@dbde02.ent.ti.com>
	<27F9C60D11D683428E133F85D2BB4A53043DEEB8D1@dlee03.ent.ti.com>
	<20100505171938.GX29604@atomide.com>
	<27F9C60D11D683428E133F85D2BB4A53043DEEC153@dlee03.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F8C74CE@dbde02.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F8C74DE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C74DE-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Manjunath,

> > > > > > > +
> > > > > > > +static void omap_ethernet_init(void)
> > > > > > > +{
> > > > > > > +	gpio_request(ETHERNET_KS8851_POWER_ENABLE, "ethernet");
> > > > > > > +	gpio_direction_output(ETHERNET_KS8851_POWER_ENABLE, 1);
> > > > > > > +	gpio_request(ETHERNET_KS8851_QUART, "quart");
> > > > > > > +	gpio_direction_output(ETHERNET_KS8851_QUART, 1);
> > > > > > > +	gpio_request(ETHERNET_KS8851_IRQ, "ks8851");
> > > > > >
> > > > > > Any reason for not checking return value of gpio_request()?
> > > > > >

[snip]

> Minor changes:
> if (gpio_request(x))
> 	return status;
> if (gpio_request(y))
> 	goto err1;
> if (gpio_request(z))
> 	goto err2;
> ...
> 	return 0;
> 
> err2:
> 	free(y);
> 
> err1:
> 	free(x);
> 	return status;

How about this patch?

Note. I am thinking in spi_register_board_info registration:

1. to be done if ethernet fails, other spi dev can be added in future
2. not to be done if ethernet fails, no other dev in spi bus 1 for now

What is the best approach? Is it to keep #2?

---

#define ETH_KS8851_IRQ			34
#define ETH_KS8851_POWER_ON		48
#define ETH_KS8851_QUART		138

static struct spi_board_info sdp4430_spi_board_info[] __initdata = {
	{
		.modalias               = "ks8851",
		.bus_num                = 1,
		.chip_select            = 0,
		.max_speed_hz           = 24000000,
		.irq                    = ETH_KS8851_IRQ,
	},
};

static int omap_ethernet_init(void)
{
	int status;

	status = gpio_request(ETH_KS8851_POWER_ON, "eth_power");
	if (status < 0) {
		pr_warning("Cannot request GPIO %d\n", ETH_KS8851_POWER_ON);
		return status;
	}

	status = gpio_request(ETH_KS8851_QUART, "quart");
	if (status < 0) {
		pr_warning("Cannot request GPIO %d\n", ETH_KS8851_QUART);
		goto err1;
	}

	status = gpio_request(ETH_KS8851_IRQ, "eth_irq");
	if (status < 0) {
		pr_warning("Cannot request GPIO %d\n", ETH_KS8851_IRQ);
		goto err2;
	}

	gpio_direction_output(ETH_KS8851_POWER_ON, 1);
	gpio_direction_output(ETH_KS8851_QUART, 1);
	gpio_direction_input(ETH_KS8851_IRQ);

	return status;

err2:
	gpio_free(ETH_KS8851_QUART);
err1:
	gpio_free(ETH_KS8851_POWER_ON);
	return status;

}


[...]


 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);

	status = omap_ethernet_init();
	if (status)
		pr_warning("Ethernet initialization failed: %d\n", status);
	else
		sdp4430_spi_board_info[0].irq = gpio_to_irq(ETH_KS8851_IRQ);

	spi_register_board_info(sdp4430_spi_board_info,
			ARRAY_SIZE(sdp4430_spi_board_info));


Best Regards
Abraham

------------------------------------------------------------------------------
