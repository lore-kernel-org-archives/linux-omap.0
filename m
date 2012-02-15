From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] spi/omap: Add DT support to McSPI driver
Date: Wed, 15 Feb 2012 13:04:34 -0700
Message-ID: <20120215200434.GC25779@ponder.secretlab.ca>
References: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
 <1329327457-2121-2-git-send-email-b-cousson@ti.com>
 <4F3C08D6.6000108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36600 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab2BOUEh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 15:04:37 -0500
Received: by iacb35 with SMTP id b35so1876270iac.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 12:04:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F3C08D6.6000108@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 15, 2012 at 01:34:46PM -0600, Rob Herring wrote:
> On 02/15/2012 11:37 AM, Benoit Cousson wrote:
> > Add device tree support to the OMAP2+ McSPI driver.
> > Add the bindings documentation.
> > 
> > Based on original code from Rajendra.
> > 
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > ---
> >  Documentation/devicetree/bindings/spi/omap-spi.txt |   20 +++++++
> >  drivers/spi/spi-omap2-mcspi.c                      |   56 +++++++++++++++++---
> >  2 files changed, 68 insertions(+), 8 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/spi/omap-spi.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
> > new file mode 100644
> > index 0000000..81df374
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
> > @@ -0,0 +1,20 @@
> > +OMAP2+ McSPI device
> > +
> > +Required properties:
> > +- compatible :
> > +  - "ti,omap2-spi" for OMAP2 & OMAP3.
> > +  - "ti,omap4-spi" for OMAP4+.
> > +- ti,spi-num-cs : Number of chipselect supported  by the instance.
> > +- ti,hwmods: Name of the hwmod associated to the McSPI
> > +
> > +
> > +Example:
> > +
> > +mcspi1: mcspi@1 {
> 
> I don't recall if there's a generic name defined but just "spi" would
> probably be better. Also, shouldn't this be the base address?
> 
> Otherwise, for the series:
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Yes, use the generic names recommended practice and name the node spi@<address>.

g.

> 
> 
> > +    #address-cells = <1>;
> > +    #size-cells = <0>;
> > +    compatible = "ti,omap4-mcspi";
> > +    ti,hwmods = "mcspi1";
> > +    ti,spi-num-cs = <4>;
> > +};
> > +
> > diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> > index 0b0dfb7..bb9274c 100644
> > --- a/drivers/spi/spi-omap2-mcspi.c
> > +++ b/drivers/spi/spi-omap2-mcspi.c
> > @@ -34,6 +34,8 @@
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> >  
> >  #include <linux/spi/spi.h>
> >  
> > @@ -1079,15 +1081,39 @@ static int omap_mcspi_runtime_resume(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static struct omap2_mcspi_platform_config omap2_pdata = {
> > +	.regs_offset = 0,
> > +};
> > +
> > +static struct omap2_mcspi_platform_config omap4_pdata = {
> > +	.regs_offset = OMAP4_MCSPI_REG_OFFSET,
> > +};
> > +
> > +static const struct of_device_id omap_mcspi_of_match[] = {
> > +	{
> > +		.compatible = "ti,omap2-mcspi",
> > +		.data = &omap2_pdata,
> > +	},
> > +	{
> > +		.compatible = "ti,omap4-mcspi",
> > +		.data = &omap4_pdata,
> > +	},
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, omap_mcspi_of_match);
> >  
> >  static int __init omap2_mcspi_probe(struct platform_device *pdev)
> >  {
> >  	struct spi_master	*master;
> > -	struct omap2_mcspi_platform_config *pdata = pdev->dev.platform_data;
> > +	struct omap2_mcspi_platform_config *pdata;
> >  	struct omap2_mcspi	*mcspi;
> >  	struct resource		*r;
> >  	int			status = 0, i;
> >  	char			wq_name[20];
> > +	u32			regs_offset = 0;
> > +	static int		bus_num = 1;
> > +	struct device_node	*node = pdev->dev.of_node;
> > +	const struct of_device_id *match;
> >  
> >  	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
> >  	if (master == NULL) {
> > @@ -1098,13 +1124,26 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
> >  	/* the spi->mode bits understood by this driver: */
> >  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> >  
> > -	if (pdev->id != -1)
> > -		master->bus_num = pdev->id;
> > -
> >  	master->setup = omap2_mcspi_setup;
> >  	master->transfer = omap2_mcspi_transfer;
> >  	master->cleanup = omap2_mcspi_cleanup;
> > -	master->num_chipselect = pdata->num_cs;
> > +	master->dev.of_node = node;
> > +
> > +	match = of_match_device(omap_mcspi_of_match, &pdev->dev);
> > +	if (match) {
> > +		u32 num_cs = 1; /* default number of chipselect */
> > +		pdata = match->data;
> > +
> > +		of_property_read_u32(node, "ti,spi-num-cs", &num_cs);
> > +		master->num_chipselect = num_cs;
> > +		master->bus_num = bus_num++;
> > +	} else {
> > +		pdata = pdev->dev.platform_data;
> > +		master->num_chipselect = pdata->num_cs;
> > +		if (pdev->id != -1)
> > +			master->bus_num = pdev->id;
> > +	}
> > +	regs_offset = pdata->regs_offset;
> >  
> >  	dev_set_drvdata(&pdev->dev, master);
> >  
> > @@ -1124,8 +1163,8 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
> >  		goto free_master;
> >  	}
> >  
> > -	r->start += pdata->regs_offset;
> > -	r->end += pdata->regs_offset;
> > +	r->start += regs_offset;
> > +	r->end += regs_offset;
> >  	mcspi->phys = r->start;
> >  	if (!request_mem_region(r->start, resource_size(r),
> >  				dev_name(&pdev->dev))) {
> > @@ -1285,7 +1324,8 @@ static struct platform_driver omap2_mcspi_driver = {
> >  	.driver = {
> >  		.name =		"omap2_mcspi",
> >  		.owner =	THIS_MODULE,
> > -		.pm =		&omap2_mcspi_pm_ops
> > +		.pm =		&omap2_mcspi_pm_ops,
> > +		.of_match_table = omap_mcspi_of_match,
> >  	},
> >  	.remove =	__exit_p(omap2_mcspi_remove),
> >  };
> 
