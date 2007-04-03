From: Imre Deak <imre.deak@solidboot.com>
Subject: Re: TSC2101/2102
Date: Tue, 3 Apr 2007 17:36:16 +0300
Message-ID: <20070403143616.GA12681@bitbox>
References: <20070320153812.GI19913@atomide.com>
	<a0580c510703211224y60c9283bv822276225c3e2c08@mail.gmail.com>
	<20070322084830.1a91c99c.jarkko.nikula@nokia.com>
	<20070330184933.GB18375@atomide.com>
	<a0580c510703310552h2d455e30qb145270bec2be37f@mail.gmail.com>
	<20070331170100.GA2565@bitbox>
	<a0580c510704020643k6c29da26h548385a1dd1b348f@mail.gmail.com>
	<20070402202325.GA23808@bitbox>
	<a0580c510704021341y476604b7l129b11f6a8ce4f57@mail.gmail.com>
	<a0580c510704030422u1ce3df44n45c4617fa2abb1a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <a0580c510704030422u1ce3df44n45c4617fa2abb1a8@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Kyungmin Park <kmpark@infradead.org>, Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Apr 03, 2007 at 07:22:57AM -0400, Eduardo Valentin wrote:
> Hello again Imre,
> 
> 
>   I didn't understand properly your question. My bad. Sorry.
>   I used set_drvdata because it is used into lcd_h2.c (accordingly to
> my previous patch):
> @@ -117,6 +97,19 @@ struct lcd_panel h2_panel = {
> 
> static int h2_panel_probe(struct platform_device *pdev)
> {
> +	struct spi_device *tsc2101;
> +
> +	tsc2101 = dev_get_drvdata(&pdev->dev);
> +	if (tsc2101 == NULL) {
> +		dev_err(&pdev->dev, "no platform data\n");
> +		return -ENODEV;
> +	}
> 
>   Of course, it is clear enough that this dev_err message is wrong.
> It must be "no driver data". My bad again. However, why do you suggest
> use platform_data instead of driver_data?

That's the standard way platforms pass init data to the driver. The
driver can then use the driver_data field for it's own purpose.

But more important would be to know why platform_data gets zero'd, since
the device core is not touching it. A workaround you're proposing might
just delay some other problem..

--Imre
