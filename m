From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: TPO-TD03MTEA1: update default gamma
Date: Tue, 14 Feb 2012 14:35:10 +0200
Message-ID: <1329222910.1845.90.camel@deskari>
References: <1328573630-7348-1-git-send-email-notasas@gmail.com>
	 <1328573630-7348-2-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-WQBhv5lmFffjS7W5POKV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:39647 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754384Ab2BNMfO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 07:35:14 -0500
In-Reply-To: <1328573630-7348-2-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-WQBhv5lmFffjS7W5POKV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2012-02-07 at 02:13 +0200, Grazvydas Ignotas wrote:
> Over time better gamma has been determined and tuned with some
> equipment so update the defaults. From subjective point of view
> dark shades should be better visible.

Is there even need for default gamma? I'd guess the panel has a default
gamma in its firmware, so it should work fine without setting it. And
there's sysfs interface to set the gamma from userspace.

And, as you said, it's subjective, i.e. there's no right value for it,
so I'm a bit inclined to say that the driver shouldn't even set a
default gamma, and just leave it to userspace.

 Tomi


--=-WQBhv5lmFffjS7W5POKV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPOlT+AAoJEPo9qoy8lh71NC4P/2PNLY04SXsb9pYe6BLIYodK
LWydd/S+dY2/5EAi+EC00u3sGycNxn80Y66olFsxe3aVEsbbd56vcS0wDFz2bFMs
HTmeo3xtFI+p6PHFB4N/Ns4rXccAFDQdW4s7vdZi3kK2+6f44R4OI/p+hUs5aOE/
yNpijdo3bnrSjPWRjB8cIRPB1Q3aFcChfO8XBkkMsxeR2a1Fu/c6urznjDc/TA37
vJLncGyXVjScezkPe5TiKuCXlwtVvOZpk/2lbWAWydfbzwwB5ehy0vXQc8ctr6fA
wQLv3JAloyL0l29bkf0POkKLvc5SX3Ba4jO4ITeL7ABRL/HIJsWrlUrSGC/5UJoY
JuOxJb7Q4gLcNp71cG25C4rfMlpfzDwLM0cjC3LMrzvhZEfDqdrSmQ3PBbzYG+fQ
NSpGQCASOZr7mCes1/h6pum+v0fwh2aksMFviQ5+NuJOMoydi4wVavtIeyS0sxaH
Nv8XXJZtkNWfic9KM9lsf85WjnW/64W9uWqyGPYfeGmo4qxKej83WHJRR2hfCHkl
IIcdkIyWfI/7/hDWs2Ur9ClBsONLScaynf+g3NY5Sz1hs4ETprRMAz9vWq2Ya9R3
+h/irbgRjoSVqPMsS0/GhTx7N9cDJFu2wS/Fe7QD30OcmSpU7NRf0Z7H8d3JjHn/
Lkwsh4qkuesZZM4+6VNI
=9Szv
-----END PGP SIGNATURE-----

--=-WQBhv5lmFffjS7W5POKV--

