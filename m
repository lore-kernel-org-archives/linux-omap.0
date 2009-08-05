From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v1 1/3] ARM:OMAP4 iommu:changes in iommu for OMAP4
Date: Wed, 5 Aug 2009 21:36:56 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD943C@dbde02.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3ABDBABD@dlee03.ent.ti.com>
 <20090804224504.GB17716@n2100.arm.linux.org.uk>
 <20090805072001.GB7374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53693 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbZHEQHP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 12:07:15 -0400
In-Reply-To: <20090805072001.GB7374@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Russell / Tony,
> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Wednesday, August 05, 2009 12:50 PM
> To: Russell King - ARM Linux
> Cc: Kanigeri, Hari; linux-omap@vger.kernel.org; Hiroshi DOYU; 
> Shilimkar, Santosh
> Subject: Re: [PATCH v1 1/3] ARM:OMAP4 iommu:changes in iommu for OMAP4
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090805 01:45]:
> > On Tue, Aug 04, 2009 at 05:30:23PM -0500, Kanigeri, Hari wrote:
> > > -	obj->clk = clk_get(&pdev->dev, pdata->clk_name);
> > > -	if (IS_ERR(obj->clk))
> > > -		goto err_clk;
> > > +	/*
> > > +	 * FIX-ME: Replace with correct clk node when clk
> > > +	 * framework is available
> > > +	 */
> > > +	if (!cpu_is_omap44xx())	{
> > > +		obj->clk = clk_get(&pdev->dev, pdata->clk_name);
> > > +		if (IS_ERR(obj->clk))
> > > +			goto err_clk;
> > > +	}
> > 
> > I've no visibility on when these are going to get resolved, and it's
> > starting to concern me that there appears to be no progress on it,
> > especially as we have more and more code being merged with these
> > workarounds.  It's getting towards the point where enough is enough
> > and we need OMAP4 clk support in place, even if it is just a simple
> > stop-gap implementation rather than all these horrible hacks spread
> > through the code which one day will need to be found and removed.
> 
> Yeah I agree.
The initial set of clock patches are more or less ready now and we 
will posting them in next few days.

Regards,
Santosh
 