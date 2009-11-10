From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 00/19] OMAP: DSS2 v5 intro
Date: Tue, 10 Nov 2009 14:40:48 +0200
Message-ID: <1257856848.21596.753.camel@localhost>
References: <1257767126-12059-1-git-send-email-tomi.valkeinen@nokia.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37721 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256AbZKJMlM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 07:41:12 -0500
In-Reply-To: <1257767126-12059-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Stephen Rothwell <sfr@canb.auug.org.au>

Tomi,

could you please kindly ask Stephen (CCed) to include the DSS2 tree int=
o
linux-next, because you are going to merge it the next merge window, an=
d
there does not seem to be any blocker for this.

Being in linux-next for a while is really important.

On Mon, 2009-11-09 at 13:45 +0200, Tomi Valkeinen wrote:
> This patch set implement new display subsystem driver (DSS2) and omap=
fb driver
> for OMAP2/3. The patches have been reviewed on linux-omap and linux-f=
bdev-devel
> mailing lists. The patches can also be found from master branch in
> http://gitorious.org/linux-omap-dss2/linux. The branch is based on th=
e
> linux-next tree.
>=20
> The patches include DSS documentation patch that includes more instru=
ctions for
> module parameters, sysfs files etc.
>=20
> The patches enable DSS2 for OMAP3430 SDP board and support for other =
boards can
> be sent after the DSS2 has been merged. DSS2 is used in various board=
s, for
> example Nokia N900, Beagle Board and Overo.
>=20
> I don't currently have any OMAP2 board to test DSS2, but it has worke=
d on OMAP2
> and the possible fixes needed should be minimal.
>=20
> OMAP1 is not supported, and so the old DSS needs to be used on OMAP1 =
boards. My
> longer term plan is to move all OMAP2 stuff from the old DSS to the n=
ew one,
> and then shrink the old DSS to support OMAP1 only.
>=20
> DSS2 is partly based on the old omapfb driver by Imre Deak, and Imre =
has also
> contributed to DSS2 quite a bit. Ville Syrj=C3=A4l=C3=A4 has been con=
tributing to scaling
> and tv-out work, and Topi Pohjolainen to VRFB. Also some contribution=
s have
> been made by Hardik Shah, Vaibhav Hiremath, and perhaps some others t=
hat I have
> forgotten =3D).

Tomi,

could you please kindly ask Stephen (CCed) to include the DSS2 tree int=
o
linux-next, because you are going to merge it the next merge window, an=
d
there does not seem to be any blocker for this.

Being in linux-next for a while is really important.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
