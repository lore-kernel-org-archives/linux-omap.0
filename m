From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3] OMAP: NAND: Fix static declaration warning
Date: Mon, 11 Oct 2010 21:58:14 +0300
Message-ID: <1286823495.1742.0.camel@brekeke>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36172 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233Ab0JKS6V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 14:58:21 -0400
Received: by bwz15 with SMTP id 15so1896787bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 11:58:20 -0700 (PDT)
In-Reply-To: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

On Wed, 2010-10-06 at 03:26 +0530, G, Manjunath Kondaiah wrote:
> This patch fixes sparse warning for static declaration of variable "u=
se_dma"
>=20
> drivers/mtd/nand/omap2.c:114:11: warning: symbol 'use_dma' was not de=
clared. Should it be static?
>=20
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mtd@lists.infradead.org
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>

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
