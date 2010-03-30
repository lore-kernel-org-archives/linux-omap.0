From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCHV2] OMAP3 PM: Fix for DSP Crash at OPP 1 and 2 under
 DVFS+SR operation
Date: Tue, 30 Mar 2010 15:15:16 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304800554@dbde02.ent.ti.com>
References: <1268313365-18495-1-git-send-email-vishwanath.bs@ti.com>
 <87pr32q12r.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC35608703047FFD56@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1003300329530.14474@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40567 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756077Ab0C3JpZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 05:45:25 -0400
In-Reply-To: <alpine.DEB.2.00.1003300329530.14474@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gulati, Shweta" <shweta.gulati@ti.com>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, March 30, 2010 3:01 PM
> To: Sripathy, Vishwanath
> Cc: Kevin Hilman; linux-omap@vger.kernel.org; Gulati, Shweta
> Subject: RE: [PATCHV2] OMAP3 PM: Fix for DSP Crash at OPP 1 and 2 under
> DVFS+SR operation
> 
> On Mon, 29 Mar 2010, Sripathy, Vishwanath wrote:
> 
> > > -----Original Message-----
> > > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> > >
> > > Please add this support by modifying/extending the existing clock/DPLL
> > > management code instead of manually writing registers.
> > >
> > Min/max dividers in clock framework are for dpll lock frequency, where
> > as in the patch, we configure dpll bypass frequency. Shall I add a new
> > API in dpll.c to configure bypass clock dividers?
> 
> That API is called clk_set_rate() and is already present as you can see by
> grep'ping clock3xxx_data.c for OMAP3430_MPU_CLK_SRC_MASK (as one example).
> 
Thanks, I will repost the patch.
> 
> - Paul
