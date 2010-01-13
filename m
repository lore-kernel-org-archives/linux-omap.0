From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
 in SDRC after a Warm-reset
Date: Wed, 13 Jan 2010 11:01:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001131100310.20437@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E0A30D4@dbde02.ent.ti.com> <alpine.DEB.2.00.1001061250030.10034@utopia.booyaka.com> <alpine.DEB.2.00.1001061338340.10034@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7961@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33072 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779Ab0AMSBG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 13:01:06 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7961@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hello Teerth,

On Wed, 13 Jan 2010, Reddy, Teerth wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> >
> Your changes - 
> > +/* Function for SDRC config for warm reset */
> > +static u32 (*_omap3_sram_warmreset)(void);
> > +
> > +void omap3_warmreset()
> > +{
> > +	if (WARN_ON(!_omap3_sram_warmreset))
> > +		return;
> > +
> > +	return;
> > +}
> 
> The compile warning is due to the return; I had here. I think I might 
> still want to have this function as u32.

Why?


- Paul
