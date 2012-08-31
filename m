From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 20/23] OMAPDSS: MANAGER: Update display sysfs store
Date: Fri, 31 Aug 2012 17:30:49 +0300
Message-ID: <1346423449.16067.27.camel@deskari>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	 <1346326845-16583-1-git-send-email-archit@ti.com>
	 <1346326845-16583-21-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-xQwdXqUfedmKKgEf/S0/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:43093 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753833Ab2HaOay (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 10:30:54 -0400
Received: by lagy9 with SMTP id y9so2316541lag.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 07:30:52 -0700 (PDT)
In-Reply-To: <1346326845-16583-21-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-xQwdXqUfedmKKgEf/S0/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
> The display sysfs attribute's store function needs to be changed with the
> introduction of outputs.
>=20
> Providing a manager to the display isn't enough to create a link now, the
> manager needs and output to connect to. A manager's display store file on=
ly
> has the information of the manager and the desired display, it is not awa=
re
> of which output should the manager connect to.
>=20
> Because of this, a new constraint needs to be set up when setting a displ=
ay via
> this sysfs file. The constraint is that the desired display should alread=
y be
> connected to an output before calling this sysfs function.
>=20
> This might break some existing user space stuff which uses sysfs directly=
. But
> in most cases dss_recheck_connections will connect displays to floating o=
utputs.
> DSS sysfs files are being planned to be remove anyway, so it's not much o=
f a
> harm.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/manager.c |   25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/=
manager.c
> index fd39f66..d808ce2 100644
> --- a/drivers/video/omap2/dss/manager.c
> +++ b/drivers/video/omap2/dss/manager.c
> @@ -74,18 +74,33 @@ static ssize_t manager_display_store(struct omap_over=
lay_manager *mgr,
>  	if (dssdev)
>  		DSSDBG("display %s found\n", dssdev->name);
> =20
> -	if (mgr->get_device(mgr)) {
> -		r =3D mgr->unset_device(mgr);
> +	if (mgr->output) {
> +		if (mgr->output->device) {
> +			r =3D mgr->output->unset_device(mgr->output);
> +			if (r) {
> +				goto put_device;
> +				DSSERR("failed to unset device from output\n");
> +			}
> +		}
> +
> +		r =3D mgr->unset_output(mgr);
>  		if (r) {
> -			DSSERR("failed to unset display\n");
> +			DSSERR("failed to unset current output\n");
>  			goto put_device;
>  		}
>  	}
> =20
>  	if (dssdev) {
> -		r =3D mgr->set_device(mgr, dssdev);
> +		struct omap_dss_output *out =3D dssdev->output;
> +
> +		if (!out) {
> +			DSSERR("no output connected to device\n");
> +			goto put_device;
> +		}
> +
> +		r =3D mgr->set_output(mgr, out);
>  		if (r) {
> -			DSSERR("failed to set manager\n");
> +			DSSERR("failed to set manager output\n");
>  			goto put_device;
>  		}
> =20

Hmm, I think this is a bit broken. If I read this right, the unlinking
removes both mgr-output link and the output-dssdev link. But the linking
part only sets up the mgr-output link.

So if there's a very simple configuration with one display, if you
unlink it via sysfs you can't link it back again.

The store function gets the mgr and the dssdev as arguments. I think
this could be changed so that the function would "guess" the needed
output. Well, not so much a guess, because a dssdev can only be
connected to one output, defined by the HW design. That is basically
what the recheck_connections does, we could use the same method here.

Then this sysfs file should work just like before.

 Tomi


--=-xQwdXqUfedmKKgEf/S0/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQMqZAAoJEPo9qoy8lh71pqEP/ioFBvyaxw3cA0RutJ4U9pk3
XlHqc6SXKBQesxO2wSgXfhDmC7cANw/t6Ym/Q4xBhEFgtKwdk11K4vqIYfnZJ2xE
ipYDO1IjNDqWAoIzTYvsUjbvXhTd0WHPO21vd5K/S1+4Qtlm3tVZyg52TyBvfyyR
b6HtS7njg7Bb7MnVrNThg9x5c47nGZCAtnT5+aNSshLafaQFcGb/7SGIfUh3EfhH
Io47cbBHmnzzJltx6LCuOr4h9lXbbov0LVje3p9+eRulwl+KwIabCDP382QCYLH3
9DYNpEqbgIg7gAL6AqX8RgECLfAkarADRNcMN74ZjMiGFdOeiLuAeSgdJ1zYQKDY
T8c4U4zcXTutXUuJ5hV/PoxiJopM6EgTBdj/GNhvxa3JbGzUeb7dGhM6/Uukzwdu
9DPTS/wIzGt8l4JYMWScf8If2k+4Iwval+bHNMoqMEWmGO2sHcOMqwwhK/yiRcVW
j5RRD5Od23mMcecipFKr4MmiZ/fINv5l/D1HlKbfCl+/l6unoA/fJ5Sdi9mM0tkg
V4PBiuE0E2WgONi4xunAxR70vWGRQ7IO/GduYArYGmn57cwnEBeSHj+VUQ3syKEa
G81ZkIkM0igFNP7Nt7hIQdaV87H5+uFJoCU1fbpF3G16HJj7SVm0ThzHULwr3tzL
DhI8yb+smbFRE4xVg3Py
=Bmqe
-----END PGP SIGNATURE-----

--=-xQwdXqUfedmKKgEf/S0/--

