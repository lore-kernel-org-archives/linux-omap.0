From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v3 1/4] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Fri, 28 Jan 2011 14:15:36 +0530
Message-ID: <AANLkTikZExkXPSzD3OrhZgC2pdoL5Lw8AqK6Ocso0mnq@mail.gmail.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com> <1295992862-6154-2-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40977 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755070Ab1A1IqR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 03:46:17 -0500
Received: by ywe10 with SMTP id 10so1101282ywe.5
        for <linux-omap@vger.kernel.org>; Fri, 28 Jan 2011 00:46:16 -0800 (PST)
In-Reply-To: <1295992862-6154-2-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

<<snip>>

> +
> +static int omap_dmic_set_dai_sysclk(struct snd_soc_dai *dai,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 int clk_id, unsigned int freq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 int dir)
> +{
> + =A0 =A0 =A0 struct omap_dmic *dmic =3D snd_soc_dai_get_drvdata(dai)=
;
> + =A0 =A0 =A0 struct clk *dmic_clk, *parent_clk;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 dmic_clk =3D clk_get(NULL, "dmic_fck");

It is preferred to use device pointer. instead of NULL.
(Applicable elsewhere)

> + =A0 =A0 =A0 if (IS_ERR(dmic_clk))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 switch (clk_id) {
> + =A0 =A0 =A0 case OMAP_DMIC_SYSCLK_PAD_CLKS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent_clk =3D clk_get(NULL, "pad_clks_=
ck");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(parent_clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_par;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case OMAP_DMIC_SYSCLK_SLIMBLUS_CLKS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent_clk =3D clk_get(NULL, "slimbus_c=
lk");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(parent_clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_par;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case OMAP_DMIC_SYSCLK_SYNC_MUX_CLKS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent_clk =3D clk_get(NULL, "dmic_sync=
_mux_ck");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(parent_clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_par;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dai->dev, "clk_id not supported=
 %d\n", clk_id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_par;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (dmic->sysclk !=3D clk_id) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* reparent not allowed if a stream is =
ongoing */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dmic->active > 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_busy;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* disable clock while reparenting */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dmic->active =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(dmi=
c->dev);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_parent(dmic_clk, parent=
_clk);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dmic->active =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(dmi=
c->dev);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmic->sysclk =3D clk_id;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dmic->clk_freq =3D clk_get_rate(dmic_clk);
> +
> +err_busy:
> + =A0 =A0 =A0 clk_put(parent_clk);
> +err_par:
> + =A0 =A0 =A0 clk_put(dmic_clk);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
