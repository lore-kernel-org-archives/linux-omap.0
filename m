From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/4] ARM: OMAP: Move omap_reserve() locally to mach-omap1/2
Date: Sun, 30 Sep 2012 13:50:22 +0530
Message-ID: <CAMQu2gxN=gW_Gxr4awuJ4VT6RkZi_qHiTvmjwqbLKvCqb4RoyQ@mail.gmail.com>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
 <1348839609-10456-4-git-send-email-lokeshvutla@ti.com> <20120929193944.GB15246@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:46646 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752565Ab2I3IUo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 30 Sep 2012 04:20:44 -0400
Received: by vcbfo13 with SMTP id fo13so4693526vcb.19
        for <linux-omap@vger.kernel.org>; Sun, 30 Sep 2012 01:20:43 -0700 (PDT)
In-Reply-To: <20120929193944.GB15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, tony@atomide.com
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org

On Sun, Sep 30, 2012 at 1:09 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Fri, Sep 28, 2012 at 07:10:08PM +0530, Lokesh Vutla wrote:
> > omap_reserve() is a stub for omap1. So creating a
> > stub locally in mach-omap1. And moving the definition
> > to mach-omap2.
> > This helps in moving plat/omap_secure.h local to
> > mach-omap2
> >
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-omap1/common.h             |    3 +++
> >  arch/arm/mach-omap2/common.c             |   20 ++++++++++++++++++++
> >  arch/arm/mach-omap2/common.h             |    1 +
> >  arch/arm/plat-omap/common.c              |   17 -----------------
> >  arch/arm/plat-omap/include/plat/common.h |    1 -
> >  5 files changed, 24 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
> > index c2552b2..f7b01f1 100644
> > --- a/arch/arm/mach-omap1/common.h
> > +++ b/arch/arm/mach-omap1/common.h
> > @@ -90,4 +90,7 @@ extern int ocpi_enable(void);
> >  static inline int ocpi_enable(void) { return 0; }
> >  #endif
> >
> > +static inline void omap_reserve(void)
> > +{ }
>
> This is the wrong approach.  If OMAP1 doesn't need to do any reservation,
> then OMAP1 platforms should not be calling omap_reserve() and OMAP1 should
> not have this defined.
>
> Just because OMAP2 does something one way does not mean OMAP1 needs to
> copy it in every detail.

This patch just updated the code as is. I mean the empty  reserve
callback already
exist before this patch.

But I do agree with you. I think we can drop the reserve callback completly from
OMAP1 board files and then its easier to just make the omap_reserve() local to
OMAP2+ machines.

Tony,
Are you ok in dropping OMAP1 reserve callback from all OMAP1 machines ?

Regards
Santosh
