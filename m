From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 09/23] OMAPDSS: Create links between managers,
 outputs and devices
Date: Fri, 31 Aug 2012 18:08:18 +0300
Message-ID: <1346425698.16067.52.camel@deskari>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	 <1346326845-16583-1-git-send-email-archit@ti.com>
	 <1346326845-16583-10-git-send-email-archit@ti.com>
	 <1346422242.7508.18.camel@lappyti> <5040C907.5090000@ti.com>
	 <1346424344.16067.39.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-lkez9pV1TAtxOm5w2mkn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37087 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753985Ab2HaPId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 11:08:33 -0400
Received: by lbbgj3 with SMTP id gj3so1285667lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 08:08:21 -0700 (PDT)
In-Reply-To: <1346424344.16067.39.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-lkez9pV1TAtxOm5w2mkn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-31 at 17:45 +0300, Tomi Valkeinen wrote:

> So I'm not really against having the enum. It just would've been neat to
> have the output type and instance number encoded into this enum, so that
> it'd be easy to extract either one. But that kinda ruins the possibility
> to use it in a bit mask.

Hmm, this is just a non-finished idea (and it's late Friday... =3D) that
came to my mind:

I had a brief look at TRMs for different OMAPs (omap4/5/6), and it looks
like the maximum output options for one manager is 4 (LCD2 on omap4460).
Usually there are just 2 or 3.

So, we could trust that the above holds and do this so that we use a u32
field to hold four 8 bit output options. In 8 bits we can combine two
values from 0 to 15. 15 should be more than enough for output display
types and output instances.

Then with helpers like these:

/* second DSI instance */
#define DSI1 ((1 << 4) | DISPLAY_TYPE_DSI)
/* first DPI instance */
#define DPI0 ((0 << 4) | DISPLAY_TYPE_DPI)

an example output options for a manager that can be connected to DSI1
and DPI0 could be:

(DSI1 << 8) | (DPI0)

This could be parsed with a for loop, going though the 4 bytes of the
u32 value. This would allow us to avoid managing a real list, and we
could extract the instance and the type from the value. Of course we
could also extend the field to u64 to hold 8 outputs if need be.

Whether this would be worth it compared to simple bitmask, I'm not sure
=3D). Depends how much we need to extract the ID and type.

 Tomi


--=-lkez9pV1TAtxOm5w2mkn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQNNiAAoJEPo9qoy8lh715/MP/R/EVOVon7WQRcanTNkatxHi
ZC3+d/mG0EvvsHVRJhTp3M5GGef5He+qUCKc0gKlvCSx0ALLywHp3SG0OT16drkY
lWvPXXtrxuIcwVrNNAygbuF4vkrNqnzRJmK8FWHPv1AyrJVnyP6sd5E2S0aj0MkD
0r3oSDf0x+6QzvcJbQkKK5B/qyV1TiALCnAelZYc2edjMU20rp7d9Pm6fr4mJmhF
MilrV7tmZ4VoWAKnsO4ipCv5f0oQIIaXixBJpOaMM0uUZ9Hal+soDzJTxUuG8mQy
VL8M+Yc26Wl5bRVV1mg4fMMwvjI/1KaXW0ENO22kolN5XlB6J9xvGiGHB36MfBeG
xU/0Gyp4aszVZtcrVO5K1dfKz+X/J4VAFvOWRchxM4bl6No5OyWrEd7rUpTreGbv
nFcf6s2y6rUkuRSQRgUu4jq9Iat6AYzJ6SnFvTXS4JBynlssryrPLMBrUKD0cRJ5
6mVtbcODBUIA0ms4eyA1WoIdhtdY/S7NVG0fzKF+E2Ola0vcx1e90BgbNeziRMq7
CPhhPiiL0UIsWKFNi5MywE9lsdSNu08mM8fO0k2BE6q5C1iYV0T3Qdx9397RE6u9
RhJxJI4Rrsh9tlZqYeZQgPly67XIqaLAqSbxZGi6KjE8xg3VlafQKgshOwd2Jdlg
uQB5kngQNvGHUopALKNv
=0N+0
-----END PGP SIGNATURE-----

--=-lkez9pV1TAtxOm5w2mkn--

