From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 1/4] OMAPDSS: APPLY: Add manager timings as
 extra_info in private data
Date: Mon, 07 May 2012 17:47:51 +0300
Message-ID: <1336402071.2667.16.camel@deskari>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	 <1336028864-13895-1-git-send-email-archit@ti.com>
	 <1336028864-13895-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-1KMn7nIpGA+wZhB2ECja"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:37822 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756966Ab2EGOr5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 10:47:57 -0400
Received: by lbbgk8 with SMTP id gk8so3915977lbb.26
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 07:47:54 -0700 (PDT)
In-Reply-To: <1336028864-13895-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-1KMn7nIpGA+wZhB2ECja
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2012-05-03 at 12:37 +0530, Archit Taneja wrote:
> DISPC manager size and DISPC manager blanking parameters(for LCD managers=
)
> follow the shadow register programming model. Currently, they are program=
med
> directly by the interface drivers.
>=20
> To configure manager timings using APPLY, there is a need to introduce ex=
tra
> info flags for managers, similar to what is done for overlays. This is ne=
eded
> because timings aren't a part of overlay_manager_info struct configured b=
y a
> user of DSS, they are configured internally by the interface or panel dri=
vers.
>=20
> Add dirty and shadow_dirty extra_info flags for managers, update these fl=
ags
> at the appropriate places. Rewrite the function extra_info_update_ongoing=
()
> slightly as checking for manager's extra_info flags can simplify the code=
 a bit.
>=20
> Create function dss_mgr_set_timings() which applies the new manager timin=
gs to
> extra_info.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>

<snip>

> +static void dss_apply_mgr_timings(struct omap_overlay_manager *mgr,
> +		struct omap_video_timings *timings)
> +{
> +	struct mgr_priv_data *mp =3D get_mgr_priv(mgr);
> +
> +	mp->timings =3D *timings;
> +	mp->extra_info_dirty =3D true;
> +}
> +
> +void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
> +		struct omap_video_timings *timings)
> +{
> +	unsigned long flags;
> +
> +	mutex_lock(&apply_lock);
> +
> +	spin_lock_irqsave(&data_lock, flags);
> +
> +	dss_apply_mgr_timings(mgr, timings);
> +
> +	spin_unlock_irqrestore(&data_lock, flags);
> +
> +	mutex_unlock(&apply_lock);
> +}

With this, dpi.c & others still need to use dispc_mgr_go(), which is
something that should be removed and done only from apply.c.

dss_<ovl|mgr>_<enable|disable> functions handle GO, so you could have a
look at them. However, setting the timings is a bit different, so I'm
not sure how it should be done.

I think we have a few different options:

- Separate omapdss internal function (in apply.c) that can be used to
set GO after set_timings

- set GO in dss_mgr_set_timings(), but don't block

- set GO in dss_mgr_set_timings(), and block until the changes are in HW
(this is more or less what the dss_<ovl|mgr>_<enable|disable> functions
do).

The first one would be good if the interface drivers would need to set
multiple configurations, and we don't want to block after each set call.
But we don't have anything like that, at least currently.

The second one avoids blocking, but could perhaps cause problems because
the timings are not actually used yet when the function returns.

I don't see any problem with the last option, so I'm slightly leaning
towards it.

 Tomi


--=-1KMn7nIpGA+wZhB2ECja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPp+CXAAoJEPo9qoy8lh715skP/A7GeV50soGpapLBvu35jXAr
33sgsLW9i0JlrOSuEioF6/pgt+4iEeSroABrhkOivC4mugSSo/GqzLJtQaQiSTSt
z1223PyCN2J/Ykk74MMcoKy25nIPxZxI/lmEzLvzPmwyHvWwrJkMCXSwm1V4MdBE
b+rMMvtSm7zEveplATsUmYupQYCQGpXSCtlABt2xY5cgZs4I+/ayX5u8vb7OQbb2
FFlXAV42GgpEau7HSepoNqAVLF3fTRjL02AWGLMuZu1PikPFXegswqDoOjRzR8Ol
WOctBxkYKfUWZnTwLGFK3a+vzLdrPVRaYdFCV3cmbAnkrjxoUPMO9q6rTNz0IAIP
gAWZTcUQUgv4w3JTqG666jrIfZs8ITfufnE29hvES/yCmCpa4ZzhxO/OYD4Qv8j0
Tpgoh6K6mpE86nCFARSPimXr9HMkwkIaCxmPsyNTOI8cNtbbC11iZZiSn4pfAVcb
rtOCbLYXp+MskEiSO/0TzfLiQmcqU3xwCq7MfFOAeLRorZhPy9k2+B1qMoqXGmnj
C0bmZygUumZV0NQMjFP+dFRY9nVgp7O0J/rT3pnkoysBB4vc8F/c1Y1OCaNk3Clp
UTnsbeILAu1esRW9BfHVJ2zITvjcYKH9gcB1E5CV4oTOITDybYmR8FsQtWn2z1Of
VL3bawRac9Yq77U4AJ5T
=CQlb
-----END PGP SIGNATURE-----

--=-1KMn7nIpGA+wZhB2ECja--

