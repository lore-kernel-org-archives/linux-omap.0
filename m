From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP: powerdomains: Make all powerdomain target states
 as ON at init
Date: Fri, 15 Jul 2011 11:03:16 +0300
Message-ID: <20110715080315.GC2611@legolas.emea.dhcp.ti.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42015 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964873Ab1GOIDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 04:03:21 -0400
Received: by ywb3 with SMTP id 3so590453ywb.18
        for <linux-omap@vger.kernel.org>; Fri, 15 Jul 2011 01:03:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 13, 2011 at 08:56:27AM +0530, Santosh Shilimkar wrote:
> From: Rajendra Nayak <rnayak@ti.com>
>=20
> Program all powerdomain target state as ON; This is to
> prevent domains from hitting low power states (if bootloader
> has target states set to something other than ON) and potentially
> even losing context while PM is not fully initilized.
> The PM late init code can then program the desired target
> state for all the power domains.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powe=
rdomain.c
> index e0490bc..e61866c 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -109,6 +109,16 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
> =20
>  	list_add(&pwrdm->node, &pwrdm_list);
> =20
> +	/*
> +	* Program all powerdomain target state as ON; This is to
> +	* prevent domains from hitting low power states (if bootloader
> +	* has target states set to something other than ON) and potentially
> +	* even losing context while PM is not fully initilized.
> +	* The PM late init code can then program the desired target
> +	* state for all the power domains.
> +	*/
> +	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);

Just out of curiosity, I was wondering if it really makes sense to power
up all power domains during boot just to avoid loosing context. Doesn't
hwmod/omap_device soft-reset all IPs during initialization ? If that's
really the case, shouldn't we then choose which powerdomains are
strictly necessary for boot and only power those up ?

Sorry if this is a non-sensical question, but I was curious about it
;-)

--=20
balbi

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOH/RDAAoJEAv8Txj19kN1v48IAJ/oEpVJ3qW8U4CfWnpBtKO7
1POp8wITHU71BAhNhng8OoF2itb/Iitt+N+TUwGnjaUwASKkD3JtL5SiGifWsQyX
itQ2ilgNtla5ifa8PDN2vd4e4TYV9Myloa5reXs8IO51A/f6jztiMCLL788DYPOG
NXwyuDoNb1lM5akb2Ja9rubmADGk5UuBf62RRoRIHqvtc2prwoqxNjxUA2k4TLKD
BbL2bPVEZ2/LMJymB/9WKMSmn09DIB3ttN5aLIu7hh7gP/6ww6tlzF0Fks12CyrF
9XzDppedI7BdOzcbYaKtvOkBWWn8Rk5mab0zWRx6qm96h1wdAMQ/Zq0Fl2O6ioQ=
=hbQ8
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
