From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/3] omap3 gpmc: functionality enhancement
Date: Wed, 7 Jul 2010 16:01:38 +0300
Message-ID: <20100707130138.GW1920@atomide.com>
References: <s-ghorai@ti.com>
 <1275637205-489-1-git-send-email-s-ghorai@ti.com>
 <1275637205-489-2-git-send-email-s-ghorai@ti.com>
 <20100707101840.GF1920@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E10C786@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53999 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab0GGNBn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 09:01:43 -0400
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E10C786@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "mike@compulab.co.il" <mike@compulab.co.il>

* Ghorai, Sukumar <s-ghorai@ti.com> [100707 15:26]:
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > 
> > You should just replace this function with simple functions like we
> > already
> > have in gpmc.c rather than trying to pack everything into one function.
> > Just add various gpmc_xxx_get/set functions rather than pass int *rval.
> 
> [Ghorai] So I was having the same query very 1st time. 
> So we need to implement 15 separate functions to do the same as you suggested. And in my approach it's very easy to enhance the functionally in future, say to add new set/get. E.g. we need the similar cleanup for OneNAND code too. 
> So, would you please confirm once again with one is the best and should follow? 

In general, we should have separate read and write functions.

Maybe you can group them a little bit? Some of them need the chip
select, and some of them are generic. Then some of them are NAND
specific.

Regards,

Tony
