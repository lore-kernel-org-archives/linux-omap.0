From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v4 1/4] TI816X: Update common omap platform files
Date: Tue, 18 Jan 2011 06:37:36 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A8346C3@dbde02.ent.ti.com>
References: <1294677465-18658-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1101171707070.13225@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43474 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241Ab1ARBHr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 20:07:47 -0500
In-Reply-To: <alpine.DEB.2.00.1101171707070.13225@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Paul Walmsley wrote on Tuesday, January 18, 2011 5:38 AM:

> Hello Hemant,
>=20
> On Mon, 10 Jan 2011, Hemant Pedanekar wrote:
>=20
>>  2) OMAP3 only build with CONFIG_SOC_OMAPTI816X: This will build TI8=
16X
>>  optimized kernel. May not boot on other OMAP3 SoCs.
>=20
> ...
>=20
>> Note that OMAP3 only build with support for OMAP3 SoCs as well as TI=
816X
>> is not possible.
>=20
> Could you explain a little bit why this is not possible? Na=EFvely, t=
o me,
> it seems that it should be possible.
>=20
>=20
> - Paul

Hi Paul,
You are correct, the OMAP3 only kernel built with TI816X also boots on
OMAP3 EVM. But my main concern is with cpu_is_ti816x becoming true for =
this
build (optimized build for TI816X only), some of the OMAP3 related part
will be skipped. E.g.,

-       if (omap_rev() >=3D OMAP3430_REV_ES2_0)    =20
+       if (!cpu_is_ti816x() && (omap_rev() >=3D OMAP3430_REV_ES2_0))=20
                omap3_clk_lock_dpll5();=20

Thanks
-
Hemant

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
