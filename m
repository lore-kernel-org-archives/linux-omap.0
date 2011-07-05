From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv5 01/11] OMAP: prcm: switch to a chained IRQ handler
 mechanism
Date: Tue, 5 Jul 2011 14:18:43 +0300
Message-ID: <20110705111842.GZ2820@legolas.emea.dhcp.ti.com>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
 <1309861677-2769-2-git-send-email-t-kristo@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kncZREqT6Wt3NQEl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:33958 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932110Ab1GELSu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 07:18:50 -0400
Received: by bwd7 with SMTP id 7so5700358bwd.30
        for <linux-omap@vger.kernel.org>; Tue, 05 Jul 2011 04:18:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309861677-2769-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, Felipe Balbi <balbi@ti.com>


--kncZREqT6Wt3NQEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 05, 2011 at 01:27:47PM +0300, Tero Kristo wrote:
> @@ -854,20 +802,35 @@ static int __init omap3_pm_init(void)
>  	/* XXX prcm_setup_regs needs to be before enabling hw
>  	 * supervised mode for powerdomains */
>  	prcm_setup_regs();
> +	ret =3D omap_prcm_irq_init();
> +	if (ret) {
> +		pr_err("omap_prcm_irq_init() failed with %d\n", ret);
> +		goto err_prcm_irq_init;
> +	}
> +
> +	prcm_wkup_irq =3D omap_prcm_event_to_irq("wkup");
> +	prcm_io_irq =3D omap_prcm_event_to_irq("io");
> +
> +	ret =3D request_irq(prcm_wkup_irq, _prcm_int_handle_wakeup,
> +			IRQF_NO_SUSPEND | IRQF_DISABLED, "prcm_wkup", NULL);

IRQF_DISABLED shouldn't be used anymore ;-)

<linux/interrupt.h>:

 45  * IRQF_DISABLED - keep irqs disabled when calling the action handler.
 46  *                 DEPRECATED. This flag is a NOOP and scheduled to be =
removed


--=20
balbi

--kncZREqT6Wt3NQEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOEvMSAAoJEAv8Txj19kN1pY8H/jk0rrmoh3qUNRHly72/DutL
MAGgNcret/lNufbbZjs8QK3pA6tmV+nWhPsfp8KOZ6IUORqYPGx6nvzPD5M+tVDR
/BZavb+DSChAOXNmhjMOFLPZ/4SRyB5tHzFyieuhm40Ss71CavhZsre5QqxFjUTK
KqcI86tCO/iKB+6Is72V95cQOwMjAJkkGVctuQ83XXy/lGYzT21+cF9o8w+JIUCy
6O5F5qhUkQvM4zmP5K1zb50s3hDS2ouR2d4N7dNlGyIkQuLjwnFDWLSxrj6Tgg1Z
dnMPieq1BtUu/0NtwPgXpiPg/nPLY3w+qrfCnSzLd+LMl/d+2ry2kIArKkWTW2E=
=3c6n
-----END PGP SIGNATURE-----

--kncZREqT6Wt3NQEl--
