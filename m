From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 06/13] OMAP: Disable Smartreflex across DVFS
Date: Mon, 7 Feb 2011 20:28:32 +0530
Message-ID: <50b4e70d473548a7cc2453332fe09cc5@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com><1295618465-15234-7-git-send-email-vishwanath.bs@ti.com>
 <871v3nu6m5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33037 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752926Ab1BGO6d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 09:58:33 -0500
Received: by mail-fx0-f53.google.com with SMTP id 11so6505809fxm.40
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 06:58:32 -0800 (PST)
In-Reply-To: <871v3nu6m5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Friday, February 04, 2011 9:36 PM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; patches@linaro.org; Thara Gopinath
> Subject: Re: [PATCH 06/13] OMAP: Disable Smartreflex across DVFS
>
> Vishwanath BS <vishwanath.bs@ti.com> writes:
>
> > From: Thara Gopinath <thara@ti.com>
> >
> > This patch disables smartreflex for a particular voltage
> > domain when the the voltage domain and the devices belonging
> > to it is being scaled and re-enables it back once the scaling
> > is done.
>
> Should also describe why.
>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > ---
> >  arch/arm/mach-omap2/dvfs.c |    7 +++++++
> >  1 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/dvfs.c b/arch/arm/mach-
> omap2/dvfs.c
> > index 05a9ce3..1e5492c 100755
> > --- a/arch/arm/mach-omap2/dvfs.c
> > +++ b/arch/arm/mach-omap2/dvfs.c
> > @@ -529,6 +529,9 @@ static int omap_dvfs_voltage_scale(struct
> omap_vdd_dvfs_info *dvfs_info)
> >
> >  	curr_volt = omap_voltage_get_nom_volt(voltdm);
> >
> > +	/* Disable smartreflex module across voltage and frequency
> scaling */
>
> comment redundant
>
> > +	omap_sr_disable(voltdm);
> > +
> >  	if (curr_volt == volt) {
> >  		is_volt_scaled = 1;
> >  	} else if (curr_volt < volt) {
> > @@ -536,6 +539,7 @@ static int omap_dvfs_voltage_scale(struct
> omap_vdd_dvfs_info *dvfs_info)
> >  		if (ret) {
> >  			pr_warning("%s: Unable to scale the %s to %ld
> volt\n",
> >  						__func__, voltdm->name,
> volt);
> > +			omap_sr_enable(voltdm);
>
> Would probably be cleaner to make this error path 'goto' the end where
> the SR enable and mutex_unlock are already being done.
Dependency vdd handing is not required in this case and if I use goto,
then I cannot skip dependency handling since it is done after unlocking
mutex.
>
> >  			mutex_unlock(&dvfs_info->scaling_mutex);
> >  			return ret;
> >  		}
> > @@ -570,6 +574,9 @@ static int omap_dvfs_voltage_scale(struct
> omap_vdd_dvfs_info *dvfs_info)
> >  	if (!is_volt_scaled && !ret)
> >  		omap_voltage_scale_vdd(voltdm, volt);
> >
> > +	/* Enable Smartreflex module */
>
> comment redundant
ok

Vishwa
>
> > +	omap_sr_enable(voltdm);
> > +
> >  	mutex_unlock(&dvfs_info->scaling_mutex);
> >
> >  	/* calculate the voltages for dependent vdd's */
>
> Kevin
