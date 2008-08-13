From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 04/10] OMAP3 SRF: OMAP PM srf implementation
Date: Wed, 13 Aug 2008 11:52:44 +0300
Message-ID: <87y73147qb.fsf@trdhcp146196.ntc.nokia.com>
References: <00d701c8fd1e$1716b730$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40108 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbYHMIw5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 04:52:57 -0400
In-Reply-To: <00d701c8fd1e$1716b730$LocalHost@wipultra1382> (ext Rajendra
	Nayak's message of "Wed, 13 Aug 2008 13:55:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, ext Paul Walmsley <paul@pwsan.com>

"ext Rajendra Nayak" <rnayak@ti.com> writes:

> =20
>
>> -----Original Message-----
>> From: "H=C3=B6gander" Jouni [mailto:jouni.hogander@nokia.com]=20
>> Sent: Wednesday, August 13, 2008 12:47 PM
>> To: ext Rajendra Nayak
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 04/10] OMAP3 SRF: OMAP PM srf implementation
>>=20
>> Hello Rajendra,
>>=20
>> "ext Rajendra Nayak" <rnayak@ti.com> writes:
>>=20
>> > +/*
>> > + * Powerdomain usecounting hooks
>> > + */
>> > +
>> > +void omap_pm_pwrdm_active(struct powerdomain *pwrdm) {
>> > +	char *res_name;
>> > +
>> > +	if (!pwrdm) {
>> > +		WARN_ON(1);
>> > +		return;
>> > +	};
>> > +
>> > +	if (!strcmp(pwrdm->name, "wkup_pwrdm") ||
>> > +			 !strcmp(pwrdm->name, "core_pwrdm"))
>> > +		return;
>> > +
>> > +	pr_debug("OMAP PM: powerdomain %s is becoming active\n",=20
>> > +pwrdm->name);
>> > +
>> > +	res_name =3D get_lat_res_name(pwrdm->name);
>> > +	/* Request for a zero latency which puts the Power=20
>> Domain in ON state*/
>> > +	resource_request(res_name, &omap_pm_dev, 0);
>> > +	return;
>> > +}
>> > +
>> > +void omap_pm_pwrdm_inactive(struct powerdomain *pwrdm) {
>> > +	char *res_name;
>> > +
>> > +	if (!pwrdm) {
>> > +		WARN_ON(1);
>> > +		return;
>> > +	};
>> > +
>> > +	if (!strcmp(pwrdm->name, "wkup_pwrdm") ||
>> > +			!strcmp(pwrdm->name, "core_pwrdm"))
>> > +		return;
>> > +
>> > +	pr_debug("OMAP PM: powerdomain %s is becoming inactive\n",
>> > +		 pwrdm->name);
>> > +
>> > +	res_name =3D get_lat_res_name(pwrdm->name);
>> > +	/* Release the latency requested */
>> > +	resource_release(res_name, &omap_pm_dev);
>> > +	return;
>> > +}
>>=20
>> For what these two functions are? Why they are=20
>> requesting/releasing resource?
>
> Its needed so that a power domain is turned ON while the first clock =
node in it is=20
> requested, and turned OFF while the last clock node is disabled.

Isn't this already taken care by clock framework? If not I think it
should be. I mean directly requesting domain to wakeup rather than
requesting resource which causes it to wakeup.

Paul, Any comment on this?

>
>> =20
>> > +
>> > +/*
>> > + * Should be called before clk framework since clk fw will call
>> > + * omap_pm_pwrdm_{in,}active()
>> > + */
>> > +int __init omap_pm_if_early_init(void) {
>> > +	return 0;
>> > +}
>>=20
>> Why clock framework (omap2_clkdm_clk_enable/disable) is=20
>> calling omap_pm_pwrdm_{in,}active()? Is it for keeping track=20
>> of OFF transitions?
>
> This is for clockdomain layer to indicate that a powerdomain should
> wake up or be put to sleep

Same comment as above.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
