From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH/RESEND #3 5/7] arm: omap: smartreflex: clean ups all over
Date: Tue, 15 Nov 2011 19:39:51 -0500
Message-ID: <22157.1321403991@turing-police.cc.vt.edu>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
            <1321346765-16633-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1321403991_2702P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: Your message of "Tue, 15 Nov 2011 10:46:03 +0200."
             <1321346765-16633-6-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

--==_Exmh_1321403991_2702P
Content-Type: text/plain; charset=us-ascii

On Tue, 15 Nov 2011 10:46:03 +0200, Felipe Balbi said:

> -	int				srid;
> -	int				ip_type;
> +	struct list_head		node;
> +	struct platform_device		*pdev;
> +	struct omap_sr_nvalue_table	*nvalue_table;
> +	struct voltagedomain		*voltdm;

As long as you're de-tabifying the function names that caused the problem...

>  	int				nvalue_count;
> -	bool				autocomp_active;
> -	bool				is_suspended;

Why are you leaveing the rest of the struct tabified out to East Podunk?

--==_Exmh_1321403991_2702P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFOwwZXcC3lWbTT17ARAiLzAJ4u3ZBprGL4Syg8SoSZvvgb5FG9IgCeP1Op
JPvlZUB2nWmsyV34T7rqXxE=
=LBAG
-----END PGP SIGNATURE-----

--==_Exmh_1321403991_2702P--
