From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/2] AM35xx: Runtime detection of the device
Date: Tue, 27 Oct 2009 23:38:22 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE0DCB84@dbde02.ent.ti.com>
References: <1256652150-5710-1-git-send-email-premi@ti.com>
 <20091027161115.GA16494@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52722 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756541AbZJ0SI2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 14:08:28 -0400
In-Reply-To: <20091027161115.GA16494@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
> Sent: Tuesday, October 27, 2009 9:41 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] AM35xx: Runtime detection of the device
> 
> Hi,
> 
> On Tue, Oct 27, 2009 at 03:02:30PM +0100, ext Sanjeev Premi wrote:
> > Add support to detect AM3505/AM3517 devices at runtime.
> > Also updates the CPU names printed during boot.
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  arch/arm/mach-omap2/id.c              |   43 
> ++++++++++++++++++++++++++++----
> >  arch/arm/plat-omap/include/plat/cpu.h |   12 +++++++++
> >  2 files changed, 49 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index 1c15112..87efb73 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -242,6 +242,21 @@ void __init omap3_check_revision(void)
> >  			omap_revision = OMAP3630_REV_ES1_0;
> >  		}
> >  		break;
> > +	case 0xb868:
> > +		/* Handle OMAP35xx/AM35xx devices
> > +		 *
> > +		 * Set the device to be OMAP3517 here. Actual device
> > +		 * is identified later based on the features.
> > +		 */
> > +		switch (rev) {
> > +		case 0:
> > +			omap_revision = OMAP3505_REV(rev);
> > +			break;
> > +		default:
> > +			/* Use the latest known revision as default */
> > +			omap_revision = OMAP3505_REV(rev);
> 
> if both are the same, what's the point of having this switch ?

[sp] I was just following the style for 3630, while re-basing
     this patch :(
> 
> > +		}
> > +		break;
> >  	default:
> >  		/* Unknown default to latest silicon rev as default*/
> >  		omap_revision = OMAP3630_REV_ES1_0;
> > @@ -267,20 +282,36 @@ void __init omap3_cpuinfo(void)
> >  	 * and CPU class bits.
> >  	 */
> >  	if (cpu_is_omap3630())
> > -		strcpy(cpu_name, "3630");
> > +		strcpy(cpu_name, "OMAP3630");
> > +	else if (omap_rev() && OMAP35XX_CLASS) {
> > +		/*
> > +		 * AM3517, AM3505 devices
> > +		 */
> > +		if (omap3_has_sgx()) {
> > +			omap_revision = OMAP3517_REV(rev);
> > +			strcpy(cpu_name, "AM3517");
> > +		}
> > +		else {
> 
> according to CodingStyle this should be:
> 
> 		} else {

[sp] Yes. Missed it.

> 
> -- 
> balbi
> 
> 