From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCHV3 0/2] MPU/IVA bypass clock configuration
Date: Thu, 1 Apr 2010 14:57:55 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703048E579C@dbde02.ent.ti.com>
References: <> <1270117939-10730-1-git-send-email-vishwanath.bs@ti.com>
 <alpine.DEB.2.00.1004010315000.27004@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59509 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab0DAJ2D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:28:03 -0400
In-Reply-To: <alpine.DEB.2.00.1004010315000.27004@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, April 01, 2010 2:46 PM
> To: Sripathy, Vishwanath
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCHV3 0/2] MPU/IVA bypass clock configuration
> 
> Hi Vishwanath,
> 
> On Thu, 1 Apr 2010, Vishwanath BS wrote:
> 
> > DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM
> > UCs running DSP codec was earlier restricted as DSP crashed.
> > The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2.
> > The solution is to make sure DPLL1/DPLL2 bypass clock is always less
> > than maximum supported frequency for the specific OPP.
> > Typically these settings are to be done in bootloaders.
> >
> > All the patches have been tested on OMAP3630 ZOOM3  platform.
> > Comments adressed in V3:
> > 1. Used clk_set_rate API instead of directly writing to registers
> > 2. Split the patch into 2 patches.
> >
> > Vishwanath BS (4):
> > 	OMAP3: Set MPU and IVA bypass Clock Divider
> > 	OMAP3 PM: Set MPU and IVA bypass clock dividers in DVFS
> 
> On what tree do these patches apply?
I have applied them on top of wip_opp branch in Kevin's PM branch.
Regards
Vishwa

> 
> 
> - Paul
