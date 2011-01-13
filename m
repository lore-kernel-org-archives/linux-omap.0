From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] omap3: Add basic support for 720MHz part
Date: Thu, 13 Jan 2011 12:33:10 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024834A32F@dbde02.ent.ti.com>
References: <1294857234-1676-1-git-send-email-premi@ti.com>
 <20110113035355.GA2178@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49500 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601Ab1AMHDT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 02:03:19 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0D73FeD018887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 01:03:17 -0600
In-Reply-To: <20110113035355.GA2178@manju-desktop>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: G, Manjunath Kondaiah [mailto:manjugk@ti.com] 
> Sent: Thursday, January 13, 2011 9:24 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCHv2] omap3: Add basic support for 720MHz part
> 
> Hi Sanjeev,
> 
[snip]...[snip]

> >  	 */
> > +
> > +	/*
> > +	 * Does it support 720MHz?
> > +	 */
> multiline style comment
[sp] This is used many places. Don't see any issue with it.
     unless you really want to see this on single line.

> > +	status = (OMAP3_SKUID_MASK & read_tap_reg(OMAP3_PRODID));
> > +
> > +	if (status & OMAP3_SKUID_720MHZ) {
> > +		omap3_features |= OMAP3_HAS_720MHZ;
> > +	}
> braces not required

[sp] Will change. forgot to remove after moving code to a
     different function.

> >  }

[snip]...[snip]

> > +		r = opp_enable(&(oh_mpu->od->pdev.dev),	720000000);
> > +		if (r < 0) {
> > +			pr_err("%s: Unable to enable OPP for 
> mpu.", __func__);
> since you have dev pointer, pr_err can be replaced with dev_err

[sp] Idea was to get to this function - in case of error; but can
     be changed as well.

> > +			goto err;
> > +		}
> > +	}
> > +
> > +	if (!oh_iva || !oh_iva->od) {
> > +		r = -ENODEV;
> > +		goto err;
> > +	} else {
> > +		r = opp_enable(&(oh_iva->od->pdev.dev), 520000000);
> > +		if (r < 0) {
> > +			pr_err("%s: Unable to enable OPP for 
> iva.", __func__);
> > +			goto err;
> > +		}
> > +	}
> Can be optimized as(not tested and compiled):
> 
> 	struct platform_device *pdev;

[sp] Like this! ... to get to "dev".

> 	struct omap_hwmod *oh_mpu = omap_hwmod_lookup("mpu");
> 	struct omap_hwmod *oh_iva = omap_hwmod_lookup("iva");
> 	int r = -ENODEV;
> 
> 	if (!oh_mpu || !oh_mpu->od || !oh_iva || !oh_iva->od)
> 		goto err;
> 
> 	pdev = oh_mpu->od->pdev;
> 	r = opp_enable(&pdev->dev, 720000000);
> 	if (r < 0) {
> 		dev_err(&pdev->dev, "Unable to enable OPP for mpu.\n");
> 		goto err;
> 	}
> 	pdev = oh_iva->od->pdev;
> 	r = opp_enable(&pdev->dev, 520000000);
> 	if (r < 0) {
> 		dev_err(&pdev->dev, "Unable to enable OPP for iva.\n");
> 		goto err;
> 	}
> 
> Do you see any issues?

Though it is not considered in this patch, but in the devices that
don't contain iva, the code related to enabling the iva freq can
be easily excluded in current flow.

Plan to send v3 with all other changes by evening. The optimization
will only be undone once I introduce the check for presence of IVA.

~sanjeev

> 
> -Manjunath
> 
> [...]
> 