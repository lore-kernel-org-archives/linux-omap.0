From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v5 1/3] omap3 gpmc: functionality enhancement
Date: Thu, 8 Jul 2010 09:24:09 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E10C9CF@dbde02.ent.ti.com>
References: <s-ghorai@ti.com>
 <1275637205-489-1-git-send-email-s-ghorai@ti.com>
 <1275637205-489-2-git-send-email-s-ghorai@ti.com>
 <20100707101840.GF1920@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E10C786@dbde02.ent.ti.com>
 <20100707130138.GW1920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44031 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab0GHDyU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 23:54:20 -0400
In-Reply-To: <20100707130138.GW1920@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "mike@compulab.co.il" <mike@compulab.co.il>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, July 07, 2010 6:32 PM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org;
> mike@compulab.co.il
> Subject: Re: [PATCH v5 1/3] omap3 gpmc: functionality enhancement
> 
> * Ghorai, Sukumar <s-ghorai@ti.com> [100707 15:26]:
> > > From: Tony Lindgren [mailto:tony@atomide.com]
> > >
> > > You should just replace this function with simple functions like we
> > > already
> > > have in gpmc.c rather than trying to pack everything into one function.
> > > Just add various gpmc_xxx_get/set functions rather than pass int *rval.
> >
> > [Ghorai] So I was having the same query very 1st time.
> > So we need to implement 15 separate functions to do the same as you
> suggested. And in my approach it's very easy to enhance the functionally
> in future, say to add new set/get. E.g. we need the similar cleanup for
> OneNAND code too.
> > So, would you please confirm once again with one is the best and should
> follow?
> 
> In general, we should have separate read and write functions.
> 
> Maybe you can group them a little bit? Some of them need the chip
> select, and some of them are generic. Then some of them are NAND
> specific.
[Ghorai] ok. And let me re-work this for next version.
> 
> Regards,
> 
> Tony
