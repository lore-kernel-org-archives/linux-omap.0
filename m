From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 01/08] OMAP3 SRF: Add CORE rate table param in OMAP-PM
Date: Wed, 12 Nov 2008 10:29:50 +0530
Message-ID: <017001c94483$7fe61740$LocalHost@wipultra1382>
References: <87fxlxn43t.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41863 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYKLFAE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 00:00:04 -0500
In-Reply-To: <87fxlxn43t.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, November 12, 2008 6:38 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 01/08] OMAP3 SRF: Add CORE rate table 
> param in OMAP-PM
> 
> "Rajendra Nayak" <rnayak@ti.com> writes:
> 
> > This patch modifies the omap_pm_if_init API in OMAP-PM
> > layer to take the L3 interconnect/CORE OPP table
> > as an additional parameter.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Rajendra,
> 
> The current code does not handle well the case where board files pass
> in NULL values for the various rate tables.
> 
> In the init code, there are a few places where you use the 
> *_opps values
> without checking if they are non-NULL, and this will trigger faults.
> 
> Can you test and fix the case where your board file passes in NULL for
> all the OPP tables?

Yes, I will fix these and also remove the checks for SDP in the cpufreq driver.

> 
> Kevin
> 
> > ---
> >  arch/arm/mach-omap2/io.c                  |    2 +-
> >  arch/arm/plat-omap/include/mach/omap-pm.h |    4 +++-
> >  arch/arm/plat-omap/omap-pm-noop.c         |    5 ++++-
> >  arch/arm/plat-omap/omap-pm-srf.c          |    5 ++++-
> >  4 files changed, 12 insertions(+), 4 deletions(-)
> >
> > Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/omap-pm.h
> > ===================================================================
> > --- 
> linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/omap-pm.h	
> 2008-11-10 12:09:03.000000000 +0530
> > +++ 
> linux-omap-2.6/arch/arm/plat-omap/include/mach/omap-pm.h	
> 2008-11-10 12:09:12.000000000 +0530
> > @@ -57,12 +57,14 @@ int __init omap_pm_if_early_init(void);
> >   * omap_pm_if_init - OMAP PM init code called after clock fw init
> >   * @mpu_opp_table: array ptr to struct omap_opp for MPU
> >   * @dsp_opp_table: array ptr to struct omap_opp for DSP
> > + * @l3_opp_table : array ptr to struct omap_opp for CORE
> >   *
> >   * The main initialization code.  OPP tables are passed in 
> here.  The
> >   * "_if_" is to avoid name collisions with the PM idle-loop code.
> >   */
> >  int __init omap_pm_if_init(struct omap_opp *mpu_opp_table,
> > -			   struct omap_opp *dsp_opp_table);
> > +			   struct omap_opp *dsp_opp_table,
> > +			   struct omap_opp *l3_opp_table);
> >  
> >  /**
> >   * omap_pm_if_exit - OMAP PM exit code
> > Index: linux-omap-2.6/arch/arm/plat-omap/omap-pm-noop.c
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/plat-omap/omap-pm-noop.c	
> 2008-11-10 12:09:03.000000000 +0530
> > +++ linux-omap-2.6/arch/arm/plat-omap/omap-pm-noop.c	
> 2008-11-10 12:09:12.000000000 +0530
> > @@ -28,6 +28,7 @@
> >  
> >  static struct omap_opp *dsp_opps;
> >  static struct omap_opp *mpu_opps;
> > +static struct omap_opp *l3_opps;
> >  
> >  /*
> >   * Device-driver-originated constraints (via board-*.c files)
> > @@ -316,10 +317,12 @@ int __init omap_pm_if_early_init(void)
> >  
> >  /* Must be called after clock framework is initialized */
> >  int __init omap_pm_if_init(struct omap_opp *mpu_opp_table,
> > -			   struct omap_opp *dsp_opp_table)
> > +			   struct omap_opp *dsp_opp_table,
> > +			   struct omap_opp *l3_opp_table)
> >  {
> >  	mpu_opps = mpu_opp_table;
> >  	dsp_opps = dsp_opp_table;
> > +	l3_opps = l3_opp_table;
> >  	return 0;
> >  }
> >  
> > Index: linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/plat-omap/omap-pm-srf.c	
> 2008-11-10 12:09:03.000000000 +0530
> > +++ linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c	
> 2008-11-10 12:09:12.000000000 +0530
> > @@ -29,6 +29,7 @@
> >  
> >  static struct omap_opp *dsp_opps;
> >  static struct omap_opp *mpu_opps;
> > +static struct omap_opp *l3_opps;
> >  
> >  #define LAT_RES_POSTAMBLE "_latency"
> >  #define MAX_LATENCY_RES_NAME 30
> > @@ -346,10 +347,12 @@ int __init omap_pm_if_early_init(void)
> >  
> >  /* Must be called after clock framework is initialized */
> >  int __init omap_pm_if_init(struct omap_opp *mpu_opp_table,
> > -			   struct omap_opp *dsp_opp_table)
> > +			   struct omap_opp *dsp_opp_table,
> > +			   struct omap_opp *l3_opp_table)
> >  {
> >  	mpu_opps = mpu_opp_table;
> >  	dsp_opps = dsp_opp_table;
> > +	l3_opps = l3_opp_table;
> >  	resource_init(resources_omap);
> >  	return 0;
> >  }
> > Index: linux-omap-2.6/arch/arm/mach-omap2/io.c
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/io.c	
> 2008-11-10 12:09:03.000000000 +0530
> > +++ linux-omap-2.6/arch/arm/mach-omap2/io.c	2008-11-10 
> 12:09:12.000000000 +0530
> > @@ -206,7 +206,7 @@ void __init omap2_init_common_hw(struct 
> >  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
> >  	omapdev_init(omapdevs);
> >  	omap2_clk_init();
> > -	omap_pm_if_init(NULL, NULL);
> > +	omap_pm_if_init(NULL, NULL, NULL);
> >  	omap2_sdrc_init(sp);
> >  	gpmc_init();
> >  }
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

