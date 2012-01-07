From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH] irqdomain: Initialize number of IRQs for simple domains
Date: Sat, 7 Jan 2012 12:40:16 +0100
Message-ID: <20120107114016.GA3655@avionic-0098.mockup.avionic-design.de>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <CACxGe6sXmC2A0ihsK=rmQ8jQ61xcc7re=LgzPPJm8wHvvkFb4Q@mail.gmail.com>
 <20120106162016.GB5593@avionic-0098.mockup.avionic-design.de>
 <20120106213422.GF7457@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4873083779370080757=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120106213422.GF7457-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Daniel Walker <dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:ARM/QUALCOMM MSM..." <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "open list:OMAP SUPPORT" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Victor <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, "open list:ARM/ATMEL AT91RM9..." <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--===============4873083779370080757==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Grant Likely wrote:
> No.  ERR_PTR is a horrible pattern because you cannot tell by looking
> at a prototype that returns a pointer whether or not the correct
> failure test is "if (!ptr)" or "if (IS_ERR(ptr))".  Unless it is
> absolutely critical for an error code to be returned (which isn't the
> case here) I will not accept new code that uses ERR_PTR().
>=20
> In this case, if irq_domain_add_simple() fails, then something is very
> wrong.  I'd much rather the routine complain loudly regardless of the
> error condition.

Okay, I'll keep the WARN_ON(1) and simply return NULL.

> Actually, looking again at irq_domain_generate_simple() it should
> probably succeed even if it cannot find a matching node since an
> irq_domain does more than just device tree translation.  Although,
> irq_domain_generate_simple() is a stop-gap solution that will
> eventually be removed.

So I'll just handle errors in irq_domain_generate_simple() the same way as =
in
irq_domain_add_simple() and will return NULL if no matching node is found.

Thierry

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8ILyAACgkQZ+BJyKLjJp/JwACePLsFSxiy8jJiGLgoa6n8DdhF
L28AnAj8DDRhLKFrXdwjuuRK6sRpGWyA
=fbJq
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

--===============4873083779370080757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4873083779370080757==--
