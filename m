From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH V2] omap: nand: remove hardware ECC as default
Date: Fri, 03 Dec 2010 18:22:05 +0200
Message-ID: <1291393325.2365.72.camel@localhost>
References: <1290177926-3526-1-git-send-email-s-ghorai@ti.com>
	 <20101130180542.GP17222@atomide.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49281 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab0LCQWk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 11:22:40 -0500
Received: by bwz15 with SMTP id 15so8482042bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Dec 2010 08:22:39 -0800 (PST)
In-Reply-To: <20101130180542.GP17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Sukumar Ghorai <s-ghorai@ti.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

On Tue, 2010-11-30 at 10:05 -0800, Tony Lindgren wrote:
> * Sukumar Ghorai <s-ghorai@ti.com> [101119 06:36]:
> > CONFIG_MTD_NAND_OMAP_HWECC defined wrongly in patch submitted for 2=
=2E6.36.
> > This flag enables hw ecc by default. Boards like beagle and pandora=
 uses
> > sw ecc for write (e.g. binary flushed from u-boot) and read from ke=
rnel.
> > https://patchwork.kernel.org/patch/111036/
> >=20
> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
>=20
> This should go in as a fix for the -rc via MTD list if possible.
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Tony, I think this is quite simple patch, and you can merge it yourself=
,
MTD tree is slow. I hope dwmw2 will not beat me for this, but unless he
quickly jumps in and confirms he takes care of this patch, just go ahea=
d
an merge it. I've put dwmw2 to "To:", just in case.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
