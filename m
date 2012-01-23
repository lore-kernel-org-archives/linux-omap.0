From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/2] tty: serial: OMAP: work around broken driver, IP
 block
Date: Mon, 23 Jan 2012 10:15:22 +0200
Message-ID: <1327306522.1916.11.camel@deskari>
References: <20120121071934.18707.64258.stgit@dusk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-jY5qxMinCoTnvW6hu+Fs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41837 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990Ab2AWIP0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 03:15:26 -0500
In-Reply-To: <20120121071934.18707.64258.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Govindraj Raja <govindraj.r@ti.com>, Kevin Hilman <khilman@ti.com>, alan@linux.intel.com


--=-jY5qxMinCoTnvW6hu+Fs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-01-21 at 00:27 -0700, Paul Walmsley wrote:
> [ This series is targeted for merging during v3.3-rc ]
>=20
> On v3.3-rc1, the OMAP serial console doesn't behave properly when
> power management is enabled (the default with omap2plus_defconfig).
> This seems to be due to a combination of a silicon bug in the UART IP
> block and broken FIFO settings in the OMAP serial driver.
>=20
> This patch series attempts to work around these problems.  The workaround=
s
> are not perfect; see the patch descriptions for more details.
>=20
> Tested on OMAP3530 BeagleBoard.  This series will need to be tested on
> OMAP2 and OMAP4 before it is ready to merge.

Thanks, this makes the console usable on my OMAP3 overo.

 Tomi


--=-jY5qxMinCoTnvW6hu+Fs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPHRcaAAoJEPo9qoy8lh71Hr0P/3zPpkcmmfc/A48xuSFfzQiJ
D/cLuUL1uIvyXIh/iLeFRHo33z/c62eCZjl3sGuiqCryySHTsaoqxBiKVJUCDxoG
TTnx6iVZ+dpQoVbU0/htF0St5eBEjonISiYl2+8G5EBFGGO+bOexGoGIc8BpSdNI
xi5RXjtmTDEOQWaD6huCgQfNbQZiO3lLYdWiJdqIlEddoH5T5tcWIs0ki4NDvPge
PXwbmrW2EAIJLiPy17B2zalhIWoBAHUHvWxhanzXvU/lYrjRAVSkfV+FRb8XjH7k
RZf2MoJiCSZgWLPhwFynNHiy6tSmimyei1+QYHAFTV9oVkFujyDCFtb7nDw2HzSJ
KmVwCAaWJijsMIBrxPe/b/+6WC0qdquEPDUvfQUlVAy+S9zK0vwwOl2BiNareoka
Gjre25FrS/ECp64zixYjoDqwJwBHz7QVCPTYo0bOLuR5v2zOvCVS69E2FlCDxt/i
OeyLACYa0wT+wSZG68L9BJKkrm+SJr0Jg2+vew/qBN6r7kB0YXO+6uQQsmrUWMIS
0OlUnVLcWa6006XVPrJ5P/G/0k7fg2ktoXE0FXbz4rjrDR9FfuwTvi7NF1OVa7EF
yGwYmlxILE3QjEcxr9XnJ231TPdUHTY5G96yeQEVUPkSjo+AtQkDQlKd+SUTvIE+
bpv0BPkF9TDKERfhF7A1
=cgOZ
-----END PGP SIGNATURE-----

--=-jY5qxMinCoTnvW6hu+Fs--

