From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
Date: Wed, 27 Jun 2012 12:40:02 +0300
Message-ID: <1340790002.29342.15.camel@sauron.fi.intel.com>
References: <cover.1339586624.git.afzal@ti.com>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-P744xretYkTTGeYxIqfU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:61721 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756426Ab2F0JgB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 05:36:01 -0400
In-Reply-To: <cover.1339586624.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com


--=-P744xretYkTTGeYxIqfU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-13 at 17:02 +0530, Afzal Mohammed wrote:
> Hi,
>=20
> This series cleans up gpmc mtd interactions so that GPMC driver
> conversion which is going to happen shortly would happen smoothly
> by not creating much disturbance outside of arch/arm/*omap*/

BTW, be aware that Russel King patched the omap2.c file in patch series
which switches to the DMA engine, so I expect conflicts. You can check
his tree, I guess. The subjects were:

[CFT 09/11] mtd: omap2: add DMA engine support
[CFT 10/11] mtd: omap2: remove private DMA API implementation

--=20
Best Regards,
Artem Bityutskiy

--=-P744xretYkTTGeYxIqfU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJP6tTyAAoJECmIfjd9wqK0wq4P/0FxI/CyJqoQkMukMKrVkAuE
nfQxEkbKoZXOKJ8peJ5KJNMQh2m68HWhCLMSZsavY1VAllf8dlrX+XsGvRDzcU2o
wfhGZPsVxAY8r69juzUaxwSiV8b51atNat/KTfYjx+NcKW99pt6NP3HD/PSDy/sL
exOVYR+2DDxkvFjK6KF0eJpazimyin+muQzw6OUokegoaA+A3gjj6GuD6swlAWxl
O0Spk9HSMhjzPgmrfJd6enW6/9BbjRoCMY3vB2inD1BdGkMAg2ZErSQOt+psBiBE
P+mtihNx/V5RK0uWUl5782TrLROSwbGwnVEyUlRmMWTPy11rNo+LgerOq23Hk+rG
2twb0t/K/wqWjax2Z2SkE6dGH12MZGigGBKjj4YUifFkSexPQpzm5yEkJDy19AaQ
3O6fekMFCh7cJe4nRP2ikiqoBu/k8koc1RfmNhIql/6q/lhLIKjElcSUzEmASfhM
GU7KcuXvfXow/AE/qkVgNrGbhLrof00KDkub+Kelt8ZKeJvesaK4+BkcgdIDHFw1
hETrphRFY5Q5YkQuTerl0+MFr2/4+PBPFjetPWB58m86sWcCtdhYiQeuKjpJiwus
XFzLyYE/VnIV+yyjRyzGJjT/V/Smi0OX8FkDJU7NimVvIgYrEoMkZMEBblB9OcVR
FFgwN7MMYFE+fJBZJZiu
=tN0E
-----END PGP SIGNATURE-----

--=-P744xretYkTTGeYxIqfU--

