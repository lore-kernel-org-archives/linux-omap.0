From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: provide default timings functions for
 panels
Date: Wed, 14 Mar 2012 13:22:22 +0200
Message-ID: <1331724142.2386.25.camel@deskari>
References: <1331551631-11420-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-3R+BePFlaWfC8URC68nz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:43940 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752328Ab2CNLW1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 07:22:27 -0400
Received: by mail-lpp01m010-f47.google.com with SMTP id w12so1870483lag.34
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 04:22:26 -0700 (PDT)
In-Reply-To: <1331551631-11420-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>


--=-3R+BePFlaWfC8URC68nz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2012-03-12 at 13:27 +0200, Grazvydas Ignotas wrote:
> With this we can eliminate some duplicate code in panel drivers.
> Also lgphilips-lb035q02, nec-nl8048hl11-01b, picodlp and
> tpo-td043mtea1 gain support of timings control over sysfs.

I don't like this patch.

Panels usually have a single, fixed timing configuration that should be
used, like the ones you mention above. There's no need to alter the
timings.

But it's true that there's some duplicate code currently in the panel
drivers. However, adding just simple funcs like you did in this patch
doesn't work quite properly. There should be locking (for example to
prevent disabling the panel while timings are being set), and currently
the locking is panel driver specific.

 Tomi


--=-3R+BePFlaWfC8URC68nz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPYH9uAAoJEPo9qoy8lh71loUQAJeByMrF0+HgfMMIZn7XV73a
nEtSVh/9d3gYFuX+bE+jEce5HKdfq6spWDY11I26KuvcVX2rFBlfVii46byXpsls
1XGEAu+AuG5eTtoQ5nPb/Cx04PFq7NGz+epBJTND7UaahAhP3rUb0dUKQ4LNRyiz
lDVDDQIowCUWh25ButZ8wMw24pb6dGZut0fRVaTKGOApfoFS+7aq6+iOu1oXzZ9Y
epr7iJh0U1gMpgEIdqSBmjJPZVhzN6OIbFCDQRJfUHIXl519laIEeCur5hW45fl5
0V9kcKXbDO4kcPn4l3D33W5AhXOhdNImq5fOmVvh1dqrrvMHlAOYWcgJB6H7GHHU
bAaMBoIq5DujVsCS97GpRpFn6p7n5h/Ly9zGzD8zixbObqtNdjVhhE2ckQXh2ilV
XX+YehNAZQAarDOE5nlZrTxr86kl6pgKh10ORCmvZWakG0ofy7GOcwnj6wq0MZBK
UWJU9kfhhYNES4PnrGfc3t6HJEnaWn8YPCJi/UWUutuhTp1vYKeZyzksWne9FHgg
9J1lK2UH4dvUIjbXJqO6bSY/raJ0hvsjHMUagDKflQQPNmGbrwcbDJR3S9S/PG3n
JDtXLkNlI+cTCQqLjkXY0nBSmItZ908LaOWkhxGlfWI8oszUMj7eYGzWSNP3Y8C+
MUaj+dlUTLdDfYUoPw59
=S6EJ
-----END PGP SIGNATURE-----

--=-3R+BePFlaWfC8URC68nz--

