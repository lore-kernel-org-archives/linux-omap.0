From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP baseline test results for v3.10-rc6
Date: Wed, 26 Jun 2013 17:41:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306261741010.6135@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83ECC9548@DBDE04.ent.ti.com>
 <alpine.DEB.2.02.1306261641040.6135@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-109013179-1372268498=:6135"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53679 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab3FZRlj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jun 2013 13:41:39 -0400
In-Reply-To: <alpine.DEB.2.02.1306261641040.6135@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rini, Tom" <trini@ti.com>, "khilman@ti.com" <khilman@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-109013179-1372268498=:6135
Content-Type: TEXT/PLAIN; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 26 Jun 2013, Paul Walmsley wrote:

> On Wed, 26 Jun 2013, Hiremath, Vaibhav wrote:
>=20
> > That=92s not quite true, I remember going through your log in detail mu=
ltiple
> > Times.
> >=20
> > The issue is, for appended DTB you must enable 2 config options,
> >=20
> > CONFIG_ARM_APPENDED_DTB =3D y
> > CONFIG_ARM_ATAG_DTB_COMPAT =3D y
>=20
> Maybe you should look again.  Both of these options are set in the=20
> am33xx_only Kconfig which is used here for the Beaglebone-White boot.

(and I do appreciate the attention you brought to looking into this issue=
=20
a few months ago)


- Paul
--843723315-109013179-1372268498=:6135--
