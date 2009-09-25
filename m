From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Runtime detection of OMAP35x devices
Date: Fri, 25 Sep 2009 16:26:08 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB355E@dbde02.ent.ti.com>
References: <1250612150-16345-1-git-send-email-premi@ti.com>
 <20090922202835.GB4919@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44849 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbZIYK4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 06:56:12 -0400
In-Reply-To: <20090922202835.GB4919@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Wednesday, September 23, 2009 1:59 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] Runtime detection of OMAP35x devices
> 

[snip]---[snip]---[snip]

> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index 03b80f2..f041d3b 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -187,7 +187,6 @@ void __init omap3_check_revision(void)
> >  	u32 cpuid, idcode;
> >  	u16 hawkeye;
> >  	u8 rev;
> > -	char *rev_name = "ES1.0";
> >  
> >  	/*
> >  	 * We cannot access revision registers on ES1.0.
> > @@ -197,7 +196,7 @@ void __init omap3_check_revision(void)
> >  	cpuid = read_cpuid(CPUID_ID);
> >  	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) 
> == 0x0)) {
> >  		omap_revision = OMAP3430_REV_ES1_0;
> > -		goto out;
> > +		return;
> >  	}
> >  
> >  	/*
> 
> Looks like the above two changes break printing the ES1.0 rev
> name during the boot.
> 

[sp] This change did not break the printing of ES1.0 as it relates
     to postponing the print. However, I see that ES1.0 was not
     being printed. (see below).

     Submitting a fresh patch with the fix.

> 
> 
> > @@ -214,29 +213,21 @@ void __init omap3_check_revision(void)
> >  		switch (rev) {
> >  		case 0:
> >  			omap_revision = OMAP3430_REV_ES2_0;
> > -			rev_name = "ES2.0";
> >  			break;
> >  		case 2:
> >  			omap_revision = OMAP3430_REV_ES2_1;
> > -			rev_name = "ES2.1";
> >  			break;
> >  		case 3:
> >  			omap_revision = OMAP3430_REV_ES3_0;
> > -			rev_name = "ES3.0";
> >  			break;
> >  		case 4:
> >  			omap_revision = OMAP3430_REV_ES3_1;
> > -			rev_name = "ES3.1";
> >  			break;
> >  		default:
> >  			/* Use the latest known revision as default */
> >  			omap_revision = OMAP3430_REV_ES3_1;
> > -			rev_name = "Unknown revision\n";
> >  		}
> >  	}

[sp] Here the print for ES1.0 was missing.

> > -
> > -out:
> > -	pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
> >  }
> >  
> >  #define OMAP3_SHOW_FEATURE(feat)		\
> > @@ -248,6 +239,54 @@ out:
> >  
> >  void __init omap3_cpuinfo(void)
> >  {
> > +	u8 rev = GET_OMAP_REVISION();
> > +	char cpu_name[16], cpu_rev[16];
> > +
> > +	/* OMAP3430 and OMAP3530 are assumed to be same.
> > +	 *
> > +	 * OMAP3525, OMAP3515 and OMAP3503 can be detected only based
> > +	 * on available features. Upon detection, update the CPU id
> > +	 * and CPU class bits.
> > +	 */
> > +	if (omap3_has_iva() && omap3_has_sgx()) {
> > +		strcpy(cpu_name, "3430/3530");
> > +	}
> > +	else if (omap3_has_sgx()) {
> > +		omap_revision = OMAP3525_REV (rev);
> > +		strcpy(cpu_name, "3525");
> > +	}
> > +	else if (omap3_has_iva()) {
> > +		omap_revision = OMAP3515_REV (rev);
> > +		strcpy(cpu_name, "3515");
> > +	}
> > +	else {
> > +		omap_revision = OMAP3503_REV (rev);
> > +		strcpy(cpu_name, "3503");
> > +	}
> 
> Please remove the spaces in the *_REV(rev) macro calls above.

[sp] Will take care in follow-up patch.

> 
> 
> > +
> > +	switch (rev) {
> > +	case 0x10:
> > +		strcpy(cpu_rev, "2.0");
> > +		break;
> > +	case 0x20:
> > +		strcpy(cpu_rev, "2.1");
> > +		break;
> > +	case 0x30:
> > +		strcpy(cpu_rev, "3.0");
> > +		break;
> > +	case 0x40:
> > +		strcpy(cpu_rev, "3.1");
> > +		break;
> > +	default:
> > +		/* Use the latest known revision as default */
> > +		strcpy(cpu_rev, "3.1");
> > +	}
> 
> I believe the above should use the defines to avoid thing
> breaking if renumbering the defines?
> 
> case 0x10 should be case CHIP_IS_OMAP3430ES2
> case 0x20 should be case CHIP_IS_OMAP3430ES3
> ...
> 
> But instead you're renaming the defined ES values so what we
> have defined is different from your naming?

[sp] The intent is to use omap_revision bits 15:8 alone.
     If the concern was use of explicit values, I can
     use #defines instead.

> 
> Can you please check that, and also boot on various boards
> to confirm. I suspect the TI documentation is messed up for
> the ES numbering..

[sp] I do not have and ES 1.0 board. Other that that, I have
     tested on all ES revisions. And found it to be workig fine.
     Will do the test again before submitting the follow-up.

> 
> Other than that, let's plan on merging this too after
> 2.6.32-rc1.
> 
> Regards,
> 
> Tony
> 
> 

Best regards,
Sanjeev

[snip]---[snip]---[snip]


> 