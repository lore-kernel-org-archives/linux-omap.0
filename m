From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC 11/12] omap: mcbsp: Remove conditional compilation for
 OMAP3
Date: Fri, 1 Jul 2011 16:47:09 +0300
Message-ID: <20110701164709.3bc6dcbf.jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
	<1309510356-27147-12-git-send-email-jhnikula@gmail.com>
	<CA+HSevqQhPP9YD=m_1Z7E=44hY0i4FFSoq7C1uP-aTsNXcMsiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56937 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab1GANrR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 09:47:17 -0400
Received: by bwd5 with SMTP id 5so2619450bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 06:47:16 -0700 (PDT)
In-Reply-To: <CA+HSevqQhPP9YD=m_1Z7E=44hY0i4FFSoq7C1uP-aTsNXcMsiw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Fri, 1 Jul 2011 16:30:09 +0530
"Varadarajan, Charulatha" <charu@ti.com> wrote:

> > --- a/arch/arm/plat-omap/mcbsp.c
> > +++ b/arch/arm/plat-omap/mcbsp.c
> > @@ -63,7 +63,6 @@ static int omap_mcbsp_read(struct omap_mcbsp *mcb=
sp, u16 reg, bool from_cache)
> > =A0 =A0 =A0 =A0}
> > =A0}
> >
> > -#ifdef CONFIG_ARCH_OMAP3
>=20
> Are there any plans to move the functions  omap_mcbsp_st_*
> to mach-omap2/* as they are specific to OMAP3 only?
>=20
I was thinking that for saving code space for non !OMAP3 builds but
thats again is not generic code if sidetone IP gets ever reused in
another silicon. Another platform device for sidetone could be one
solution but I would like to preserve sidetone sysfs nodes to get
registered to McBSP port for keeping the userspace API the same during
the transition (or over a few kernel releases).

--=20
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
