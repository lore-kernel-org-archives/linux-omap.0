From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: Add basic support for 720MHz part
Date: Fri, 7 Jan 2011 19:20:33 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930248202128@dbde02.ent.ti.com>
References: <1294405659-25662-1-git-send-email-premi@ti.com>
 <4D27162E.6070203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37589 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab1AGNum convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 08:50:42 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p07Docjj032130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 7 Jan 2011 07:50:41 -0600
In-Reply-To: <4D27162E.6070203@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Friday, January 07, 2011 7:04 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
> 
> Sanjeev Premi wrote, on 01/07/2011 07:07 AM:
> > +		if (omap3_has_720mhz()) {
> > +			pr_info("Enabled OPP corresponding to 
> 720MHz\n");
> > +
> > +			omap34xx_opp_def_list[INDEX_MPU_720MHZ]
> > +				.default_available = true;
> > +			omap34xx_opp_def_list[INDEX_IVA_720MHZ]
> > +				.default_available = true;
> for many reasons, I dont like this indexing - I am ok with 
> most part of 
> the patch otherwise - how about opp_enable(dev, freq) instead?

I had thought about it, but opp_enable would have to be done after
omap_init_opp_table(). Two factors led me to current implementation:

1) Numer of lines of code required to get same thing done one the
   opp table has been initialized.

2) The index definition and usage are localized in same file.

> 
> -- 
> Regards,
> Nishanth Menon
> 