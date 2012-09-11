From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: omap2-mcspi: add pinctrl support
Date: Tue, 11 Sep 2012 14:06:32 -0400
Message-ID: <20120911180632.GN27758@beef>
References: <1347385599-27558-1-git-send-email-mporter@ti.com>
	<1347385599-27558-2-git-send-email-mporter@ti.com>
	<20120911180041.GH23092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120911180041.GH23092-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, AnilKumar <anilkumar-l0cyMroinI0@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 11, 2012 at 11:00:41AM -0700, Tony Lindgren wrote:
> * Matt Porter <mporter-l0cyMroinI0@public.gmane.org> [120911 10:46]:
> > Adds pinctrl support to support OMAP platforms that boot from DT
> > and rely on pinctrl support to set pinmuxes.
> > 
> > Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/spi/spi-omap2-mcspi.c |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> > index b2fb141..6c67cdb 100644
> > --- a/drivers/spi/spi-omap2-mcspi.c
> > +++ b/drivers/spi/spi-omap2-mcspi.c
> > @@ -38,6 +38,8 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/pinctrl/consumer.h>
> > +#include <linux/err.h>
> >  
> >  #include <linux/spi/spi.h>
> >  
> > @@ -1124,6 +1126,7 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
> >  	static int		bus_num = 1;
> >  	struct device_node	*node = pdev->dev.of_node;
> >  	const struct of_device_id *match;
> > +	struct pinctrl *pinctrl;
> >  
> >  	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
> >  	if (master == NULL) {
> > @@ -1219,6 +1222,12 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
> >  	if (status < 0)
> >  		goto dma_chnl_free;
> >  
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> > +	if (IS_ERR(pinctrl)) {
> > +		status = PTR_ERR(pinctrl);
> > +		goto dma_chnl_free;
> > +	}
> > +
> >  	pm_runtime_use_autosuspend(&pdev->dev);
> >  	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
> >  	pm_runtime_enable(&pdev->dev);
> 
> You should just print out a warning here as most boards don't
> have pinctrl implemented at this point, or may never have.

It will not hit this error path on the boards without pinctrl due
to the second part of the series. The error check is for some really
unexpected failure in the pinctrl core and parsing functionality where
we want it to bail out.

-Matt

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
