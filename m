Return-Path: <SRS0=yxN7=5A=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D42CC10F29
	for <linux-omap@archiver.kernel.org>; Sun, 15 Mar 2020 18:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F077C206BE
	for <linux-omap@archiver.kernel.org>; Sun, 15 Mar 2020 18:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgCOS7A (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:59:00 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47574 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgCOS7A (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2020 14:59:00 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 59D921C032C; Sun, 15 Mar 2020 19:58:58 +0100 (CET)
Date:   Sun, 15 Mar 2020 19:58:58 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Arthur Demchenkov <spinal.by@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 01/15] power: supply: cpcap-battery: Fix battery full
 status reporting
Message-ID: <20200315185857.GA4914@amd>
References: <20200315151206.30909-1-spinal.by@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Don't report that the battery is fully charged if the charging current
> exceeds 100 mA.

Could you merge patches together for possibility of reasonable review?

> @@ -408,7 +408,8 @@ static bool cpcap_battery_full(struct cpcap_battery_d=
data *ddata)
>  	struct cpcap_battery_state_data *state =3D cpcap_battery_latest(ddata);
> =20
>  	if (state->voltage >=3D
> -	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000))
> +	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000) &&
> +		state->current_ua > -100000)

It seems that this 100mA threshold is changed about 3 times in the
series :-(.

Plus, it might be better to place booleans into struct, rather than
using "static bool" inside a function.

Could we get some kind of explanations for the whole series? 100mA is
rather high current for end of charge. If you stop updating
full capacity when "your" end of charge is met, you'll have battery
charged to more than 100%. I... don't think that makes sense.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5uevEACgkQMOfwapXb+vJ/FQCeP9CJ/bg5xDiegjgdK42wl99R
aawAnRCFvTDF/broueMSePSl0ZhatXVj
=Vekp
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
