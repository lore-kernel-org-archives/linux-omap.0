From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH v2 2/4] MFD: Palmas: Add SMPS10_BOOST feature
Date: Tue, 18 Jun 2013 16:56:13 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229EC576@DBDE04.ent.ti.com>
References: <1371549794-7406-1-git-send-email-j-keerthy@ti.com>
 <51C0826B.4060101@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <51C0826B.4060101@wwwdotorg.org>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi Stephen,


> -----Original Message-----
> From: Stephen Warren [mailto:swarren@wwwdotorg.org]
> Sent: Tuesday, June 18, 2013 9:23 PM
> To: J, KEERTHY
> Cc: linux-omap@vger.kernel.org; broonie@kernel.org;
> ldewangan@nvidia.com; sameo@linux.intel.com; grant.likely@secretlab.ca;
> swarren@nvidia.com; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org; gg@slimlogic.co.uk
> Subject: Re: [PATCH v2 2/4] MFD: Palmas: Add SMPS10_BOOST feature
> 
> On 06/18/2013 04:03 AM, J Keerthy wrote:
> > The SMPS10 regulator is not presesnt in all the variants of the
> PALMAS
> > PMIC family. Hence adding a feature to distingush between them.
> 
> > diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> 
> > +	match = of_match_device(of_match_ptr(of_palmas_match_tbl),
> > +&i2c->dev);
> > +
> > +	if (match) {
> > +		features = (unsigned int *)match->data;
> > +		palmas->features = *features;
> > +	} else {
> > +		return -ENODATA;
> > +	}
> 
> 
> I think it's more common to do the error-checking first. That way, the
> success-case code doesn't need an indent:
> 
> match = of_match...(...);
> if (!match)
>     return -ENODATA;
> 
> features = ...;
> palmas->features = *features;

Sure. I will fix this.

Regards,
Keerthy

