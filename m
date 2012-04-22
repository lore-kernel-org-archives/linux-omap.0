From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH] mtd: omap2: fix resource leak in prefetch-busy path
Date: Sun, 22 Apr 2012 15:45:16 +0300
Message-ID: <1335098716.4879.7.camel@golum>
References: <1334106274-24993-1-git-send-email-notasas@gmail.com>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-IZTs6yjpwK6c0S+eo9hE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49212 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab2DVMpU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Apr 2012 08:45:20 -0400
In-Reply-To: <1334106274-24993-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>


--=-IZTs6yjpwK6c0S+eo9hE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-04-11 at 04:04 +0300, Grazvydas Ignotas wrote:
> If prefetch engine is busy, current code "forgets" to call
> dma_unmap_single(), which results in a deadlock later, so add it.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Pushed to l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-IZTs6yjpwK6c0S+eo9hE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPk/1dAAoJECmIfjd9wqK0zbsQAJiLSJIYdzQtC9syYamMc8yf
6x6cdglhtSj/BuOg/se8JqIWTVPS7uams6EU/uopvqxYZkCcj3bgTlPvPPT/nFhM
7wwpVBWLmvfFZUbMJb0J8s7H1yC222DmkQYCM6srhfyfVW9h/+2KEWgW1JbGEEuM
8wsRJLB89r6Tu52fjopo1W1CAYmduI/sXrgXisLiFACzrHkvLr9ljX7D/vTjmvR2
ZzgrGEPMh+czRGbwrg6b4eUFsvXN+xoppUZMo80v1C/Wq5OEv6008Ahzp0pcGUCr
zOoLPQ4Sosm87rF9DYrN1roqwiHztwuolFrWfGmSng36kyFLKxYuufuS/dXbeH9o
IdR5GCNky6/MtHx5+Wdpk3IxLCmeZVbl9LiPdsvypk0aXizAorZW+4arxqlKUOkg
7N/CfgT39qGqHo7meGvWWfoCdSWYyPCEZmckAoreNiCjUBpLqHXXxQNxi/vkb0sU
Fr/6eB3rMi9gKSeIZ7UyQ3ZqxcvRBu02unkScs3Hfrk5uzX3uD6ybAOgPFXo4F3u
6vissNSvo0EXDb+5usR85/drytRg7sMXpymQKcOP91Ybcia1GIET8kup6tRHm2RI
b9YOL0hThVqhjS2l0duRtsitqMTC7D2VWBIhCZtGIBmvPwWcGCzdvc/iYF4+3W/C
8qOUp+302riNyPvoQAbj
=GN7r
-----END PGP SIGNATURE-----

--=-IZTs6yjpwK6c0S+eo9hE--

