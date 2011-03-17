From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFCv2 2/2] AM35x: voltage: Basic initialization
Date: Thu, 17 Mar 2011 14:33:02 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C308088@dbde02.ent.ti.com>
References: <1300260723-19422-1-git-send-email-premi@ti.com>
 <1300260723-19422-3-git-send-email-premi@ti.com>
 <bde3ae98096e759b8baae09ffbe7c226@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C308046@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49592 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab1CQJDN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Mar 2011 05:03:13 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C308046@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Thursday, March 17, 2011 2:01 PM
> To: Sripathy, Vishwanath; linux-omap@vger.kernel.org
> Cc: Cousson, Benoit; paul@pwsan.com
> Subject: RE: [RFCv2 2/2] AM35x: voltage: Basic initialization
> 
> > -----Original Message-----
> > From: Sripathy, Vishwanath 
> > Sent: Wednesday, March 16, 2011 4:33 PM
> > To: Premi, Sanjeev; linux-omap@vger.kernel.org
> > Subject: RE: [RFCv2 2/2] AM35x: voltage: Basic initialization
> > 
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Sanjeev Premi
> > > Sent: Wednesday, March 16, 2011 1:02 PM
> > > To: linux-omap@vger.kernel.org
> > > Cc: Sanjeev Premi
> > > Subject: [RFCv2 2/2] AM35x: voltage: Basic initialization
> > >
> > > This patch adds the basic initialization of voltage layer
> > > for AM35x. Since AM35x doesn't support voltage scaling,
> > > Many functions emply fucntions have been defined to plug
> > > into existing voltage layer.
> > >
> > > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > > ---
> 
> [snip]...[snip]
> 
> > > +/**
> > > + * AM35x - Empty initialization of voltage processor
> > > + */
> > > +static void __init am3517_vp_init(struct omap_vdd_info *vdd)
> > > +{
> > > +}
> > > +
> > > +/**
> > >   * omap_voltage_early_init()- Volatage driver early init
> > >   */
> > >  static int __init omap_voltage_early_init(void)
> > >  {
> > >  	int i;
> > >
> > > -	if (cpu_is_omap34xx()) {
> > > +	if (cpu_is_omap3505() || cpu_is_omap3517()) {
> > > +		vdd_info		= am3517_vdd_info;
> > > +		nr_scalable_vdd		=
> > > AM3517_NR_SCALABLE_VDD;
> > As you have mentioned that there is no voltage scaling 
> supported, then
> > shoudn't nr_scalable_vdd = 0?
> > If nr_scalable_vdd is 0, then you probably would not need any 
> > other TPS
> > specific changes in Voltage.c as VP and VC initialization itself is
> > skipped.
> 
> [sp] Yes, there is no voltage scaling; but there are two 
> problems in the
>      flow.
>      Notice I had this value 0 in previous RFC; and yes I expected the
>      vp and vc to be excluded as you say; however, code isn't really
>      meant to do so.
>      Few loops using "nr_scalable_vdd" fail as value "0" 
> doesn't meet the
>      entry criteria. This problem is/was easily fixes by an additional
>      if statement.
> 
>      The things, however, get stuck in HWMOD again when the parent of

[sp] Being more specific:
     The parent here refers to "parent" vdd i.e. "vdd_name".

~sanjeev

>      omap3xxx_l3_main_hwmod is set as "core". Changing this causes
>      another cascade of changes leading to almost duplicating 
> the complete
>      hwmod structure for AM35x.
> 
>      Easy solution was to set use "core". Rest of the changes 
> in the patch
>      ensure that code flows properly - and there is no scaling.
> 
> ~sanjeev

> 
> > 
> > Vishwa
> > > +		vc_init			= am3517_vc_init;
> > > +		vp_init			= am3517_vp_init;
> > > +		vdd_data_configure	= am3517_vdd_data_configure;
> > > +	} else if (cpu_is_omap34xx()) {
> > >  		vdd_info = omap3_vdd_info;
> > >  		nr_scalable_vdd = OMAP3_NR_SCALABLE_VDD;
> > >  		vc_init = omap3_vc_init;
> > > --
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 