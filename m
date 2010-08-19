From: Heikki Krogerus <ext-heikki.krogerus@nokia.com>
Subject: Re: [PATCH] power_supply: add isp1704 charger detection driver
Date: Thu, 19 Aug 2010 10:17:36 +0300
Message-ID: <20100819071736.GB4363@esdhcp041123.research.nokia.com>
References: <1282136465-1748-1-git-send-email-ext-heikki.krogerus@nokia.com>
 <4C6BF460.9090105@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C6BF460.9090105@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "cbou@mail.ru" <cbou@mail.ru>, "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, "Lehtonen Markus (Nokia-MS/Helsinki)" <markus.lehtonen@nokia.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Aug 18, 2010 at 04:55:28PM +0200, Quadros Roger (Nokia-MS/Helsinki) wrote:
> On 08/18/2010 04:01 PM, Krogerus Heikki (EXT-Teleca/Helsinki) wrote:
> > NXP ISP1704 is Battery Charging Specification 1.0 compliant USB
> > transceiver. This adds a power supply driver for ISP1704 and
> > ISP1707 USB transceivers.

<snip>

> > +static inline int isp1704_test_ulpi(struct isp1704_charger *isp)
> > +{
> > +	int			vendor, product, i;
> > +	int			ret = -ENODEV;
> > +
> > +	/* Test ULPI interface */
> > +	ret = otg_io_write(isp->otg, ULPI_SCRATCH, 0xaa);
> > +	if (ret<  0)
> > +		return ret;
> > +	ret = otg_io_read(isp->otg, ULPI_SCRATCH);
> > +	if (ret<  0)
> > +		return ret;
> > +	if (ret != 0xaa)
> > +		return -ENODEV;
> > +	/* Verify the product and vendor id matches */
> > +	vendor = otg_io_read(isp->otg, ULPI_VENDOR_ID_LOW);
> > +	vendor |= otg_io_read(isp->otg, ULPI_VENDOR_ID_HIGH)<<  8;
> > +	if (vendor != NXP_VENDOR_ID)
> > +		return -ENODEV;
> > +	for (i = 0; i<  ARRAY_SIZE(isp170x_id); i++) {
> > +		product = otg_io_read(isp->otg, ULPI_PRODUCT_ID_LOW);
> > +		product |= otg_io_read(isp->otg, ULPI_PRODUCT_ID_HIGH)<<  8;
> 
> product id should be read outside the for loop. This way you will save 
> unnecessary otg_io_reads. product id won't change anyways.

Good point. Fixing.
 
> > +		if (product == isp170x_id[i]) {
> > +			sprintf(isp->model, "isp%x", product);
> > +			return product;
> > +		}
> > +	}
> > +
> > +	dev_err(isp->dev, "product id %x not matching known ids", product);
> > +
> > +	return -ENODEV;
> > +}
> 
> <snip>
> 
> > +static struct platform_driver isp1704_charger_driver = {
> > +	.driver = {
> > +		.name = "isp1704_charger",
> > +	},
> > +	.probe = isp1704_charger_probe,
> > +	.remove = __devexit_p(isp1704_charger_remove),
> > +};
> > +
> > +static struct platform_device *isp1704_device;
> > +
> > +static int __init isp1704_charger_init(void)
> > +{
> > +	int ret = 0;
> > +
> > +	ret = platform_driver_register(&isp1704_charger_driver);
> > +	if (ret)
> > +		return ret;
> > +
> > +	isp1704_device = platform_device_register_simple("isp1704_charger",
> > +							0, NULL, 0);
> 
> This platform_device_register should be done in the rx51 board file. i.e. 
> board-rx51-peripherals.c

OK. I'll fix this.

Thanks,

-- 
heikki
