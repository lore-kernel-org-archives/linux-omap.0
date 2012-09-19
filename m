From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH RESEND 0/5] ARM: dts: AM33XX: Add device tree data
Date: Wed, 19 Sep 2012 21:26:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209192124570.5264@utopia.booyaka.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com> <B7CE1C39EBFBA0428A012975D4B2FC830B5DF78F@DNCE05.ent.ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-814770954-1348089989=:5264"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57635 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2ISV03 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:26:29 -0400
In-Reply-To: <B7CE1C39EBFBA0428A012975D4B2FC830B5DF78F@DNCE05.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-814770954-1348089989=:5264
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt

On Wed, 19 Sep 2012, Cousson, Benoit wrote:

> Thanks for the rebase / repost. I'll pulled the full series if Paul is OK=
 with
>   ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data
>=20
> Paul,
> Is that OK?

Looks to me like the clock change is unrelated to the DTS changes?  Best=20
thing would be if you could just take the DTS changes and I'll take the=20
clkdev alias change. =20

Otherwise if that doesn't work I can ack it, but there might be some=20
conflicts with other clkdev data changes.


- Paul
--843723315-814770954-1348089989=:5264--
