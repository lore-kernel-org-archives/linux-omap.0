From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 09/10 V4] omap3: pm: introduce 3630 opps
Date: Fri, 11 Dec 2009 05:47:22 -0600
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012B9F4998@dlee02.ent.ti.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com>
 <1260339435-20294-2-git-send-email-nm@ti.com>
 <1260339435-20294-3-git-send-email-nm@ti.com>
 <1260339435-20294-4-git-send-email-nm@ti.com>
 <1260339435-20294-5-git-send-email-nm@ti.com>
 <1260339435-20294-6-git-send-email-nm@ti.com>
 <1260339435-20294-7-git-send-email-nm@ti.com>
 <1260339435-20294-8-git-send-email-nm@ti.com>
 <1260339435-20294-9-git-send-email-nm@ti.com>
 <1260339435-20294-10-git-send-email-nm@ti.com>
 <20091211101212.GC8299@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42906 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762171AbZLKLrZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 06:47:25 -0500
In-Reply-To: <20091211101212.GC8299@esdhcp037198.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

> From: Eduardo Valentin [mailto:eduardo.valentin@nokia.com]
> Sent: Friday, December 11, 2009 4:12 AM
> 
> Hello Nishanth,
> 
> On Wed, Dec 09, 2009 at 07:17:14AM +0100, ext Nishanth Menon wrote:
> > Introduce the OMAP3630 OPPs including the defined OPP tuples.
> >
> > Further information on OMAP3630 can be found here:
> >
> http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=61
> 23&navigationId=12836&contentId=52606
> >
> > OMAP36xx family introduces:
> > VDD1 with 4 OPPs, of which OPP3 & 4 are available only on devices yet
> > to be introduced in 36xx family. Meanwhile, VDD2 has 2 opps.
> >
> > Device Support of OPPs->
> >            |<-3630-600->| (default)
> >            |<-      3630-800    ->| (device: TBD)
> >            |<-      3630-1000            ->| (device: TBD)
> > H/w OPP-> OPP50 OPP100       OPP-Turbo   OPP1G-SB
> > VDD1      OPP1  OPP2         OPP3        OPP4
> > VDD2      OPP1  OPP2         OPP2        OPP2
> >
> > Note:
> > a) TI h/w naming for OPPs are now standardized in terms of OPP50, 100,
> >    Turbo and SB. This maps as shown above to the opp IDs (s/w term).
> > b) For boards which need custom VDD1/2 OPPs, the opp table can be
> >    updated by the board file on a need basis after the
> >    omap3_pm_init_opp_table call. The OPPs introduced here are the
> >    official OPP table at this point in time.
> >
> 
> [ ... ]
> 
> >
> > +static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
> > +	/* OPP1 - OPP50 */
> > +	OMAP_OPP_DEF(true,  300000000, 930000),
> > +	/* OPP2 - OPP100 */
> > +	OMAP_OPP_DEF(true,  600000000, 1100000),
> > +	/* OPP3 - OPP-Turbo */
> > +	OMAP_OPP_DEF(false, 800000000, 1260000),
> > +	/* OPP4 - OPP-SB */
> > +	OMAP_OPP_DEF(false, 1000000000, 1310000),
> > +	OMAP_OPP_DEF_TERMINATOR
> 
> What else needs to be done in order to enable OPP-Turbo & OPP-SB ?

Sigh - long story ;) but in a short line: you just need to call opp_enable(freq) in your board file while we send a future patch to enable auto detection: DISCLAIMER: for 3630, there may not be a way to differentiate between devices other than some specific one - and board file may need to enable the opp that board has (shrug.. I know it is not a good idea - but there are some non-technical reasons involved  - still waiting for confirmation before being able to share additional info on list).

> 
> 
> > +};
> > +
> > +static struct omap_opp_def __initdata omap36xx_l3_rate_table[] = {
> > +	/* OPP1 - OPP50 */
> > +	OMAP_OPP_DEF(true, 100000000, 930000),
> > +	/* OPP2 - OPP100, OPP-Turbo, OPP-SB */
> > +	OMAP_OPP_DEF(true, 200000000, 1137500),
> > +	OMAP_OPP_DEF_TERMINATOR
> > +};
> > +
> > +static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
> > +	/* OPP1 - OPP50 */
> > +	OMAP_OPP_DEF(true,  260000000, 930000),
> > +	/* OPP2 - OPP100 */
> > +	OMAP_OPP_DEF(true,  520000000, 1100000),
> > +	/* OPP3 - OPP-Turbo */
> > +	OMAP_OPP_DEF(false, 660000000, 1260000),
> > +	/* OPP4 - OPP-SB */
> > +	OMAP_OPP_DEF(false, 875000000, 1310000),
> > +	OMAP_OPP_DEF_TERMINATOR
> > +};
> > +
> >  /* OMAP3 Rate Table */
> >  struct omap_opp *omap3_mpu_rate_table;
> >  struct omap_opp *omap3_dsp_rate_table;
> > @@ -1296,18 +1328,27 @@ static void __init configure_vc(void)
> >  void __init omap3_pm_init_opp_table(void)
> >  {
> >  	int i;
> > +	struct omap_opp_def **omap3_opp_def_list;
> >  	struct omap_opp_def *omap34xx_opp_def_list[] = {
> >  		omap34xx_mpu_rate_table,
> >  		omap34xx_l3_rate_table,
> >  		omap34xx_dsp_rate_table
> >  	};
> > +	struct omap_opp_def *omap36xx_opp_def_list[] = {
> > +		omap36xx_mpu_rate_table,
> > +		omap36xx_l3_rate_table,
> > +		omap36xx_dsp_rate_table
> > +	};
> >  	struct omap_opp **omap3_rate_tables[] = {
> >  		&omap3_mpu_rate_table,
> >  		&omap3_l3_rate_table,
> >  		&omap3_dsp_rate_table
> >  	};
> > +
> > +	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
> > +				omap34xx_opp_def_list;
> >  	for (i = 0; i < ARRAY_SIZE(omap3_rate_tables); i++) {
> > -		*omap3_rate_tables[i] =
> opp_init_list(omap34xx_opp_def_list[i]);
> > +		*omap3_rate_tables[i] = opp_init_list(omap3_opp_def_list[i]);
> >  		/* We dont want half configured system at the moment */
> >  		BUG_ON(IS_ERR(omap3_rate_tables[i]));
> >  	}
> > --
> > 1.6.3.3
> 
> --
> Eduardo Valentin
