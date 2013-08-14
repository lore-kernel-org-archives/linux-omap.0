From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [RFC 2/2] usb: dwc3: Add Qualcomm DWC3 glue layer driver
Date: Wed, 14 Aug 2013 12:28:17 +0300
Message-ID: <1376472497.2132.6.camel@iivanov-dev.int.mm-sol.com>
References: <1375789991-30041-1-git-send-email-iivanov@mm-sol.com>
	 <1375789991-30041-3-git-send-email-iivanov@mm-sol.com>
	 <20130809132349.GC12041@radagast>
	 <1376064558.7709.31.camel@iivanov-dev.int.mm-sol.com>
	 <20130812182439.GG27954@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130812182439.GG27954@radagast>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, gregkh@linuxfoundation.org, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi, 

On Mon, 2013-08-12 at 13:24 -0500, Felipe Balbi wrote: 
> On Fri, Aug 09, 2013 at 07:09:18PM +0300, Ivan T. Ivanov wrote:
> > Hi, 
> > 
> > On Fri, 2013-08-09 at 16:23 +0300, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Tue, Aug 06, 2013 at 02:53:11PM +0300, Ivan T. Ivanov wrote:
> > > > diff --git a/drivers/usb/dwc3/dwc3-msm.c b/drivers/usb/dwc3/dwc3-msm.c
> > > > new file mode 100644
> > > > index 0000000..e509abc
> > > > --- /dev/null
> > > > +++ b/drivers/usb/dwc3/dwc3-msm.c
> > > > @@ -0,0 +1,175 @@
> > > > +#undef CONFIG_REGULATOR
> > > 
> > > why ??????
> > > 
> > 
> > 1. This shows that driver is still not fully tested 
> >    Regulators support is still missing in the MSM
> > 2. Helps me to load driver successfully. 
> 
> Then remove all the regulator-related code from this.

I would like to keep them. I will just remove #undef line. 
Code will continue to build fine. And once regulators drivers 
are upstreamed this driver 'will not' require further
modifications.

> 
> > > > +	clk_prepare_enable(mdwc->core_clk);
> > > > +	clk_prepare_enable(mdwc->iface_clk);
> > > > +	clk_prepare_enable(mdwc->sleep_clk);
> > > > +	clk_prepare_enable(mdwc->utmi_clk);
> > > 
> > > do you really need to enable your clocks here ? Why don't you enable
> > > them on runtime_resume and disable on runtime_suspend ?
> > 
> > I will like to make it working first and then will improve
> > power management.
> 
> alright, makes sense.
> 
> > > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +	tcsr = devm_ioremap_resource(&pdev->dev, res);
> > > > +	if (!tcsr) {
> > > > +		dev_dbg(&pdev->dev, "tcsr ioremap failed\n");
> > > 
> > > no need to ioremap, also you're likely leaking clocks and regulators
> > > enabled here.
> > > 
> > > Make sure to have something like:
> > > 
> > > 	if (!tcsr)
> > > 		goto err_disable_clocks;
> > > 
> > > 	/* TODO This has to be revised */\
> > > 
> > > 	[...]
> > > 
> > 
> > Sure.
> 
> just to make it clear, I meant to say that you don't need to print the
> error message :-)

Yes. I got it.

Regards,
Ivan
