From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv4 2/3] drivers: spi: Add qspi flash controller
Date: Thu, 18 Jul 2013 12:08:30 -0700
Message-ID: <CA+7tXij7W_F0ZTQZ=YvK+qOLO+O-6WpTKxLerv8NXyrdydt7FA@mail.gmail.com>
References: <1374141687-10790-1-git-send-email-sourav.poddar@ti.com>
	<1374141687-10790-3-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1374141687-10790-3-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 18, 2013 at 3:01 AM, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org> wrote:
> +Required properties:
> +- compatible : should be "ti,dra7xxx-qspi".
> +- reg: Should contain QSPI registers location and length.
> +- #address-cells, #size-cells : Must be present if the device has sub-nodes
> +- ti,hwmods: Name of the hwmod associated to the QSPI

What is ti,hwmods?  It's not clear from the description.  It also
doesn't appear to be used in the driver.  At least, I did not find any
occurrence of "hwmods" in the driver code.

> +static inline unsigned long ti_qspi_readl_data(struct ti_qspi *qspi,
> +               unsigned long reg, int wlen)

"readl" means read LONG.  That's what the L is for.  But this does
different widths.

> +{
> +       switch (wlen) {
> +       case 8:
> +               return readw(qspi->base + reg);
> +               break;
wlen == 8, but readw == 16 bit read?

The break after the return isn't necessary.

> +       case 16:
> +               return readb(qspi->base + reg);
> +               break;
wlen == 16, but readb == 8 bit read?

> +       case 32:
> +               return readl(qspi->base + reg);

wlen == 32, readl == 32, this one makes sense, but....

> +static inline void ti_qspi_writel_data(struct ti_qspi *qspi,
> +               unsigned long val, unsigned long reg, int wlen)

> +       case 32:
> +               writeb(val, qspi->base + reg);
> +               break;

A 32 bit write uses an 8 bit write command, while read is 32 bits??

This doesn't make a lot of sense.  If it's actually correct, there
should be come kind of comment about it.

> +
> +static int ti_qspi_setup(struct spi_device *spi)
> +{

> +
> +       clk_ctrl_reg = ti_qspi_readl(qspi, QSPI_SPI_CLOCK_CNTRL_REG);
> +
> +       clk_ctrl_reg &= ~QSPI_CLK_EN;
> +
> +       /* disable SCLK */
> +       ti_qspi_writel(qspi, clk_ctrl_reg, QSPI_SPI_CLOCK_CNTRL_REG);

Did you read this from Documentation/spi/spi-summary?
                ** BUG ALERT:  for some reason the first version of
                ** many spi_master drivers seems to get this wrong.
                ** When you code setup(), ASSUME that the controller
                ** is actively processing transfers for another device.

> +static int ti_qspi_probe(struct platform_device *pdev)
> +{
> +
> +       master->mode_bits = SPI_CPOL | SPI_CPHA;

Does your device support full duplex?  It doesn't look like it does.
You should set the SPI_MASER_HALF_DUPLEX flag in master->flags.

> +
> +       if (!of_property_read_u32(np, "ti,spi-num-cs", &num_cs))
> +               master->num_chipselect = num_cs;

You didn't document this property.  How is this different than the
"num-cs" property already documented in spi-bus bindings?

> +       qspi->base = devm_ioremap_resource(&pdev->dev, r);
> +       if (IS_ERR(qspi->base)) {
> +               ret = -ENOMEM;

Shouldn't that be ret = PTR_ERR(qspi->base)

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
