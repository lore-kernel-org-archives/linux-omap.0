From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: Possible bug in onenand_base ?
Date: Thu, 08 Jul 2010 13:22:57 +0300
Message-ID: <1278584577.20321.2.camel@localhost>
References: <u2v70c9a9111004300305n4c86774bm7ed70161ad72d830@mail.gmail.com>
	 <z2p9c9fda241005052046j3fea69a4v91f3d5fd86648fac@mail.gmail.com>
	 <k2x70c9a9111005060422v90e246daw19b1f71d57a890a1@mail.gmail.com>
	 <g2x9c9fda241005060444x7f9c4360u334d3afb06f1e8b8@mail.gmail.com>
	 <z2v70c9a9111005060602n7b7477ebueb197af05372bd5@mail.gmail.com>
	 <AANLkTimwO5iU6zPUJeLwAxW3GZGz5ldSRLmp2vpTBem3@mail.gmail.com>
	 <AANLkTiktbqSHHw572y1YGVw7XhZaim9Pg3lhoMmDBLXY@mail.gmail.com>
	 <AANLkTin43tv-AiFjwNkUE7ijy_ADMtsZTrqo_PY3DpCE@mail.gmail.com>
	 <1278583087.20321.0.camel@localhost>
	 <AANLkTiludbDD8ndnQlqxyWeP7us-BxaEDHvKfDpw-AW8@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24349 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962Ab0GHK1L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 06:27:11 -0400
In-Reply-To: <AANLkTiludbDD8ndnQlqxyWeP7us-BxaEDHvKfDpw-AW8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?ISO-8859-1?Q?Balletb=F2?= i Serra <eballetbo@gmail.com>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Rohit Hagargundgi <h.rohit@samsung.com>

On Thu, 2010-07-08 at 12:11 +0200, Enric Balletb=C3=B2 i Serra wrote:
> Hello,
>=20
> 2010/7/8 Artem Bityutskiy <dedekind1@gmail.com>:
> > On Thu, 2010-07-08 at 11:55 +0200, Enric Balletb=C3=B2 i Serra wrot=
e:
> >> Hello,
> >>
> >> I made new tests regarding this issue. Looks like the problem is
> >> reading from the OneNAND device.
> >
> > Did you try older kernel and then bisecting who is responsible for =
the
> > breakage?
>=20
> Yes, before commit
>=20
> 5988af2319781bc8e0ce418affec4e09cfa77907 (mtd: Flex-OneNAND support)
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D5988af2319781bc8e0ce418affec4e09cfa77907
>=20
> my  OneNAND is working, after the commit, the OneNAND support is brok=
en.

Ok, we could revert it, but it is better to fix it. CCing the author of
the commit.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
