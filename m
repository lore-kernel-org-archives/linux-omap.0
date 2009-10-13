From: epsi@gmx.de
Subject: Re: RE: Memory performance / Cache problem
Date: Tue, 13 Oct 2009 10:16:51 +0200
Message-ID: <20091013081651.300080@gmx.net>
References: <20091012083806.323990@gmx.net>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDE1FF2C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:43883 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933642AbZJMIRk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Oct 2009 04:17:40 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDE1FF2C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, linux-omap@vger.kernel.org

>=20
> Can you upgrade to a newer u-boot? Either from the PSP release
> OR u-boot tree hosted at git.denx.de (atleast 2009.03)?
>=20
> Also, it will be good to see the sample program you are using.
>=20
> ~sanjeev
>=20

There is no newer u-boot from TI available. There is a SDK 02.01.03.11
but it contains the same uboot 2008.10 with the only addition of the se=
cond generation of EVM boards with another network chip.

So I checked the uboot from git, but this doesn't support Microns NAND =
=46lash anymore. It is just working with ONENAND.

I found a patch which shows the L2 Cache status while kernel boot and i=
mplemented it : L2 Cache seems to be already enabled - so this is not t=
he reason.

So any other ideas?=20
--=20
GRATIS f=FCr alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
