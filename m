From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH] OMAP3: SR: Fix SR driver to check for omap-pm return
 values
Date: Wed, 29 Apr 2009 17:15:34 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030548B7A8@dbde02.ent.ti.com>
References: <49F8069F.9020205@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52052 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbZD2Lps convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 07:45:48 -0400
In-Reply-To: <49F8069F.9020205@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Roger Quadros [mailto:ext-roger.quadros@nokia.com] 
> Sent: Wednesday, April 29, 2009 1:20 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP3: SR: Fix SR driver to check for 
> omap-pm return values
> 
> ext Rajendra Nayak wrote:
> > This patch checks for the return values of omap_pm_vddx_get_opp()
> > in SR driver and acts accordingly. With no SRF layer 
> enabled the OMAP-PM layer
> > api is unable to return the current OPP.
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > ---
> >  arch/arm/mach-omap2/smartreflex.c |   42 
> +++++++++++++++++++++++++++++++++---
> >  1 files changed, 38 insertions(+), 4 deletions(-)
> > 
> 
> > +		if (!omap_pm_vdd1_get_opp())
> > +			/* Assume Nominal OPP as current OPP unknown */
> > +			vsel = mpu_opps[VDD1_OPP3].vsel;
> > +		else
> > +			vsel = mpu_opps[omap_pm_vdd1_get_opp()].vsel;
> > +
> 
> Hi Rajendra,
> 
>    By this approach, what will be the implications if the 
> bootloader had set the 
> OPP to something different than your assumption?
>    I think the best approach would be to modify the PM layer 
> to at least return 
> correct OPP and Frequency values. What do you think?

The PM layer was designed to be just a thin wrapper layer, which
on its own does not have any way to return the right OPP.
It relies on SRF or something else below to provide the right info.

The assumption of OPP comes in only with SRF disabled and nothing
else present to replace the functionality. 
Any reason why SRF is disabled in Nokia builds?

>    We should not expect every driver using X_get_opp to 
> assume the OPP if it 
> returns error.
> 
> Please see this thread to see the alternative solution.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12021.html
> 
> I know it uses resource framework even if we set PM_NONE or 
> PM_NOOP, but only 
> for getting the correct OPP/frequency values.
> 
> regards,
> -roger
> 
> 