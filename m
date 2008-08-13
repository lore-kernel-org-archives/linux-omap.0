From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 03/10] OMAP3 SRF: omap3 srf driver
Date: Wed, 13 Aug 2008 13:55:49 +0530
Message-ID: <00d801c8fd1e$3157c120$LocalHost@wipultra1382>
References: <87fxp95r45.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46979 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbYHMI0D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 04:26:03 -0400
In-Reply-To: <87fxp95r45.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?'=22H=C3=B6gander=22_Jouni'?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org


> -----Original Message-----
> From: "H=C3=B6gander" Jouni [mailto:jouni.hogander@nokia.com]=20
> Sent: Wednesday, August 13, 2008 12:39 PM
> To: ext Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 03/10] OMAP3 SRF: omap3 srf driver
>=20
> "ext Rajendra Nayak" <rnayak@ti.com> writes:
>=20
> > +int set_pd_latency(struct shared_resource *resp, u32 latency) {
> > +	u32 pd_lat_level, ind, i;
> > +	struct pd_latency_db *pd_lat_db;
> > +	struct powerdomain *pwrdm;
> > +
> > +	pd_lat_db =3D resp->resource_data;
> > +	pwrdm =3D pd_lat_db->pd;
> > +	pd_lat_level =3D PD_LATENCY_OFF;
> > +	/* using the latency db map to the appropriate PD state */
> > +	for (ind =3D 0; ind < PD_LATENCY_MAXLEVEL; ind++)
> > +		if (pd_lat_db->latency[ind] < latency)
> > +			pd_lat_level =3D ind;
> > +
> > +	resp->curr_level =3D pd_lat_level;
> > +	switch (pd_lat_level) {
> > +	case PWRDM_POWER_OFF:
> > +	case PWRDM_POWER_RET:
> > +		/* Errata 1.29: No transitions from INACTIVE to RET/OFF
> > +		 * possible.
> > +		 * Need to be taken care of here.
> > +		 */
> > +		if (pwrdm_read_pwrst(pwrdm) !=3D PWRDM_POWER_ON) {
> > +			/* Force the clock domains to ON */
> > +			for (i =3D 0; pwrdm->pwrdm_clkdms[i]; i++) {
> > +			=09
> omap2_clkdm_deny_idle(pwrdm->pwrdm_clkdms[i]);
> > +			=09
> omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[i]);
> > +			}
> > +			pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);
> > +			pwrdm_set_next_pwrst(pwrdm, pd_lat_level);
> > +			for (i =3D 0; pwrdm->pwrdm_clkdms[i]; i++) {
> > +			=09
> omap2_clkdm_sleep(pwrdm->pwrdm_clkdms[i]);
> > +			=09
> omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[i]);
> > +			}
> > +		} else
> > +			pwrdm_set_next_pwrst(pwrdm, pd_lat_level);
>=20
> You could use set_pwrdm_state from pm34xx.c here and update=20
> it if necessary. This way your workaround for errate 1.29=20
> would be available for cpuidle, pm_idle, srf and suspend.

Ok, will see how I can do that.=20

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
