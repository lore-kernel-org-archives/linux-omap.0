From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] OMAP3: iovmm: fix compiler warning
Date: Wed, 23 Sep 2009 08:45:38 +0300 (EEST)
Message-ID: <20090923.084538.48517375.Hiroshi.DOYU@nokia.com>
References: <20090918.175434.229727484.Hiroshi.DOYU@nokia.com>
	<20090922213617.GD4919@atomide.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDA2CB2B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22405 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbZIWFpo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 01:45:44 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDA2CB2B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: premi@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hi Premi,

From: "ext Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] OMAP3: iovmm: fix compiler warning
Date: Wed, 23 Sep 2009 06:06:43 +0200

> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > Sent: Wednesday, September 23, 2009 3:06 AM
> > To: Hiroshi DOYU
> > Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] OMAP3: iovmm: fix compiler warning
> > 
> > * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [090918 07:54]:
> > > Hi Premi,
> > > 
> > > From: "ext Premi, Sanjeev" <premi@ti.com>
> > > Subject: RE: [PATCH] OMAP3: iovmm: fix compiler warning
> > > Date: Fri, 18 Sep 2009 16:40:29 +0200
> > > 
> > > [...]
> > > 
> 
> [snip]--[snip]
> 
> > > > Shouldn't we go with the original patch itself?
> > > 
> > > Right, the original is better, then;)
> > 
> > Can you please specify which one (if any) should be queued?
> > 
> > Do you mean http://patchwork.kernel.org/patch/48467/
> 
> [sp] Yes. That's right.

I know it's nitpicky, but it's better to remove a space after casting
as pointed previously.

Would it be possible to send the update version?
