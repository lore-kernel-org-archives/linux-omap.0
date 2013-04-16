From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/33] OMAPDSS: platform_enable/disable callback removal
 from panel drivers
Date: Tue, 16 Apr 2013 07:20:10 +0300
Message-ID: <516CD17A.5050403@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <20130213164647.GF7144@atomide.com> <515C2058.8030402@ti.com> <20130403154645.GV10155@atomide.com> <516BC897.5020802@ti.com> <20130415212022.GP10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF7F19DE49E131AE106A5817E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56787 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3DPEUR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Apr 2013 00:20:17 -0400
In-Reply-To: <20130415212022.GP10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigF7F19DE49E131AE106A5817E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-16 00:20, Tony Lindgren wrote:

>> So, to recap, the common header changes are located in:
>>
>> git://gitorious.org/linux-omap-dss2/linux.git 3.10/0-dss-headers
>>
>> And the branch for linux-omap is:
>>
>> git://gitorious.org/linux-omap-dss2/linux.git 3.10-lo/board-cleanup
>>
>> After merging those, some displays won't start anymore until the omapd=
ss
>> changes are in, but things should still compile.
>=20
> Sounds like it's best that you merge those branches via your
> tree as the conflicts have been already resolved in linux next.

The dss changes are going through drm tree this time, as there are some
drm dependencies also, and I've already sent the pull request for those.
And when I asked Dave Airlie if he can merge the dss changes, I didn't
talk about a big chunk of arch file changes getting included.

Also, the whole division to two independent branches was done only to
make it possible for the arch changes to go through l-o tree.

There will probably be more these kind of changes in the future, so I
think we should agree how to handle those and stick to the plan.
Dividing the arch file changes to a separate branch is often quite
laborious, and I'd rather not do that for nothing.

 Tomi



--------------enigF7F19DE49E131AE106A5817E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRbNF+AAoJEPo9qoy8lh711T4QAJiV3umIhy3DeQyQ09YP+h2I
JcKQMklHLUqoG2T9WzE0+RdKel6EW8N0F5wGDKjochqFSDAHqAq5YCBTF3VKzUIq
1goe2FI8m4RiQ4BrGTFlv0WT37i7ETOPQz/IUBIYahyhNu8amMcrOXgDfkImTQkM
64PXygo0b5yt34jhP/OzQAqBCBK7aRr5ssvBVLmL0AF5oK0aIw/cMji12uIn+fy0
FYU9XDxM4X7hOQvJg3Nog5ziVIXqrXeuojfq5zeMw/JK9D0J+hOlXahPL7MF70DX
FPt3Tj1X3gAVBMBc+OP9a2X6sRrxnNMyOX6G0SwAgHRnVHtJYBxemlNTIWZQr+Im
X80HWqNfw+e9aCyUNrBa6gih5Bb+1kKjEGgaTcSfRDAOb3qgc6gaD8eqlZreDN4j
qNuELUuAoqKTGMFtAG+UbsLEN1QvFsR1J1fy/Zzk6Smyo4IFX8FWzO8BZWnBJoMP
KYWOlh6oXZRcura8jjifYLqcSHfAYeMOd8WonRMPhmGS5a5UvDpbJoLsQl3TZBFA
wSWI4ZQ2noyvJpvCXUjpctDqo/V3R+2fichfiLpnUGx5RbScLzOjquXjjXhhNrvf
KL5C7PMNpNuR73CU2qZRLaXB0NAxhbeqcyOCLUcf7HSIVPE3jcCC9sxMBeglD5K2
OrRKBqjEJ18pBro3T2lt
=YI6F
-----END PGP SIGNATURE-----

--------------enigF7F19DE49E131AE106A5817E--
