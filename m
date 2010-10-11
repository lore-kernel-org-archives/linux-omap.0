From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3] OMAP2/3: NAND: Convert write/read functions to raw
 read/write
Date: Mon, 11 Oct 2010 21:59:20 +0300
Message-ID: <1286823560.1742.2.camel@brekeke>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
	 <1286315819-5906-3-git-send-email-manjugk@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57934 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455Ab0JKS7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 14:59:25 -0400
Received: by bwz15 with SMTP id 15so1897449bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 11:59:24 -0700 (PDT)
In-Reply-To: <1286315819-5906-3-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org

On Wed, 2010-10-06 at 03:26 +0530, G, Manjunath Kondaiah wrote:
> Following sparse warnings exists due to use of writel/w and readl/w f=
unctions.
>=20
> This patch fixes the sparse warnings by converting readl/w functions =
usage into
> __raw_readl/__raw_readw functions.
>=20
> drivers/mtd/nand/omap2.c:484:15: warning: symbol '__v' shadows an ear=
lier one
> drivers/mtd/nand/omap2.c:484:15: originally declared here
>=20
> drivers/mtd/onenand/omap2.c:86:9: warning: symbol '__v' shadows an ea=
rlier one
> drivers/mtd/onenand/omap2.c:86:9: originally declared here
>=20
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mtd@lists.infradead.org

I've pushed this patch to my l2-mtd-2.6.git.

--=20
Best Regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
