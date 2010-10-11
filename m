From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v4] ARM: Fix sparse warnings due to variables conflicts.
Date: Mon, 11 Oct 2010 09:14:26 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBABBC2D@dbde02.ent.ti.com>
References: <1286517186-29934-1-git-send-email-sourav.poddar@ti.com>
 <4CAF014D.7000909@ti.com> <20101008173615.GJ7558@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42202 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092Ab0JKDoi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Oct 2010 23:44:38 -0400
In-Reply-To: <20101008173615.GJ7558@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "Poddar, Sourav" <sourav.poddar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>

Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Friday, October 08, 2010 11:06 PM
> To: Menon, Nishanth
> Cc: Poddar, Sourav; linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Shilimkar, Santosh; G, 
> Manjunath Kondaiah; Varadarajan, Charulatha
> Subject: Re: [PATCH v4] ARM: Fix sparse warnings due to 
> variables conflicts.
> 
> * Nishanth Menon <nm@ti.com> [101008 04:24]:
> > Poddar, Sourav had written, on 10/08/2010 12:53 AM, the following:
> > >Fix the sparse warnings generated due to conflicts in 
> variables used in readl/writel.
> > >
> > >
> > >drivers/net/smc91x.c:312:8: warning: symbol '__v' shadows 
> an earlier 
> > >one
> > >drivers/net/smc91x.c:312:8: originally declared here
> > >
> > >With this change, about 200 sparse warnings are fixed.
> > The commit message could be a little more detailed.
> > see http://marc.info/?l=linux-omap&m=128648102511076&w=2
> > 
> > also should $subject say ARM: io: fix namespace conflict to better 
> > reflect the fix? sparse warnings are just an indication IMHO
> 
> BTW, also dropping the "OMAP: Convert write/read functions to 
> raw read/write".
> 
> That patch does not compute, and also ends up leaving files 
> with __raw_readw followed by writew..
> 

Why to revert patch "OMAP: Convert write/read functions to raw read/write" 
since we need to replace other __raw_read/__raw_writel functions if above 
patch gets accepted.

-Manjunath