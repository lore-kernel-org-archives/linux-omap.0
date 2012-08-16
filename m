From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/6] OMAPDSS: DSI: Maintain copy of video mode timings
 in driver data
Date: Thu, 16 Aug 2012 14:31:06 +0300
Message-ID: <1345116666.15132.4.camel@lappyti>
References: <343817088-29645-1-git-send-email-archit@ti.com>
	 <1345102594-6222-1-git-send-email-archit@ti.com>
	 <1345102594-6222-4-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-kzvEEAqKPxdOyLJZY/LS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:57831 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751213Ab2HPLbN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 07:31:13 -0400
Received: by lagz14 with SMTP id z14so1527679lag.32
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 04:31:10 -0700 (PDT)
In-Reply-To: <1345102594-6222-4-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-kzvEEAqKPxdOyLJZY/LS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-16 at 13:06 +0530, Archit Taneja wrote:
> The DSI driver currently relies on the omap_dss_device struct to receive =
the
> video mode timings requested by the panel driver. This makes the DSI inte=
rface
> driver dependent on the omap_dss_device struct.
>=20
> Make the DSI driver data maintain it's own video mode timings field. The =
panel
> driver is expected to call omapdss_dsi_set_videomode_timings() to configu=
re the
> video mode timings before the interface is enabled. The function takes in=
 a
> void pointer rather than a pointer to omap_dss_dsi_videomode_timings stru=
ct.
> This is because this function will finally be an output op shared across
> different outputs to set custom or private timings.

I don't think the function should take a void * in any case. If we want
to share the function, it should take a struct that perhaps contains an
union of rfbi and dsi timings.

But I'm not sure if there's any benefit for that...

So do you see us having just one set_timings, which would take either
the normal video timings, rfbi timings or dsi timings?

 Tomi


--=-kzvEEAqKPxdOyLJZY/LS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQLNn6AAoJEPo9qoy8lh710KkP/jSTMSOfdMWz5a/YvhJQCOlJ
GL6VuUX4UH2cvzX2hsOBuPqJHMvwvhNUVkNjwIITvizPBWcTPBL8E4cxeoqeh7o2
bdGRK36YAX7GEKYOG74smRDVnFaKZOgJjeu4UP1Sp4ZdazgG1/UbFzGPXLq1Bfkn
m/jInUGe7fcvaXzhuEE6PCPG/MuUQ/nHTokRm7I6tDY2ND0b3NcMro5OGQV1etDi
O/FAQq1+Xd4+jB+meYTyoa/xW14vsmJCMi9WBdKrGarvGdut/GYmmNfNOa9J3R0E
SnzvCLR08RwKSWbOV5CWn9MvbiBs1BxISSv6sZS55DghN/e3/ZSq/Slf5IG3BXDu
xraE7Jm2Dl3yjUNAdzTazwpPhet6TLXldma2DiOXaQOZ9ZaNbg3uxh1wvLVaFRDY
ewei/jDssI0XbMaGXvIq9e/EOrTsfdS6mPzUb1pACgNj061Y3GxSt450vJ+th/kS
G3zcMS4cfQxmdX4gSRbg3lacunQVjTDUnFxLQDw/XNh+uIOa+0pTWdGPbGIPSJnx
1JwJueHW8ee8uhAc4an7X3eD22rdk1uG7jecFt+YYdd1c7E2k7taPGtb8tYxcHaa
b25uduVxxJFXasxRmMqbZNZxTy/6Q/DsLuod2GGArUKxU25PpsLivg8AG+B5dB/l
N/Yy6BX8fnAcO0TGwww7
=tfRY
-----END PGP SIGNATURE-----

--=-kzvEEAqKPxdOyLJZY/LS--

