From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/3] omap3 nand: cleanup virtual address usages
Date: Wed, 19 May 2010 11:19:12 -0700
Message-ID: <20100519181912.GF5818@atomide.com>
References: <s-ghorai@ti.com>
 <1274181389-7488-1-git-send-email-s-ghorai@ti.com>
 <1274181389-7488-2-git-send-email-s-ghorai@ti.com>
 <1274181389-7488-3-git-send-email-s-ghorai@ti.com>
 <AANLkTinEaP9cN5A24K9Zwd4L9Fq4pzxQqqY44r7NSl4-@mail.gmail.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030D991D43@dbde02.ent.ti.com>
 <AANLkTikh1c3tgtO5TvOnNzJKXz7oTnna1WfLiWU67C_5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49285 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab0ESSTV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 14:19:21 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikh1c3tgtO5TvOnNzJKXz7oTnna1WfLiWU67C_5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "sakoman@gmail.com" <sakoman@gmail.com>, "mike@compulab.co.il" <mike@compulab.co.il>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>

* Vimal Singh <vimal.newwork@gmail.com> [100519 11:02]:
> On Wed, May 19, 2010 at 10:54 PM, Ghorai, Sukumar <s-ghorai@ti.com> w=
rote:
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* take care of subpage reads */
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0for (; len % 4 !=3D 0; ) {
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*buf++ =3D=
 __raw_readb(info->nand.IO_ADDR_R);
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len--;
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >> > - =C2=A0 =C2=A0 =C2=A0 p =3D (u32 *) buf;
> >>
> >> Above code had an issue, which was fixed by this commit:
> >> http://git.infradead.org/mtd-
> >> 2.6.git/commitdiff/c3341d0ceb4de1680572024f50233403c6a8b10d
> >>
> >> I would suggest you to prepare your patch on MTD tree.
> > [Ghorai] Patches started posting on lo. And lets continue the same.
>=20
> Not sure about this. Its your/Tony's call.

I'd assume that fix is on it's way to the mainline kernel,
looks like a trivial rebase after the merge window is over.

Anyways, this will not make it this merge window, we're
out of time.

Regards,

Tony=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
