From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Mon, 7 May 2012 10:33:51 -0700
Message-ID: <20120507173351.GB5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
 <CAJ7qFSfkHGF7ehanZP=hyZ27HqSp1ONsT0tUV-wpLne9B4DEaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10240 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203Ab2EGRdx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 13:33:53 -0400
Content-Disposition: inline
In-Reply-To: <CAJ7qFSfkHGF7ehanZP=hyZ27HqSp1ONsT0tUV-wpLne9B4DEaQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Sricharan" <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

* R, Sricharan <r.sricharan@ti.com> [120506 00:40]:
>
> > Also, please change the whole series to use CONFIG_SOC_OMAP5 instea=
d
> > of CONFIG_ARCH_OMAP5. CONFIG_ARCH_OMAPXXXX stuff will go away excep=
t
> > for CONFIG_ARCH_OMAP2PLUS. Sorry forgot to mention that earlier.
> >
>  ok. sure. will change this.

Thanks.
=20
> >> -#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) ||=
 =C2=A0 =C2=A0\
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defined(CON=
=46IG_ARCH_OMAP3))
> >> +#if (defined(CONFIG_ARCH_OMAP5) || defined(CONFIG_ARCH_OMAP4)) &&=
 \
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(defined(CONFIG_ARCH_=
OMAP2) || defined(CONFIG_ARCH_OMAP3))
> >> +
> >> =C2=A0static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx=
)
> >> =C2=A0{
> >> =C2=A0 =C2=A0 =C2=A0 WARN(1, "prm: omap2xxx/omap3xxx specific func=
tion and "
> >
> > Maybe these functions could be just set up as __weak to avoid the
> > ifdeffery?
> >
>  sorry to understand,
>  you mean make this weak and have a strong override for OMAP2 ?

Yeah that should do the trick, right?
=20
Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
