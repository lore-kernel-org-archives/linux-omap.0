From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: dma: Define dma capabilities register
 bitfields and use them.
Date: Fri, 4 May 2012 10:53:54 -0700
Message-ID: <20120504175353.GJ5613@atomide.com>
References: <1336116582-11099-1-git-send-email-r.sricharan@ti.com>
 <CAMQu2gzDgPQwrv4oRCeUKEeYq4Tpu=X=SBSFjKzeTb7TzDsb9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62246 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab2EDRx4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 13:53:56 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gzDgPQwrv4oRCeUKEeYq4Tpu=X=SBSFjKzeTb7TzDsb9A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120504 00:37]:
> On Fri, May 4, 2012 at 12:59 PM, R Sricharan <r.sricharan@ti.com> wro=
te:
> > The system dma module has capabiities register indicating
> > the support for descriptor loading, constant fill, etc.
> > Use this instead of OMAP revision check to identify the features
> > supported runtime.
> >
> > This avoids patching the code for feature SOCs which has
> > those capabilities.
> >
> > Signed-off-by: R Sricharan <r.sricharan@ti.com>
> > ---
> > =C2=A0arch/arm/mach-omap2/dma.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 11 +++++++----
> > =C2=A0arch/arm/plat-omap/include/plat/dma.h | =C2=A0 =C2=A05 +++++
> > =C2=A02 files changed, 12 insertions(+), 4 deletions(-)
> >
> Looks fine. Will add it to my clean-up series if no has
> any objection on the patch.

Yes this is nice.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
