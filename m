From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 09/14] OMAP: DMA: Convert DMA library into platform
 driver
Date: Wed, 19 Jan 2011 11:04:42 -0800
Message-ID: <20110119190441.GB4957@atomide.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
 <1290603110-14119-10-git-send-email-manjugk@ti.com>
 <20101202184419.GR17222@atomide.com>
 <20101202184617.GS17222@atomide.com>
 <20101202184925.GT17222@atomide.com>
 <20101202200454.GA27696@manju-desktop>
 <20101202205219.GV17222@atomide.com>
 <20101203164317.GB10048@GLPP-machine>
 <AANLkTikbnP55ERXy5G7NyeF-FHcGAxcpUyZnoYx+iOKO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61365 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab1ASTEw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 14:04:52 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikbnP55ERXy5G7NyeF-FHcGAxcpUyZnoYx+iOKO@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>

* G, Manjunath Kondaiah <manjugk@ti.com> [110113 03:19]:
> >
> >>
> >> Also, eventually within next few merge cycles we should have:
> >>
> >> arch/arm/mach-omap1/dma.c =C2=A0 =C2=A0 omap1 specific platform in=
it
> >> arch/arm/mach-omap2/dma.c =C2=A0 =C2=A0 omap2+ specific platform i=
nit
> >
> > This seems to be ok.
> >
> >> drivers/dma/omap-dma.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0driver using dmaengine.c
> >
> > This might require more time.
>=20
> Since this will take more time, can we have run time pm changes on to=
p
> of existing dma hwmod changes?
> If so, I can pull out run time pm patch from the dma hwmod series and
> resend it again.

Sure. That will make it easier to convert it to use dmaengine
eventually.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
