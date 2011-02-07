From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 04/13] OMAP: Introduce dependent voltage domain support
Date: Mon, 7 Feb 2011 20:04:55 +0530
Message-ID: <c01ecc9572c8137857b195c0168f7207@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com><1295618465-15234-5-git-send-email-vishwanath.bs@ti.com>
 <87wrlfvmj0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:52632 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752577Ab1BGOe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 09:34:59 -0500
Received: by mail-fx0-f54.google.com with SMTP id 16so5114993fxm.41
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 06:34:56 -0800 (PST)
In-Reply-To: <87wrlfvmj0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Friday, February 04, 2011 9:07 PM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; patches@linaro.org; Thara Gopinath
> Subject: Re: [PATCH 04/13] OMAP: Introduce dependent voltage domain
> support
>
> Vishwanath BS <vishwanath.bs@ti.com> writes:
>
> > There could be dependencies between various voltage domains for
> > maintaining system performance or hardware limitation reasons
> > like VDD<X> should be at voltage v1 when VDD<Y> is at voltage v2.
> > This patch introduce dependent vdd information structures in the
> > voltage layer which can be used to populate these dependencies
> > for a voltage domain. This patch also adds support to scale
> > the dependent vdd and the scalable devices belonging to it
> > during the scaling of a main vdd through omap_voltage_scale.
> >
> > As part of this, some of the voltage layer structure definitions are
> moved from
> > voltage.c to voltage.h as it needs to be used in the dvfs layer for
> dependency
> > voltage handling.
>
> IMO, it would be cleaner to keep this in the voltage layer, and create
> and API for dependencies.
Dependency voltage handling needs some of dvfs layer functions (like
omap_dvfs_add_vdd_user, omap_dvfs_voltage_scale). Given that dvfs layer is
built on top of voltage layer, if these functions need to be implemented
in voltage layer, then voltage layer will end up using dvfs functions
leading to cross dependencies. So I thought keeping this implementation in
dvfs layer makes it more structured.

>
> > Based on original patch from Thara.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > Cc: Thara Gopinath <thara@ti.com>
> > ---
> >  arch/arm/mach-omap2/dvfs.c                |   87
> +++++++++++++++++
> >  arch/arm/mach-omap2/voltage.c             |  117
-----------------------
> >  arch/arm/plat-omap/include/plat/voltage.h |  148
> +++++++++++++++++++++++++++++
> >  3 files changed, 235 insertions(+), 117 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/dvfs.c b/arch/arm/mach-
> omap2/dvfs.c
> > index cefc2be..c9d3894 100755
> > --- a/arch/arm/mach-omap2/dvfs.c
> > +++ b/arch/arm/mach-omap2/dvfs.c
> > @@ -85,6 +85,7 @@ struct omap_vdd_dvfs_info {
> >  	struct mutex scaling_mutex; /* dvfs mutex */
> >  	struct voltagedomain *voltdm;
> >  	struct list_head dev_list;
> > +	struct device vdd_device;
>
> It's not clear what the usage of this device is for.
>
> It is never initialized, but seems to be used as a dummy device when
> calcluating dependencies.   Needs clarification.
This device is used for placing voltage request (omap_dvfs_add_vdd_user)
when dealing with dependent vdds. Eg: while scaling MPU VDD, we also scale
CORE VDD. So while placing voltage request for CORE VDD, this vdd_device
of MPU is used as the requesting device so that this request is stored as
a separate user.

Vishwa
>
> Kevin
