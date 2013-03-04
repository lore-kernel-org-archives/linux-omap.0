From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] arm: omap2: mux: fix debugfs file permission
Date: Mon, 4 Mar 2013 22:19:50 +0200
Message-ID: <20130304201950.GA18315@arwen.pp.htv.fi>
References: <1361269464-20263-1-git-send-email-balbi@ti.com>
 <20130304191830.GV11806@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41148 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932164Ab3CDUUI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Mar 2013 15:20:08 -0500
Content-Disposition: inline
In-Reply-To: <20130304191830.GV11806@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 11:18:31AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130219 02:28]:
> > OMAP's debugfs interface creates one file
> > for each signal in the mux table, such file
> > provides a read method but didn't provide
> > read permission. Fix it.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> Heh indeed, although read still seems to work without it.
> Applying into omap-for-v3.9/fixes.

root can always read, I guess.

--=20
balbi

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNQHmAAoJEIaOsuA1yqREPVYP/23QzU0nRp0qQL8rl49WPAWo
K+qtysQ/1ytAPzpx8bG8b2028TheYiB62S8/GXSGukYFyiFZsqGjL0DygSPX5HLH
8lGNu/BpSaZOnkiF8zgH3A5e6DOK+T/L+4p00/5fRQfL+S/NJKPL60aHL/Td7Don
l+6uRTPkbiSqlXOx8LFJwwprjSMJK5UQh4B4U6zPqDs3/umRihBgVoSQ9U/Y8/Gf
ELhXakx5o2mvAOMgtKp2hk7vyuCNkDPO/wH86tv6JkLuJqUbkF7EchrpMUlEh4TW
noIjRamMQoKRuwJUa6UpoDbwx9HG045I/jT9qaIo5t6BKBFqWVPryTF6C7NGfSrH
a65b+J1oJQ0SDqXdzdFAmEcj9HGHes0JVLX+nj/CSzhwlYftKTfxab8P0b75+psm
AlIatS3kYOsfhyRbKRXgFcMbsM8Ey+AJi2bJLK1Fav2xs5pyObA36/FanADTmTjL
BsVOuwi602UK5SUuuhJx9jduUiZfWn/hkQGEwGubQw2xtotAj3WdpdalDShzRhHx
AgX2vF3InqwmaZJhx3oyygLgk9WLt1u72OVJsyQ9Q3++J7TPIQt7qO8CVpe74nZJ
ZRNeRc5w6Ng0AWGX/MWRoHU9aeSrHOE6sbGAZWnIpX+dvHe9GUTozM6O3dAvNVIm
9m3JsK3Gqlc2R3NngDsj
=QXSx
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
