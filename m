From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] OMAP3 clock: fix omap2_clk_wait_ready for OMAP3430ES2
 DSS
Date: Mon, 23 Jun 2008 08:52:00 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806230849130.4919@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB022BE46296@dbde02.ent.ti.com> <485CA347.909@googlemail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BB66209@dbde02.ent.ti.com> <alpine.DEB.1.00.0806211054100.19765@utopia.booyaka.com> <ACAEC52B-E9B4-4789-8D63-114C53846760@student.utwente.nl>
 <13B9B4C6EF24D648824FF11BE8967162035BA2A659@dlee02.ent.ti.com> <alpine.DEB.1.00.0806221308090.7503@utopia.booyaka.com> <874p7kad66.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-292305806-1214232720=:4919"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42625 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbYFWOwC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2008 10:52:02 -0400
In-Reply-To: <874p7kad66.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Koen Kooi <k.kooi@student.utwente.nl>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dirk Behme <dirk.behme@googlemail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-292305806-1214232720=:4919
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jouni

On Mon, 23 Jun 2008, H=C3=B6gander Jouni wrote:

> Hello Paul,
>=20
> It should actually wait for SSI also. Read my comments below.

=2E..

> And add this part
>=20
> +       if (cpu_is_omap34xx() &&
> +=09    prcm_mod =3D=3D OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
> +=09    clk->enable_bit =3D=3D OMAP3430_EN_SSI_SHIFT) {
> +=09=09bit =3D OMAP3430ES2_ST_SSI_IDLE;

what should OMAP3430ES2_ST_SSI_IDLE be set to?  I don't have any=20
documentation here that defines this bit.


- Paul
--155748971-292305806-1214232720=:4919--
