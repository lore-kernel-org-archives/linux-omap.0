From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 04/10] OMAP3 SRF: OMAP PM srf implementation
Date: Wed, 13 Aug 2008 13:55:03 +0530
Message-ID: <00d701c8fd1e$1716b730$LocalHost@wipultra1382>
References: <87bpzx5qqx.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46949 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755040AbYHMIZS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 04:25:18 -0400
In-Reply-To: <87bpzx5qqx.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?'=22H=C3=B6gander=22_Jouni'?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

=20

> -----Original Message-----
> From: "H=C3=B6gander" Jouni [mailto:jouni.hogander@nokia.com]=20
> Sent: Wednesday, August 13, 2008 12:47 PM
> To: ext Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 04/10] OMAP3 SRF: OMAP PM srf implementation
>=20
> Hello Rajendra,
>=20
> "ext Rajendra Nayak" <rnayak@ti.com> writes:
>=20
> > +/*
> > + * Powerdomain usecounting hooks
> > + */
> > +
> > +void omap_pm_pwrdm_active(struct powerdomain *pwrdm) {
> > +	char *res_name;
> > +
> > +	if (!pwrdm) {
> > +		WARN_ON(1);
> > +		return;
> > +	};
> > +
> > +	if (!strcmp(pwrdm->name, "wkup_pwrdm") ||
> > +			 !strcmp(pwrdm->name, "core_pwrdm"))
> > +		return;
> > +
> > +	pr_debug("OMAP PM: powerdomain %s is becoming active\n",=20
> > +pwrdm->name);
> > +
> > +	res_name =3D get_lat_res_name(pwrdm->name);
> > +	/* Request for a zero latency which puts the Power=20
> Domain in ON state*/
> > +	resource_request(res_name, &omap_pm_dev, 0);
> > +	return;
> > +}
> > +
> > +void omap_pm_pwrdm_inactive(struct powerdomain *pwrdm) {
> > +	char *res_name;
> > +
> > +	if (!pwrdm) {
> > +		WARN_ON(1);
> > +		return;
> > +	};
> > +
> > +	if (!strcmp(pwrdm->name, "wkup_pwrdm") ||
> > +			!strcmp(pwrdm->name, "core_pwrdm"))
> > +		return;
> > +
> > +	pr_debug("OMAP PM: powerdomain %s is becoming inactive\n",
> > +		 pwrdm->name);
> > +
> > +	res_name =3D get_lat_res_name(pwrdm->name);
> > +	/* Release the latency requested */
> > +	resource_release(res_name, &omap_pm_dev);
> > +	return;
> > +}
>=20
> For what these two functions are? Why they are=20
> requesting/releasing resource?

Its needed so that a power domain is turned ON while the first clock no=
de in it is=20
requested, and turned OFF while the last clock node is disabled.

> =20
> > +
> > +/*
> > + * Should be called before clk framework since clk fw will call
> > + * omap_pm_pwrdm_{in,}active()
> > + */
> > +int __init omap_pm_if_early_init(void) {
> > +	return 0;
> > +}
>=20
> Why clock framework (omap2_clkdm_clk_enable/disable) is=20
> calling omap_pm_pwrdm_{in,}active()? Is it for keeping track=20
> of OFF transitions?

This is for clockdomain layer to indicate that a powerdomain should wak=
e up or be put to sleep

>=20
> --
> Jouni H=C3=B6gander
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
