From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 10/13] OMAP3: Add voltage dependency table for VDD1.
Date: Sun, 30 Jan 2011 18:29:07 +0530
Message-ID: <ac935694980943538946b0bf4911af63@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com><1295618465-15234-11-git-send-email-vishwanath.bs@ti.com>
 <87hbcsblet.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:34650 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753744Ab1A3M7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 30 Jan 2011 07:59:06 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so5324593fxm.2
        for <linux-omap@vger.kernel.org>; Sun, 30 Jan 2011 04:59:04 -0800 (PST)
In-Reply-To: <87hbcsblet.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Saturday, January 29, 2011 6:01 AM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; patches@linaro.org; Thara Gopinath
> Subject: Re: [PATCH 10/13] OMAP3: Add voltage dependency table for
> VDD1.
>
> Hi Vishwa,
>
> Vishwanath BS <vishwanath.bs@ti.com> writes:
>
> > From: Thara Gopinath <thara@ti.com>
> >
> > In OMAP3, for perfomrance reasons when VDD1 is at voltage above
> > 1.075V, VDD2 should be at 1.15V for perfomrance reasons. This
> > patch introduce this cross VDD dependency for OMAP3 VDD1.
> >
> > Signed-off-by: Thara Gopinath <thara@ti.com>
>
> As you are now on the delivery path, your signoff should be here as
> well.
OK
>
> Some initial tests on 34xx turned up errors when trying to scale
> voltage:
>
>    omap_voltage_get_voltdata: Unable to match the current voltage with
> the voltagetable for vdd_core
>
> First, this error message wasn't very useful since I had no idea what
> the "current" voltage was.  Also, "current voltage" probably isn't the
> right word since to me, current voltage means the one currently set.
> This is actually the target voltage that is being looked up.

Agreed. Will fix it in the next version.
>
> In any case, root cause below...
>
> > This patch has checkpatch warnings for line over 80 chars. It is not
> fixed for
> > code readability.
>
> OK, this can either be left out, or added below the '---' as it's not
> needed in the final git history.

OK

>
> > ---
> >  arch/arm/mach-omap2/voltage.c |   42
> +++++++++++++++++++++++++++++++++++++++-
> >  1 files changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-
> omap2/voltage.c
> > index 92fe20d..8881c0c 100644
> > --- a/arch/arm/mach-omap2/voltage.c
> > +++ b/arch/arm/mach-omap2/voltage.c
> > @@ -191,6 +191,39 @@ static struct omap_volt_data
> omap44xx_vdd_core_volt_data[] = {
> >  	VOLT_DATA_DEFINE(0, 0, 0, 0),
> >  };
> >
> > +/* OMAP 3430 MPU Core VDD dependency table */
> > +static struct omap_vdd_dep_volt omap34xx_vdd1_vdd2_data[] = {
> > +	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP1_UV,
> .dep_vdd_volt = OMAP4430_VDD_CORE_OPP50_UV},
> > +	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP2_UV,
> .dep_vdd_volt = OMAP4430_VDD_CORE_OPP50_UV},
> > +	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP3_UV,
> .dep_vdd_volt = OMAP4430_VDD_CORE_OPP100_UV},
> > +	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP4_UV,
> .dep_vdd_volt = OMAP4430_VDD_CORE_OPP100_UV},
> > +	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP5_UV,
> .dep_vdd_volt = OMAP4430_VDD_CORE_OPP100_UV},
> > +	{.main_vdd_volt = 0, .dep_vdd_volt = 0},
> > +};
>
> This 34xx table has 4430 OPP voltages for CORE, which are clearly not
> right.  34xx has 3 CORE voltages to pick from, so I'm not sure which
> ones are right
>
> Please update this with the correct 34xx voltages and also validate on
> 34xx also.
Yes, will fix it.
Regarding 34xx testing, I did try to test it on 3430 SDP. However image
was not booting up when I used pm branch.
I see that with latest pm-core branch image boots up where as with pm
branch it does not. Is this a known issue?

Vishwa
>
> Thanks,
>
> Kevin
>
>
> > +static struct omap_vdd_dep_info omap34xx_vdd1_dep_info[] = {
> > +	{
> > +		.name	= "core",
> > +		.dep_table = omap34xx_vdd1_vdd2_data,
> > +	},
> > +};
> > +
> > +/* OMAP 3630 MPU Core VDD dependency table */
> > +static struct omap_vdd_dep_volt omap36xx_vdd1_vdd2_data[] = {
> > +	{.main_vdd_volt = OMAP3630_VDD_MPU_OPP50_UV,
> .dep_vdd_volt = OMAP3630_VDD_CORE_OPP50_UV},
> > +	{.main_vdd_volt = OMAP3630_VDD_MPU_OPP100_UV,
> .dep_vdd_volt = OMAP3630_VDD_CORE_OPP100_UV},
> > +	{.main_vdd_volt = OMAP3630_VDD_MPU_OPP120_UV,
> .dep_vdd_volt = OMAP3630_VDD_CORE_OPP100_UV},
> > +	{.main_vdd_volt = OMAP3630_VDD_MPU_OPP1G_UV,
> .dep_vdd_volt = OMAP3630_VDD_CORE_OPP100_UV},
> > +	{.main_vdd_volt = 0, .dep_vdd_volt = 0},
> > +};
> > +
> > +static struct omap_vdd_dep_info omap36xx_vdd1_dep_info[] = {
> > +	{
> > +		.name	= "core",
> > +		.dep_table = omap36xx_vdd1_vdd2_data,
> > +	},
> > +};
> > +
> >  static struct dentry *voltage_dir;
> >
> >  /* Init function pointers */
> > @@ -696,10 +729,15 @@ static int __init
> omap3_vdd_data_configure(struct omap_vdd_info *vdd)
> >  	}
> >
> >  	if (!strcmp(vdd->voltdm.name, "mpu")) {
> > -		if (cpu_is_omap3630())
> > +		if (cpu_is_omap3630()) {
> >  			vdd->volt_data = omap36xx_vddmpu_volt_data;
> > -		else
> > +			vdd->dep_vdd_info = omap36xx_vdd1_dep_info;
> > +			vdd->nr_dep_vdd =
> ARRAY_SIZE(omap36xx_vdd1_dep_info);
> > +		} else {
> >  			vdd->volt_data = omap34xx_vddmpu_volt_data;
> > +			vdd->dep_vdd_info = omap34xx_vdd1_dep_info;
> > +			vdd->nr_dep_vdd =
> ARRAY_SIZE(omap34xx_vdd1_dep_info);
> > +		}
> >
> >  		vdd->vp_reg.tranxdone_status =
> OMAP3430_VP1_TRANXDONE_ST_MASK;
> >  		vdd->vc_reg.cmdval_reg =
> OMAP3_PRM_VC_CMD_VAL_0_OFFSET;
