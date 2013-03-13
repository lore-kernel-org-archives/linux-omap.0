From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] omapdss: features: fixed supported outputs for OMAP4
Date: Wed, 13 Mar 2013 09:28:52 +0200
Message-ID: <51402AB4.50702@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1362493070-17706-5-git-send-email-archit@ti.com> <513DCE08.20404@ti.com> <513EC63A.5060707@ti.com> <513F05A0.6040204@ti.com> <513F2639.5060008@ti.com> <513F2F82.2040604@ti.com> <513F354F.40701@ti.com> <513F3BBA.6010209@ti.com> <513F4348.3080203@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC87E4F3F9D3117C265AA7D9D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32830 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab3CMH3A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 03:29:00 -0400
In-Reply-To: <513F4348.3080203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enigC87E4F3F9D3117C265AA7D9D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-12 17:01, Archit Taneja wrote:

> So, what I'm saying is that we should stick to output->dispc_channel. W=
e
> iterate through all the panels, and by using output->dispc_channel, we
> get the manager for an output, and map that manager to a crtc, and make=

> sure the number of unique managers we finally use is equal to NUM_CRTC.=

>=20
> Does that sound good?

Yes, I think that sounds good.

 Tomi



--------------enigC87E4F3F9D3117C265AA7D9D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRQCq3AAoJEPo9qoy8lh71km4P/jO3QzITp9LO8j9HwcbcsLQX
AsKce5Vt38BLCpaS6D42CIBEsivY3XSzqsfJ0QKUMw1ecVTEe8TJhIcA2121OVAX
Ijw8but3PSbzZBJz8LTMUasDf97/u/H/ZR0WwS3ONmlpfX1n2bE1LWkZg8nlR0Cu
IfDfs447ywRrFADgQ7j0+bySoFuLke5sh0/5kfvrnncOcBwijypXcg71gtkuCoBp
7bD8N/mN5e2UL8SOEmzkzFkD6ceg75brSHEwg+E/dPUpxeA4aD5XZ12/dkCPVPkx
G68elo6SnERZ7GAG6VY3vtRVRZwkrn94pqo8/fGmiM4B+ItlD73dYFlKRSVEg53O
Xy7R5QBQZs53N6wXfb5ch0OngNT4wXGfOs6zYM9gITkifmX+fS6rjWj0fnZ3fG3A
OVQ3YZyR7LlOFXKwWdDoxDoGKPBdERAR/NqLDaIOEHtaTCDsHqtqWLir6af6aBxS
xlecKGgFFFYSNzbtZRX96XtGxVJbvViBpKI8IwX/5BtSK3zfd7oIj7d1JT0Zcuhr
RFQ5RR1nzSLUnvoqny9p2K2KXcNDpUrhqPIogYv2hn5kkHhz6DZh7uqOOmQ5i0oU
hdCs8LmuIvddYFH46k7TbHRBoBhSMqV2mTgSOX8qkKT5JTe/FvVaIG9ar8kIpZQ1
cv0RFQGBMDYrN20X+bq7
=DPDE
-----END PGP SIGNATURE-----

--------------enigC87E4F3F9D3117C265AA7D9D--
