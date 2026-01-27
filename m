Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A1243376
	for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2026 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769545992; cv=none; b=afT2GMlxksJiTyQpvjIAecEl64HcVJsXUwdq1aSzCK7qaJc7T47estPOePgkCNc+FVthZiUp5fkJNQHYLcTVnQBYpqdaapTvF4mgDIEdJqF1Ize3s5Ip0eQRNgpLkBNnlH0tRIkfxjBP3vk6/KJgk5DWjpKdxRCK/l5+oNELqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769545992; c=relaxed/simple;
	bh=xRBVbS79QYoJBWjyLZhkqZ+QeffyspKgfvBxjH45YH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUAf31wbG197UzKTj11+VRTMhy/79Uf5DafQIFW5q4FuEGS/cN9GAunrarR2+/C/bsElZwXc+IbQZzOtXlK6d6MwYF1jk23xQnRTQORXI02bZfclCPcaeBq5WxBN9sIowLhsck8q7krZM8VwSiq231gLhju3r0Ch0ggpM/NT8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UenXtg0H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UenXtg0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54B0C2BCB2
	for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2026 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769545991;
	bh=xRBVbS79QYoJBWjyLZhkqZ+QeffyspKgfvBxjH45YH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UenXtg0H34aAl8tmmcKIFrZILglkeGYXV6+i530uPqcnDxOX0mFVXHsJoiVcWxWp1
	 oEMVhN9Y62njCDhzyf/M14kDN39dfHO9bEaytJhCIFyBdj+g54z7QUuuUdxPm+TgP1
	 uIcZ7M/VcAiE3/G8gb9DFbCO8uYKnanceF+bqfH0UBc/TodzlzcWPaTUI+jgkFhjfM
	 1JAtbjTh3AxZF9pK7VatXwLfwxZPsDDURRjqY21S1ArbbE+rMSS14Hgx0o5ZoUaWOB
	 SL4xK2DpiCxU0BZZQ1vhw4zxAdNyDZRhbbsx7zkv47SobMC3nH2LnmEq4nTTUL/5KM
	 RL+t5lMy0qgGg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-662cb4bef90so1704335eaf.0
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2026 12:33:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtQTEDcrM6IWxNpqjgLrudMkGO9+0TPz2iix6X3x5uMa8mf2HBI/XhfKjHH4cNDeqZ/OCkbj3rSN8w@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1XxUwOJPNL3ucJF20KTvsvMpKfg5Yn4HMJqlMRA2BG5Ky2bGF
	uuteBBvspa2wV5nYjLtmMXvPYsKvcQvdTGxrtnlsA2C0isxvK9d0fHi1+qEhQDre1gIQkNsUqDb
	Y4v66f6JLZn+YGH25GoFCRJGhRWhnpp4=
X-Received: by 2002:a05:6820:4b85:b0:65f:54c7:3c5f with SMTP id
 006d021491bc7-662f203b51emr2100743eaf.24.1769545990855; Tue, 27 Jan 2026
 12:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127201725.35883-1-dakr@kernel.org>
In-Reply-To: <20260127201725.35883-1-dakr@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 21:32:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hwJB_tYd=sgT2jPm94ypXdEhj0wuGtdOg+TZDRCocVJw@mail.gmail.com>
X-Gm-Features: AZwV_Qj9YAA_prmGKyJDi3TuK9JQuFTSH_BVTfMHVlFVfJ39PRvLmioDDYdThFg
Message-ID: <CAJZ5v0hwJB_tYd=sgT2jPm94ypXdEhj0wuGtdOg+TZDRCocVJw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: omap: do not register driver in probe()
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org, 
	will@kernel.org, grygorii.strashko@ti.com, ssantosh@kernel.org, 
	khilman@kernel.org, linusw@kernel.org, brgl@kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 9:17=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Commit 11a78b794496 ("ARM: OMAP: MPUIO wake updates") registers the
> omap_mpuio_driver from omap_mpuio_init(), which is called from
> omap_gpio_probe().
>
> However, it neither makes sense to register drivers from probe()
> callbacks of other drivers, nor does the driver core allow registering
> drivers with a device lock already being held.
>
> The latter was revealed by commit dc23806a7c47 ("driver core: enforce
> device_lock for driver_match_device()") leading to a potential deadlock
> condition described in [1].
>
> Additionally, the omap_mpuio_driver is never unregistered from the
> driver core, even if the module is unloaded.
>
> Hence, register the omap_mpuio_driver from the module initcall and
> unregister it in module_exit().
>
> Link: https://lore.kernel.org/lkml/DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org/=
 [1]
> Fixes: dc23806a7c47 ("driver core: enforce device_lock for driver_match_d=
evice()")
> Fixes: 11a78b794496 ("ARM: OMAP: MPUIO wake updates")
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/gpio/gpio-omap.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index e136e81794df..e39723b5901b 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -799,10 +799,13 @@ static struct platform_device omap_mpuio_device =3D=
 {
>
>  static inline void omap_mpuio_init(struct gpio_bank *bank)
>  {
> -       platform_set_drvdata(&omap_mpuio_device, bank);
> +       static bool registered;
>
> -       if (platform_driver_register(&omap_mpuio_driver) =3D=3D 0)
> -               (void) platform_device_register(&omap_mpuio_device);
> +       platform_set_drvdata(&omap_mpuio_device, bank);
> +       if (!registered) {
> +               (void)platform_device_register(&omap_mpuio_device);
> +               registered =3D true;
> +       }
>  }
>
>  /*---------------------------------------------------------------------*=
/
> @@ -1575,13 +1578,24 @@ static struct platform_driver omap_gpio_driver =
=3D {
>   */
>  static int __init omap_gpio_drv_reg(void)
>  {
> -       return platform_driver_register(&omap_gpio_driver);
> +       int ret;
> +
> +       ret =3D platform_driver_register(&omap_mpuio_driver);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D platform_driver_register(&omap_gpio_driver);
> +       if (ret)
> +               platform_driver_unregister(&omap_mpuio_driver);
> +
> +       return ret;
>  }
>  postcore_initcall(omap_gpio_drv_reg);
>
>  static void __exit omap_gpio_exit(void)
>  {
>         platform_driver_unregister(&omap_gpio_driver);
> +       platform_driver_unregister(&omap_mpuio_driver);
>  }
>  module_exit(omap_gpio_exit);
>
>
> base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
> --
> 2.52.0
>
