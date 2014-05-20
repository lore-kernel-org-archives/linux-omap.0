From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/7] mfd: twl4030-power: Add recommended idle
 configuration
Date: Tue, 20 May 2014 16:14:28 +0100
Message-ID: <20140520151428.GZ24991@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-5-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400031250-29542-5-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> These settings are based on the "Recommended Sleep Sequences for
> the Zoom Platform" pdf at:
>=20
> http://omappedia.com/wiki/File:Recommended_Sleep_Sequences_Zoom.pdf
>=20
> These settings assume most of the regulators are under control of
> Linux, and twl4030 only cuts off VDD1 and VDD2 during off-idle as
> Linux cannot do it.
>=20
> For any board specific changes to these, let's patch them in as
> changes to the generic data in the follow-up patches. This keeps
> the board specific changes small.
>=20
> Note that this does not consider the twl5030 errata 27 and 28.
> That can be added later on after it has been tested. For more
> information about errata 27 and 28, please see:
>=20
> https://github.com/openembedded/openembedded/blob/master/recipes/linu=
x/linux-omap-2.6.39/mfd/0012-MFD-TWL4030-workaround-changes-for-Erratum=
-27.patch
>=20
> Cc: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../devicetree/bindings/mfd/twl4030-power.txt      |   4 +
>  drivers/mfd/twl4030-power.c                        | 103 +++++++++++=
++++++++++
>  2 files changed, 107 insertions(+)

Assuming the magic numbers are replaced by transparent #defines:

  Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
