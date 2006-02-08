From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] Convert drivers to new irq trigger modes
Date: Wed, 8 Feb 2006 07:14:51 +0200
Message-ID: <20060208051451.GA22845@two.research.nokia.com>
References: <43E8D9CA.8000204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43E8D9CA.8000204@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Dirk,

On Tue, Feb 07, 2006 at 06:32:58PM +0100, ext Dirk Behme wrote:

>  	int			irq;
> +	int			irq_type;

This doesn't seem to be used anywhere.

> +	isp->irq_type = SA_SAMPLE_RANDOM;
>  	isp->client.addr = address;
>  	i2c_set_clientdata(&isp->client, isp);
>  	isp->client.adapter = bus;
> @@ -1602,7 +1604,7 @@ fail1:
>  		isp->irq = OMAP_GPIO_IRQ(2);
>  		omap_request_gpio(2);
>  		omap_set_gpio_direction(2, 1);
> -		set_irq_type(isp->irq, IRQT_FALLING);
> +		isp->irq_type = SA_TRIGGER_FALLING;

You should be ORring here.  Otherwise you lose the SA_SAMPLE_RANDOM flag.

Cheers,
Juha
