From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 04/13] OMAP: Introduce dependent voltage domain support
Date: Fri, 11 Feb 2011 10:11:49 +0530
Message-ID: <a0c6878aa2afa2a782c9d2daf27f9524@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com><1295618465-15234-5-git-send-email-vishwanath.bs@ti.com><87wrlfvmj0.fsf@ti.com><c01ecc9572c8137857b195c0168f7207@mail.gmail.com>
 <87sjvvx2w2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49287 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750973Ab1BKElw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 23:41:52 -0500
Received: by mail-fx0-f42.google.com with SMTP id 11so3186791fxm.15
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 20:41:51 -0800 (PST)
In-Reply-To: <87sjvvx2w2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, February 10, 2011 10:07 PM
> To: Vishwanath Sripathy
> Cc: linux-omap@vger.kernel.org; patches@linaro.org; Thara Gopinath
> Subject: Re: [PATCH 04/13] OMAP: Introduce dependent voltage domain
> support
>
> Vishwanath Sripathy <vishwanath.bs@ti.com> writes:
>
> [...]
>
> >> > diff --git a/arch/arm/mach-omap2/dvfs.c b/arch/arm/mach-
> >> omap2/dvfs.c
> >> > index cefc2be..c9d3894 100755
> >> > --- a/arch/arm/mach-omap2/dvfs.c
> >> > +++ b/arch/arm/mach-omap2/dvfs.c
> >> > @@ -85,6 +85,7 @@ struct omap_vdd_dvfs_info {
> >> >  	struct mutex scaling_mutex; /* dvfs mutex */
> >> >  	struct voltagedomain *voltdm;
> >> >  	struct list_head dev_list;
> >> > +	struct device vdd_device;
> >>
> >> It's not clear what the usage of this device is for.
> >>
> >> It is never initialized, but seems to be used as a dummy device when
> >> calcluating dependencies.   Needs clarification.
> >
> > This device is used for placing voltage request
> (omap_dvfs_add_vdd_user)
> > when dealing with dependent vdds. Eg: while scaling MPU VDD, we
> also scale
> > CORE VDD. So while placing voltage request for CORE VDD, this
> vdd_device
> > of MPU is used as the requesting device so that this request is stored
> as
> > a separate user.
>
> I was able to follow how it was used, and why.   But it is still not
> clear to the reader.
>
> First, the device is never initialized, so it's essentially a dummy
> device that remains initialized by default to all zeros.   So, any
> attempt to use any device APIs (e.g. dev_name, etc.) on this will not
> behave as expected.
>
> Second, the reason for this device and the need for the request to be
> stored as a separate user are not clear in the code and don't exist in
> the comments.
OK. I will add more comments to make these details more explicit.

Vishwa
>
> Kevin
>
>
>
>
