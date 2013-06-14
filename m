From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH] mfd: Palmas: Introduce features to select the
 appropriate modules present in the palmas variant
Date: Fri, 14 Jun 2013 11:35:18 +0100
Message-ID: <20130614103518.GH5456@mint>
References: <1371201718-15101-1-git-send-email-j-keerthy@ti.com>
 <20130614095554.GF5456@mint>
 <51BAEA19.7070509@nvidia.com>
 <DC88CAD03C0052499C1907B327FC63229EBAAE@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.xora.org.uk ([80.68.91.202]:59930 "EHLO
	xora.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab3FNKfT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jun 2013 06:35:19 -0400
Content-Disposition: inline
In-Reply-To: <DC88CAD03C0052499C1907B327FC63229EBAAE@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>

On Fri, Jun 14, 2013 at 10:22:04AM +0000, J, KEERTHY wrote:
> Graeme/Laxman,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Laxman Dewangan
> > Sent: Friday, June 14, 2013 3:32 PM
> > To: Graeme Gregory
> > Cc: J, KEERTHY; linux-omap@vger.kernel.org;
> > broonie@opensource.wolfsonmicro.com; sameo@linux.intel.com
> > Subject: Re: [PATCH] mfd: Palmas: Introduce features to select the
> > appropriate modules present in the palmas variant
> > 
> > On Friday 14 June 2013 03:25 PM, Graeme Gregory wrote:
> > > On Fri, Jun 14, 2013 at 02:51:58PM +0530, J Keerthy wrote:
> > >> -	children[PALMAS_PMIC_ID].platform_data = pdata->pmic_pdata;
> > >> -	children[PALMAS_PMIC_ID].pdata_size = sizeof(*pdata->pmic_pdata);
> > >> +	if (PALMAS_PMIC_HAS(palmas, REGULATORS)) {
> > >> +		children[PALMAS_PMIC_ID].platform_data = pdata->pmic_pdata;
> > >> +		children[PALMAS_PMIC_ID].pdata_size =
> > >> +				sizeof(*pdata->pmic_pdata);
> > >> +	}
> > >>
> > > I think a lot of complexity here could actually be removed by
> > removing
> > > the old board file style probing for palmas. I do not beleive either
> > > major user of palmas requires that anymore? I always had in my mind
> > > that this bit was temporary.
> > 
> > Completely agree, we should not have this. Also this is not valid much
> > in DT context and so we can remove it.
> 
> So shall I completely knock off the pdata assignments?
> 
> BTW having features flag  would still be handy for PMICs which might
> Not have all the features as TWL6035/Palmas. So I still want to retain
> That. Is it Okay?
> 
Everything from the line

children = kmemdup(palmas_children, sizeof(palmas_children), GFP_KERNEL)

until error handling can go. As well as the palmas_children/palmas_ids
array at the top.

The features variable is I think superceded by DT, a feature not in chip
should not be in the DT. But if you have other technical reasons to keep
it I have no real strong opinion.

Graeme

