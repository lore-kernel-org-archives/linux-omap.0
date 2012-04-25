From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: VENC: allow switching venc output type at
 runtime
Date: Wed, 25 Apr 2012 15:37:10 +0300
Message-ID: <1335357430.2799.6.camel@deskari>
References: <1335215334-32608-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-nODeJHYxL9qh2Eda99q3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:40838 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753182Ab2DYMhR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 08:37:17 -0400
Received: by lagv3 with SMTP id v3so42091lag.27
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 05:37:13 -0700 (PDT)
In-Reply-To: <1335215334-32608-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-nODeJHYxL9qh2Eda99q3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-04-24 at 00:08 +0300, Grazvydas Ignotas wrote:
> VENC output type (composite/svideo) doesn't have to be fixed by board
> wiring, it is possible to also provide composite signal through svideo
> luminance connector (software enabled), which is what pandora does.
>=20
> Having to recompile the kernel for users who have TV connector types
> that don't match default board setting is very inconvenient, especially
> for users of a consumer device, so add support for switching VENC output
> type at runtime over a new sysfs file output_type.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  Documentation/arm/OMAP/DSS     |    1 +
>  drivers/video/omap2/dss/venc.c |   54 ++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 54 insertions(+), 1 deletions(-)

Looks fine to me. Thanks! Applying.

 Tomi


--=-nODeJHYxL9qh2Eda99q3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPl+/2AAoJEPo9qoy8lh71PMsQAKiyEdWqe9i9VGDFSUOPIQzD
FVkuReqp6uga0ZfVAADeYQ4c9sj4hbNMSXird4/cmRNfi32d9gzVVbaveHQyQ5rT
wV+TKO4w/WHF7OkJSoXkFXTF5CI6NlwwQ/CAxWjIIaYSTAQmuOE82wq/5xXAleCa
8B4V5Hvt11V3CxDaWBrM6zH4F7HkkdGON5cKPSkp2gKvC/5TpH3lw/fpLK26yY2Q
P+/Z1NXkTW+yq7HAi2DxQZPs5B54+OwjEhO8h0TCWPbOHt2qn3bl25SIoYcKC5+6
+AjKvXoOfkuxO2flMMlRdYVuFFYpYZV/oYOl3XPCi0JmX09N1HMqSMDcISXw+ETu
6GAG8MhCqOvPv3e9vceL78nif8w6w3SFyQu5uvoYk+OhfVwN6jJvigwKmCY2YDvn
ptNqYlWBS3/XNStnUCRcy7zLHls2eIdTuD9NZVOWerOdnX8TsJYComK8vmry3PqC
6czLYbXsWTQFJZ+b2Y7wxHHvUgfu9OQkFNWj0FAa/iOHDAp/S0RtYLYjvAu+uvqc
qiWhYSoIxJwEDtTG675GCmgzWbyHoSvnRA68jwhMlNjnO5PvbGoAaJqfCHt2Fl25
RIO8rmNsVG8Ao+NWctlwB7heG5Sc+vQ2cpgxEB6RCCb2hSUWBlP8gYu+Dgez89MQ
Xnnat8OdQSke5JJpLXHT
=XGDV
-----END PGP SIGNATURE-----

--=-nODeJHYxL9qh2Eda99q3--

