From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] omap2plus: voltage: Trivial linking fix 'undefined reference'
Date: Wed, 5 Jan 2011 00:18:23 +0530
Message-ID: <2a7055e7c506648a2a48a0454756687b@mail.gmail.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-5-git-send-email-santosh.shilimkar@ti.com> <4D236AFB.2050301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:51084 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751150Ab1ADSsZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:48:25 -0500
Received: by mail-gx0-f180.google.com with SMTP id 19so6809029gxk.11
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 10:48:25 -0800 (PST)
In-Reply-To: <4D236AFB.2050301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Wednesday, January 05, 2011 12:16 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; tony@atomide.com;
> linux-arm-kernel@lists.infradead.org; Thara Gopinath; Kevin Hilman
> Subject: Re: [PATCH 4/5] omap2plus: voltage: Trivial linking fix
> 'undefined reference'
>
> Santosh Shilimkar had written, on 01/04/2011 12:26 PM, the
> following:
> [..]
>
> > diff --git a/arch/arm/plat-omap/include/plat/voltage.h
> b/arch/arm/plat-omap/include/plat/voltage.h
> > index 710f4ea..c095351 100644
> > --- a/arch/arm/plat-omap/include/plat/voltage.h
> > +++ b/arch/arm/plat-omap/include/plat/voltage.h
> > @@ -65,9 +65,6 @@ struct voltagedomain {
> >  	char *name;
> >  };
> >
> > -/* API to get the voltagedomain pointer */
> > -struct voltagedomain *omap_voltage_domain_lookup(char *name);
> > -
> >  /**
> >   * struct omap_volt_data - Omap voltage specific data.
> >   * @voltage_nominal:	The possible voltage value in uV
> > @@ -131,6 +128,9 @@ int omap_voltage_register_pmic(struct
> voltagedomain *voltdm,
> >  		struct omap_volt_pmic_info *pmic_info);
> >  void omap_change_voltscale_method(struct voltagedomain *voltdm,
> >  		int voltscale_method);
> > +/* API to get the voltagedomain pointer */
> > +struct voltagedomain *omap_voltage_domain_lookup(char *name);
> > +
> >  int omap_voltage_late_init(void);
> >  #else
> >  static inline int omap_voltage_register_pmic(struct voltagedomain
> *voltdm,
> > @@ -144,6 +144,10 @@ static inline int
> omap_voltage_late_init(void)
> >  {
> >  	return -EINVAL;
> >  }
> > +static inline struct voltagedomain
> *omap_voltage_domain_lookup(char *name)
> > +{
> > +	return NULL;
> the omap_voltage_domain_lookup uses ERR_PTR() for all return values
> which are handled by the callers with IS_ERR()
>
> I think you should return ERR_PTR(-EINVAL)
>
The expected return value is pointer type and hence used
NULL.
