Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF62475E3
	for <linux-omap@vger.kernel.org>; Fri, 25 Sep 2026 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356689; cv=none; b=Crb2aP+78/HzUbxu6eg9YciaahSpQY0TH9ffJgC6aXomXYLP3W4kl3IFrP9PAW5N0MzlML+qDgTFtNOlJ+hJh3hdEKb7XVJqmNV5lC2dcJQ8BI8IxRpK1YQt+orVElpRUN0c4KiQYDdXmTXa0f0it+bMRFtZF1Ib38/yi/zvcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356689; c=relaxed/simple;
	bh=ckr26Yw3wApR+lSdfbW/93b4yjmA7Lo5mPynSlL6p4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMd7x7NUSMn6l9Tdm7gbIJWzNFmXIBVKguysdSCF6chZv91mMECjc8hf3YkFvkQwXlbsvpgS3H63rneDyoEpxmy9eIMVvseCUxQcqrT++AV0CZprh4d9mtEgNpWuBdnXEcMmBsXwNsu8WygwERbHTsU8YOLUO7RLjQ8cUklGNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG9G4QWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG9G4QWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1B61F008A3
	for <linux-omap@vger.kernel.org>; Fri, 25 Sep 2026 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790356681;
	bh=Q+tqMDUbKQR8LyFFw6M+hDO4cRFA42XhLm/V//0Hxk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NG9G4QWb7YfdbwEELALMeh8yvVPlh7jqMwk8nvEKPErDk/YkczwRfKVF5S8KOE0GO
	 9UtMkBAxwUc2qu5TMa1OMqCgfgHhZQBf0ojJFxj/JqhZLgRrfOZz0fLW0qKGur4fie
	 Zr99TqPld5dREWrUvVFHkHHz8FX4yZBFEe6DIFWV3ur9yPx3EeEbY+iPJIfPFbmmII
	 YV8JgLcsCr/w8ksl6VlnI/Zxl9gsH3kHOqFVnbeYQmfEjfpa/7PqsPpl9Lyg9vwZ+p
	 cLUx0VP5NxQRMdxPA5J9/rq/RyAVNBwwGCEyyTt3BTcAKLNtyvrKgEXfKrVsWws24/
	 IaejLgTYDbQzA==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a64dff7acfso8883601fa.3
        for <linux-omap@vger.kernel.org>; Fri, 25 Sep 2026 10:18:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxeKbNe7wd3FBjp9pcHtrFMZGDskfiIsQbAHm3aY5tR8t5fjCVLsKJJQf2SFJvUEWiIbPKe43mEfgYQ@vger.kernel.org
X-Gm-Message-State: AFuF++ntWxpv5twol+S0+/fYKfKgakGWF0QOJSP6BRebdJumd8oAZFXE
	0DA5TZZvGgDNSSC/UIcosVPlYPBkTf9my6keTklNuSFirYlwo8y2d77nvjs79siMi/KYvtyzpQy
	WRJiRAzTNuvPBkIPa5eUSX0lvwggKDPk=
X-Received: by 2002:a05:651c:a205:20b0:3a3:74b9:8a7f with SMTP id
 38308e7fff4ca-3a649494426mr7927261fa.24.1790356680089; Fri, 25 Sep 2026
 10:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907064725.10686-1-hemanth.selam@gmail.com> <20260907064725.10686-3-hemanth.selam@gmail.com>
In-Reply-To: <20260907064725.10686-3-hemanth.selam@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 19:16:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0izZ8BvBDbfku5T0AuCYG3tJ1BsbtJ3ApaU+LqQVrQSiA@mail.gmail.com>
X-Gm-Features: AclHuK_D9Ujhsp9E9IzjgDza-mJM-p_UUW53v5ggM2n-Qw6qQxtAAmsBKUtfAUM
Message-ID: <CAJZ5v0izZ8BvBDbfku5T0AuCYG3tJ1BsbtJ3ApaU+LqQVrQSiA@mail.gmail.com>
Subject: Re: [PATCH 2/5] thermal: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, 
	Christian Loehle <christian.loehle@arm.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 8:47=E2=80=AFAM Hemanth Selam <hemanth.selam@gmail.c=
om> wrote:
>
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/thermal/thermal_core.c              |  2 +-
>  drivers/thermal/thermal_of.c                |  4 ++--
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 12 ++++++------
>  include/uapi/linux/thermal.h                |  8 ++++----
>  4 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 82e2f0d8a26d..5db52de33398 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1662,7 +1662,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>   *
>   * Return: On success returns a reference to an unique thermal zone with
>   * matching name equals to @name, an ERR_PTR otherwise (-EINVAL for inva=
lid
> - * paramenters, -ENODEV for not found and -EEXIST for multiple matches).
> + * parameters, -ENODEV for not found and -EEXIST for multiple matches).
>   */
>  struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *na=
me)
>  {
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 0217a49b08ae..f6566b5b916c 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -349,10 +349,10 @@ static bool thermal_of_should_bind(struct thermal_z=
one_device *tz,
>  }
>
>  /**
> - * thermal_of_zone_unregister - Cleanup the specific allocated ressource=
s
> + * thermal_of_zone_unregister - Cleanup the specific allocated resources
>   *
>   * This function disables the thermal zone and frees the different
> - * ressources allocated specific to the thermal OF.
> + * resources allocated specific to the thermal OF.
>   *
>   * @tz: a pointer to the thermal zone structure
>   */
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/therma=
l/ti-soc-thermal/ti-bandgap.c
> index ba43399d0b38..5c028d25a565 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -332,7 +332,7 @@ static inline int ti_bandgap_validate(struct ti_bandg=
ap *bgp, int id)
>   * ti_bandgap_read_counter() - read the sensor counter
>   * @bgp: pointer to bandgap instance
>   * @id: sensor id
> - * @interval: resulting update interval in miliseconds
> + * @interval: resulting update interval in milliseconds
>   */
>  static void ti_bandgap_read_counter(struct ti_bandgap *bgp, int id,
>                                     int *interval)
> @@ -352,7 +352,7 @@ static void ti_bandgap_read_counter(struct ti_bandgap=
 *bgp, int id,
>   * ti_bandgap_read_counter_delay() - read the sensor counter delay
>   * @bgp: pointer to bandgap instance
>   * @id: sensor id
> - * @interval: resulting update interval in miliseconds
> + * @interval: resulting update interval in milliseconds
>   */
>  static void ti_bandgap_read_counter_delay(struct ti_bandgap *bgp, int id=
,
>                                           int *interval)
> @@ -394,7 +394,7 @@ static void ti_bandgap_read_counter_delay(struct ti_b=
andgap *bgp, int id,
>   * ti_bandgap_read_update_interval() - read the sensor update interval
>   * @bgp: pointer to bandgap instance
>   * @id: sensor id
> - * @interval: resulting update interval in miliseconds
> + * @interval: resulting update interval in milliseconds
>   *
>   * Return: 0 on success or the proper error code
>   */
> @@ -427,7 +427,7 @@ int ti_bandgap_read_update_interval(struct ti_bandgap=
 *bgp, int id,
>   * ti_bandgap_write_counter_delay() - set the counter_delay
>   * @bgp: pointer to bandgap instance
>   * @id: sensor id
> - * @interval: desired update interval in miliseconds
> + * @interval: desired update interval in milliseconds
>   *
>   * Return: 0 on success or the proper error code
>   */
> @@ -471,7 +471,7 @@ static int ti_bandgap_write_counter_delay(struct ti_b=
andgap *bgp, int id,
>   * ti_bandgap_write_counter() - set the bandgap sensor counter
>   * @bgp: pointer to bandgap instance
>   * @id: sensor id
> - * @interval: desired update interval in miliseconds
> + * @interval: desired update interval in milliseconds
>   */
>  static void ti_bandgap_write_counter(struct ti_bandgap *bgp, int id,
>                                      u32 interval)
> @@ -486,7 +486,7 @@ static void ti_bandgap_write_counter(struct ti_bandga=
p *bgp, int id,
>   * ti_bandgap_write_update_interval() - set the update interval
>   * @bgp: pointer to bandgap instance
>   * @id: sensor id
> - * @interval: desired update interval in miliseconds
> + * @interval: desired update interval in milliseconds
>   *
>   * Return: 0 on success or the proper error code
>   */
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index 46a2633d33aa..36f3da2d6a7c 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -81,11 +81,11 @@ enum thermal_genl_event {
>         THERMAL_GENL_EVENT_CDEV_STATE_UPDATE,   /* Cdev state updated */
>         THERMAL_GENL_EVENT_TZ_GOV_CHANGE,       /* Governor policy change=
d  */
>         THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE,       /* CPU capability=
 changed */
> -       THERMAL_GENL_EVENT_THRESHOLD_ADD,       /* A thresold has been ad=
ded */
> -       THERMAL_GENL_EVENT_THRESHOLD_DELETE,    /* A thresold has been de=
leted */
> +       THERMAL_GENL_EVENT_THRESHOLD_ADD,       /* A threshold has been a=
dded */
> +       THERMAL_GENL_EVENT_THRESHOLD_DELETE,    /* A threshold has been d=
eleted */
>         THERMAL_GENL_EVENT_THRESHOLD_FLUSH,     /* All thresolds have bee=
n deleted */
> -       THERMAL_GENL_EVENT_THRESHOLD_UP,        /* A thresold has been cr=
ossed the way up */
> -       THERMAL_GENL_EVENT_THRESHOLD_DOWN,      /* A thresold has been cr=
ossed the way down */
> +       THERMAL_GENL_EVENT_THRESHOLD_UP,        /* A threshold has been c=
rossed the way up */
> +       THERMAL_GENL_EVENT_THRESHOLD_DOWN,      /* A threshold has been c=
rossed the way down */
>         __THERMAL_GENL_EVENT_MAX,
>  };
>  #define THERMAL_GENL_EVENT_MAX (__THERMAL_GENL_EVENT_MAX - 1)
> --

Applied as 7.4 material, thanks!
