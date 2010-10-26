From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Subject: Re: [PATCH 1/1] mtd: OneNAND: fix bufferram management when chip
 has 2-planes.
Date: Tue, 26 Oct 2010 12:36:01 +0300
Message-ID: <1288085761.2227.40.camel@localhost>
References: <1287841434-3349-1-git-send-email-eballetbo@gmail.com>
	 <1287841434-3349-2-git-send-email-eballetbo@gmail.com>
Reply-To: Artem.Bityutskiy@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:37244 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758821Ab0JZJjb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 05:39:31 -0400
In-Reply-To: <1287841434-3349-2-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>, "kyungmin.park" <kyungmin.park@samsung.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, dwmw2@infradead.org, adrian.hunter@nokia.com, m.szyprowski@samsung.com

On Sat, 2010-10-23 at 15:43 +0200, Enric Balletbo i Serra wrote:
> This patch adds code that I think was lost when it was applied the co=
mmit
>   5988af2319781bc8e0ce418affec4e09cfa77907 - mtd: Flex-OneNAND suppor=
t
>=20
> Test case:
>  1. Stress a jffs2 filesystem using
>     bonnie++ -u 0:0 -s 32 -m 16 -r 16
>  2. dmesg shows various 'Header CRC failed' errors like:
>     Header CRC failed on REF_PRISTINE node at 0x1e81315c: Read 0x0000=
00e0,
>     calculated 0x564fc9e8
>=20
> Tested on IGEP v2 board with a Muxed OneNAND(DDP) 512MB 1.8V 16-bit (=
0x58)
> with 2 planes from Numonyx and CONFIG_MTD_ONENAND_2X_PROGRAM set to y
>=20
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>

Kyungmin, would be nice to have your ack/nack.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
