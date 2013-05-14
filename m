From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM : omap : remove __init for _enable_preprogram
Date: Tue, 14 May 2013 11:08:20 -0700
Message-ID: <8738tpxwmj.fsf@linaro.org>
References: <1368547621-8570-1-git-send-email-jp.francois@cynove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1368547621-8570-1-git-send-email-jp.francois@cynove.com> (jp
	francois's message of "Tue, 14 May 2013 18:07:01 +0200")
Sender: stable-owner@vger.kernel.org
To: jp.francois@cynove.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, paul@pwsan.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

jp.francois@cynove.com writes:

> _enable_preprogram is marked as __init, but is called from _enable wh=
ich is not.
> This results in oops once init is freed.
> Fix this by removing the __init marker.
>
> Signed-off-by: Jean-Philippe Fran=C3=A7ois <jp.francois@cynove.com>

Acked-by: Kevin Hilman <khilman@linaro.org>

Tony, this should probably be queued for v3.10-rc, and tagged for stabl=
e.

Kevin

> Index: b/arch/arm/mach-omap2/omap_hwmod.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2066,7 +2066,7 @@
>   * do so is present in the hwmod data, then call it and pass along t=
he
>   * return value; otherwise, return 0.
>   */
> -static int __init _enable_preprogram(struct omap_hwmod *oh)
> +static int _enable_preprogram(struct omap_hwmod *oh)
>  {
>  	if (!oh->class->enable_preprogram)
>  		return 0;
