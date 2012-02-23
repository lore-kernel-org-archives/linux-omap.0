From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv5 03/14] arm: omap3+: voltage: parameter segregation
Date: Wed, 22 Feb 2012 19:37:30 -0600
Message-ID: <CAOMWX4d+M9oagDtmSqG=X8Ln4kUEyLaqpfB9Pz0Y+6RmK=sjYw@mail.gmail.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com> <1329833098-19900-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:57345 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752288Ab2BWBhv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 20:37:51 -0500
Received: by mail-wi0-f177.google.com with SMTP id o1so599144wic.8
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 17:37:50 -0800 (PST)
In-Reply-To: <1329833098-19900-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, Feb 21, 2012 at 08:04, Tero Kristo <t-kristo@ti.com> wrote:
[...]
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/volt=
age.h
> index 949938d..940a0d6 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h

[...]
> @@ -171,6 +169,18 @@ struct omap_voltdm_pmic {
> =A0 =A0 =A0 =A0u8 (*uv_to_vsel) (unsigned long uV);
> =A0};
>
> +struct omap_vp_param {
> + =A0 =A0 =A0 u32 vddmax;
> + =A0 =A0 =A0 u32 vddmin;
> +};
> +

Thinking a little deeper about this(SoC level vdd min and max) on a
slightly different angle- core of the question that intend to answer
are:
 - what is the least voltage we want to allow in active transtion? it
should not be lower than retention voltage.
- what is the max voltage we want to allow in active transition? it
should be the max Nom voltage of all the OPPs for that domain.

In effect, why do we even need to register
"voltdm->vp_param->vdd[min|max]"? We already have that info - right?
On the other hand it might be safer to do this way to handle quirks in
future SoCs.. but thought I'd spit it out anyways..

> +struct omap_vc_param {
and elsewhere - please add kernel-doc struct documentation as well
when new structs are introduced?
> + =A0 =A0 =A0 u32 on;
> + =A0 =A0 =A0 u32 onlp;
> + =A0 =A0 =A0 u32 ret;
> + =A0 =A0 =A0 u32 off;
> +};
> +
[...]

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
