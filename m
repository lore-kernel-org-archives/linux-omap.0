From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] pci: dwc: pci-dra7xx: Make shutdown handler static
Date: Wed, 20 Dec 2017 10:29:55 +0000
Message-ID: <20171220102955.GA941@red-moon>
References: <20171201050652.13998-1-vigneshr@ti.com>
 <12f94b3d-5192-d53a-8390-812fe9b7b229@ti.com>
 <20171201165314.GB29985@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201165314.GB29985@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Vignesh R <vigneshr@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 01, 2017 at 04:53:14PM +0000, Lorenzo Pieralisi wrote:
> On Fri, Dec 01, 2017 at 10:43:53AM +0530, Keerthy wrote:
> > 
> > 
> > On Friday 01 December 2017 10:36 AM, Vignesh R wrote:
> > > Declare dra7xx_pcie_shutdown() as a static function as its not used
> > > elsewhere.
> > 
> > Seems like the below version that had static version was not taken:
> > 
> > https://patchwork.kernel.org/patch/10052579/
> 
> It looks like I can drop the patch above then - let me know if
> that's ok.

I would appreciate some feedback; I assume that dropping the patch above
and applying the patch in $SUBJECT is what you expect, if there is a
problem with that please manifest yourselves.

Lorenzo

> Thanks,
> Lorenzo
> 
> > So for this patch:
> > 
> > Reviewed-by: Keerthy <j-keerthy@ti.com>
> > 
> > > 
> > > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > > ---
> > >  drivers/pci/dwc/pci-dra7xx.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> > > index 59e8de34cec6..b9db442af793 100644
> > > --- a/drivers/pci/dwc/pci-dra7xx.c
> > > +++ b/drivers/pci/dwc/pci-dra7xx.c
> > > @@ -815,7 +815,7 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
> > >  }
> > >  #endif
> > >  
> > > -void dra7xx_pcie_shutdown(struct platform_device *pdev)
> > > +static void dra7xx_pcie_shutdown(struct platform_device *pdev)
> > >  {
> > >  	struct device *dev = &pdev->dev;
> > >  	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
> > > 
