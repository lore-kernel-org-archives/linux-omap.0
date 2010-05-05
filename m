From: "Arce, Abraham" <x0066660-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 2/3] OMAP4: Ethernet: KS8851
	Board Support
Date: Wed, 5 May 2010 03:11:00 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DEEB8D1@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043DEEB8C1@dlee03.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F8C7096@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C7096-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Manjunath,

> > +
> > +static void omap_ethernet_init(void)
> > +{
> > +	gpio_request(ETHERNET_KS8851_POWER_ENABLE, "ethernet");
> > +	gpio_direction_output(ETHERNET_KS8851_POWER_ENABLE, 1);
> > +	gpio_request(ETHERNET_KS8851_QUART, "quart");
> > +	gpio_direction_output(ETHERNET_KS8851_QUART, 1);
> > +	gpio_request(ETHERNET_KS8851_IRQ, "ks8851");
> 
> Any reason for not checking return value of gpio_request()?
> 

Thought initially about them as dedicated lines for ethernet avoiding
both reasons to check for a gpio's request:

 1. invalid gpio
 2. already claimed gpio

Best Regards
Abraham


------------------------------------------------------------------------------
