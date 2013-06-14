From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH] mfd: Palmas: Introduce features to select the
 appropriate modules present in the palmas variant
Date: Fri, 14 Jun 2013 10:22:04 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229EBAAE@DBDE04.ent.ti.com>
References: <1371201718-15101-1-git-send-email-j-keerthy@ti.com>
 <20130614095554.GF5456@mint> <51BAEA19.7070509@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42073 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab3FNKWX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jun 2013 06:22:23 -0400
In-Reply-To: <51BAEA19.7070509@nvidia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, Graeme Gregory <gg@slimlogic.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>

Graeme/Laxman,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Laxman Dewangan
> Sent: Friday, June 14, 2013 3:32 PM
> To: Graeme Gregory
> Cc: J, KEERTHY; linux-omap@vger.kernel.org;
> broonie@opensource.wolfsonmicro.com; sameo@linux.intel.com
> Subject: Re: [PATCH] mfd: Palmas: Introduce features to select the
> appropriate modules present in the palmas variant
> 
> On Friday 14 June 2013 03:25 PM, Graeme Gregory wrote:
> > On Fri, Jun 14, 2013 at 02:51:58PM +0530, J Keerthy wrote:
> >> -	children[PALMAS_PMIC_ID].platform_data = pdata->pmic_pdata;
> >> -	children[PALMAS_PMIC_ID].pdata_size = sizeof(*pdata->pmic_pdata);
> >> +	if (PALMAS_PMIC_HAS(palmas, REGULATORS)) {
> >> +		children[PALMAS_PMIC_ID].platform_data = pdata->pmic_pdata;
> >> +		children[PALMAS_PMIC_ID].pdata_size =
> >> +				sizeof(*pdata->pmic_pdata);
> >> +	}
> >>
> > I think a lot of complexity here could actually be removed by
> removing
> > the old board file style probing for palmas. I do not beleive either
> > major user of palmas requires that anymore? I always had in my mind
> > that this bit was temporary.
> 
> Completely agree, we should not have this. Also this is not valid much
> in DT context and so we can remove it.

So shall I completely knock off the pdata assignments?

BTW having features flag  would still be handy for PMICs which might
Not have all the features as TWL6035/Palmas. So I still want to retain
That. Is it Okay?

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

Regards,
Keerthy
