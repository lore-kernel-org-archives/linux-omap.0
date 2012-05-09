From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Wed, 9 May 2012 09:00:42 -0700
Message-ID: <20120509160042.GM5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
 <CAJ7qFSfkHGF7ehanZP=hyZ27HqSp1ONsT0tUV-wpLne9B4DEaQ@mail.gmail.com>
 <20120507173351.GB5088@atomide.com>
 <CAJ7qFSeziNRTUsUWc2Owjqs=A99p_WgiVH8vnEBoVB42v2p+pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:37711 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757051Ab2EIQAp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 12:00:45 -0400
Content-Disposition: inline
In-Reply-To: <CAJ7qFSeziNRTUsUWc2Owjqs=A99p_WgiVH8vnEBoVB42v2p+pQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Sricharan" <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

* R, Sricharan <r.sricharan@ti.com> [120509 02:09]:
> Tony,
>=20
> [snip]
> >> >> -#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2)=
 || =C2=A0 =C2=A0\
> >> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defined=
(CONFIG_ARCH_OMAP3))
> >> >> +#if (defined(CONFIG_ARCH_OMAP5) || defined(CONFIG_ARCH_OMAP4))=
 && \
> >> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(defined(CONFIG_AR=
CH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
> >> >> +
> >> >> =C2=A0static inline u32 omap2_prm_read_mod_reg(s16 module, u16 =
idx)
> >> >> =C2=A0{
> >> >> =C2=A0 =C2=A0 =C2=A0 WARN(1, "prm: omap2xxx/omap3xxx specific f=
unction and "
> >> >
> >> > Maybe these functions could be just set up as __weak to avoid th=
e
> >> > ifdeffery?
> >> >
> >> =C2=A0sorry to understand,
> >> =C2=A0you mean make this weak and have a strong override for OMAP2=
 ?
> >
> > Yeah that should do the trick, right?
>  Ok, There are multiple functions under that #ifdef.
>  Also i see that __weak cannot be used for inline functions.
> So should those functions should be moved to .c file and qualify them
>  __weak. There is already a strong override for OMAP2 and 3 which
> should not be a problem.

Yes that's worth experimenting with to set up things in a way where
we don't need to add new ifdefs to add a new SoC.
=20
> [OR]
>=20
>  So after the cleanup patch introducing CONFIG_SOC_OMAP4PLUS
>  it can be changed as
>  #ifdef (CONFIG_SOC_OMAP4PLUS) && !(defined(CONFIG_ARCH_OMAP2) ||
> defined(CONFIG_ARCH_OMAP3))
>=20
> So this will avoid patching this for the future socs. ?

Well it seems that we've come to a conclusion that if we introduce
new config options, they should be based on features instead. So
CONFIG_SOC_HAS_OMAPXYZ_BLAH rather than CONFIG_SOC_OMAP4PLUS.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
