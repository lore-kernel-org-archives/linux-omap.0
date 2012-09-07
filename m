From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/17] OMAPDSS: clean up dss_mgr_set_timings
Date: Fri, 07 Sep 2012 13:11:13 +0300
Message-ID: <1347012673.2646.3.camel@deskari>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
	 <1346833555-31258-13-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-O/JyR9SOGwz+s/Rkhb2a"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:37680 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760336Ab2IGKLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 06:11:22 -0400
Received: by lbbgj3 with SMTP id gj3so1762614lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 03:11:20 -0700 (PDT)
In-Reply-To: <1346833555-31258-13-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-O/JyR9SOGwz+s/Rkhb2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-09-05 at 11:25 +0300, Tomi Valkeinen wrote:
> dss_mgr_set_timings() can only be called when the output is not active.
> This means that most of the code in the function is extra, as there's no
> need to write the values to registers, etc, because that will be handled
> when the output will be enabled.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/apply.c |   18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/ap=
ply.c
> index 53629dd..1b49019 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -1314,21 +1314,19 @@ void dss_mgr_set_timings(struct omap_overlay_mana=
ger *mgr,
>  		const struct omap_video_timings *timings)
>  {
>  	unsigned long flags;
> -
> -	mutex_lock(&apply_lock);
> +	struct mgr_priv_data *mp =3D get_mgr_priv(mgr);
> =20
>  	spin_lock_irqsave(&data_lock, flags);
> =20
> -	dss_apply_mgr_timings(mgr, timings);
> -
> -	dss_write_regs();
> -	dss_set_go_bits();
> +	if (mp->enabled) {
> +		DSSERR("cannot set timings for %s: manager needs to be disabled\n",
> +			mgr->name);
> +		goto out;
> +	}

There was a problem with this one. When using manual update display, we
call set_timings before each update, and the mgr is enabled at that
time.

I'll fix this by changing the check from mp->enabled to mp->updating.
That flag tells if the DISPC channel is actually enabled or not. Enabled
flag just tells that the channel is being reserved, although for auto
update displays that also implies "updating".

But do you see any reason to call set_timings before each update? It was
required when we have partial update support, but now we support only
full screen updates, so isn't it enough to set the timings just once
when configuring?

 Tomi


--=-O/JyR9SOGwz+s/Rkhb2a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQSchBAAoJEPo9qoy8lh71lOAP/iNAycI1mPgK99Gcm5ToG0JA
DNyxEYI3gJLX2tpfWaMPgffL6eDtcDkhan+AUg8pUjjwCrbTaJioZ0qF99eH0E5J
2VO5dDL+jtcikMoy/v2SgB2zl1KXpd5PTXH25jPSlryUUKDgNEQIcSAKinPxaMdb
ESnmeq6v1XPjGntERmZ7CY/iiRVfpjdpsHcd7QxbUNzJwJP3CAWNOfODRi0mnunl
Zr6r7roCafC7RrPGJ4NVYs1jeJWaRGWyKbrVSZ2t9tXF5OyN9FQ0aSyAbj6g4QMx
xgxonBGKKA6iTjWBH/rFIWhkfdDY5UA65jb7nw2r+DfPbGuiH6k6Q6sK9hW6bd78
E4/edeTgECnj9Fxa8hDvhxq8F6pJnqsLzTYkqzZc8xxgk7rL0yn5/w2ipX0iBVxS
p6ic1pSg/K0YPSmFLHJY2CcbLYmnDlj1k40mgzBRrnejlvzs6pAO+8E01uu+rTuz
9OIoEB8rVa17V1FelPfeOUR/gQ16IcyF7BcepfQO9nPvB9pFm0n8J9d4Jv5G7VMH
AgC1b1BLd4C5JeA6H9gz2gZ4u60jTU2ns20/3nuPlT0ueeRi5AYepM3Yzqn5s8Lz
8dee69zh5RI8Z4B78jn1i95lk6h3Ng4lKcemKxFq9KI8SkLfsPSqHiU2XHazURFU
n3Lky2vYA/T/5GQJTVNB
=Yyud
-----END PGP SIGNATURE-----

--=-O/JyR9SOGwz+s/Rkhb2a--

