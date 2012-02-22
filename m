From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest OMAP randconfig build error
Date: Wed, 22 Feb 2012 14:56:24 -0800
Message-ID: <20120222225624.GP18185@atomide.com>
References: <20120222085130.GE22675@n2100.arm.linux.org.uk>
 <CAK=WgbYxJyLoYs6vcj0dhSSAFX3vHqZAOHcr9t3+xEAh4ZPBNA@mail.gmail.com>
 <20120222175822.GV18185@atomide.com>
 <CAK=WgbY1b4qJXNr7=KyjdqGfexrum=XpTF3QYsw=OgFzv5NQ_A@mail.gmail.com>
 <20120222201236.GA8533@n2100.arm.linux.org.uk>
 <CAK=WgbYCUCwCnqMPAmmK6+rjxiOcdz3B-kB5ChZrxn_wW3wJiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:32931 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab2BVW41 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 17:56:27 -0500
Content-Disposition: inline
In-Reply-To: <CAK=WgbYCUCwCnqMPAmmK6+rjxiOcdz3B-kB5ChZrxn_wW3wJiw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "Anna, Suman" <s-anna@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

* Ohad Ben-Cohen <ohad@wizery.com> [120222 11:51]:
> On Wed, Feb 22, 2012 at 10:12 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > +#ifdef CONFIG_ARCH_OMAP2
> > +struct omap_mbox *omap2_mboxes[] =3D {
> > + =C2=A0 =C2=A0 =C2=A0 &mbox_dsp_info,
> > +#ifdef CONFIG_SOC_OMAP2420
> > + =C2=A0 =C2=A0 =C2=A0 &mbox_iva_info,
> > +#endif
> > + =C2=A0 =C2=A0 =C2=A0 NULL
> > +};
> > =C2=A0#endif
>=20
> Beautiful. Thanks!

Care to post an updated patch for me to apply into fixes?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
