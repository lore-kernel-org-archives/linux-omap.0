From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [RFC] mtd: nand: Fix bad block identification issue
Date: Fri, 29 Apr 2011 16:12:24 +0300
Message-ID: <1304082744.2737.46.camel@localhost>
References: <1303906161-24175-1-git-send-email-parth.saxena@ti.com>
	 <1304011843.2737.3.camel@localhost>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58736 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941Ab1D2NQi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 09:16:38 -0400
Received: by ewy4 with SMTP id 4so1142427ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 06:16:37 -0700 (PDT)
In-Reply-To: <1304011843.2737.3.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Saxena, Parth" <parth.saxena@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>, linux-omap@vger.kernel.org

On Thu, 2011-04-28 at 20:30 +0300, Artem Bityutskiy wrote:
> On Wed, 2011-04-27 at 17:39 +0530, Saxena, Parth wrote:
> > This patch solves the above issue for omap by initialising
> > badblockbits. We are working further on this to find a generic fix
> > to the problem in nand_base.c.
>=20
> But it looks like the generic solution is to return the line which wa=
s
> accidentally removed, how about this patch
>=20
> From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> Date: Thu, 28 Apr 2011 20:26:59 +0300
> Subject: [PATCH] mtd: return badblockbits back
>=20
> In commit c7b28e25cb9beb943aead770ff14551b55fa8c79 the initialization=
 of
> the backblockbits was accidentally removed. This patch returns it bac=
k,
> because otherwise some NAND drivers are broken.
>=20
> This problem was reported by "Saxena, Parth <parth.saxena@ti.com>" he=
re:
> http://lists.infradead.org/pipermail/linux-mtd/2011-April/035221.html
>=20
> Reported-by: Saxena, Parth <parth.saxena@ti.com>
> Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> Cc: stable@kernel.org [2.6.36+]
> ---
>  drivers/mtd/nand/nand_base.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Any ack/nack/tested-by?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
