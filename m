From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/5] omap2plus: voltage: Trivial warning fix 'no return statement'
Date: Wed, 5 Jan 2011 00:16:30 +0530
Message-ID: <355afda07dcc328c046ca30fcd248355@mail.gmail.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com> <4D236A5D.9040803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41686 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104Ab1ADSqc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:46:32 -0500
Received: by mail-yx0-f177.google.com with SMTP id 34so7727962yxm.22
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 10:46:31 -0800 (PST)
In-Reply-To: <4D236A5D.9040803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Wednesday, January 05, 2011 12:14 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; tony@atomide.com;
> linux-arm-kernel@lists.infradead.org; Thara Gopinath; Kevin Hilman
> Subject: Re: [PATCH 3/5] omap2plus: voltage: Trivial warning fix 'no
> return statement'
>
> Santosh Shilimkar had written, on 01/04/2011 12:26 PM, the
> following:
> [..]
> > diff --git a/arch/arm/plat-omap/include/plat/voltage.h
> b/arch/arm/plat-omap/include/plat/voltage.h
> > index 0ff1233..710f4ea 100644
> > --- a/arch/arm/plat-omap/include/plat/voltage.h
> > +++ b/arch/arm/plat-omap/include/plat/voltage.h
> > @@ -134,7 +134,10 @@ void omap_change_voltscale_method(struct
> voltagedomain *voltdm,
> >  int omap_voltage_late_init(void);
> >  #else
> >  static inline int omap_voltage_register_pmic(struct voltagedomain
> *voltdm,
> > -		struct omap_volt_pmic_info *pmic_info) {}
> > +		struct omap_volt_pmic_info *pmic_info)
> > +{
> > +	return 0;
> since we dont really succeed registering the pmic to voltage layer,
> return -EINVAL?
>
Ok. Will take this in v2

Regards,
Santosh
