From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 04/10] OMAP3 SRF: OMAP PM srf implementation
Date: Wed, 13 Aug 2008 10:16:38 +0300
Message-ID: <87bpzx5qqx.fsf@trdhcp146196.ntc.nokia.com>
References: <47171.192.168.10.89.1218460024.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21288 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbYHMHRX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 03:17:23 -0400
In-Reply-To: <47171.192.168.10.89.1218460024.squirrel@dbdmail.itg.ti.com> (ext
	Rajendra Nayak's message of "Mon, 11 Aug 2008 18:37:04 +0530 (IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Rajendra,

"ext Rajendra Nayak" <rnayak@ti.com> writes:

> +/*
> + * Powerdomain usecounting hooks
> + */
> +
> +void omap_pm_pwrdm_active(struct powerdomain *pwrdm)
> +{
> +	char *res_name;
> +
> +	if (!pwrdm) {
> +		WARN_ON(1);
> +		return;
> +	};
> +
> +	if (!strcmp(pwrdm->name, "wkup_pwrdm") ||
> +			 !strcmp(pwrdm->name, "core_pwrdm"))
> +		return;
> +
> +	pr_debug("OMAP PM: powerdomain %s is becoming active\n", pwrdm->nam=
e);
> +
> +	res_name =3D get_lat_res_name(pwrdm->name);
> +	/* Request for a zero latency which puts the Power Domain in ON sta=
te*/
> +	resource_request(res_name, &omap_pm_dev, 0);
> +	return;
> +}
> +
> +void omap_pm_pwrdm_inactive(struct powerdomain *pwrdm)
> +{
> +	char *res_name;
> +
> +	if (!pwrdm) {
> +		WARN_ON(1);
> +		return;
> +	};
> +
> +	if (!strcmp(pwrdm->name, "wkup_pwrdm") ||
> +			!strcmp(pwrdm->name, "core_pwrdm"))
> +		return;
> +
> +	pr_debug("OMAP PM: powerdomain %s is becoming inactive\n",
> +		 pwrdm->name);
> +
> +	res_name =3D get_lat_res_name(pwrdm->name);
> +	/* Release the latency requested */
> +	resource_release(res_name, &omap_pm_dev);
> +	return;
> +}

=46or what these two functions are? Why they are requesting/releasing r=
esource?
=20
> +
> +/*
> + * Should be called before clk framework since clk fw will call
> + * omap_pm_pwrdm_{in,}active()
> + */
> +int __init omap_pm_if_early_init(void)
> +{
> +	return 0;
> +}

Why clock framework (omap2_clkdm_clk_enable/disable) is calling
omap_pm_pwrdm_{in,}active()? Is it for keeping track of OFF
transitions?

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
