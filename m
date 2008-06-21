From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Boot failure on OMAP 3430 SDP
Date: Sat, 21 Jun 2008 13:50:21 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022BB66209@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB022BE46296@dbde02.ent.ti.com>,<485CA347.909@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:36282 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbYFUIUx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Jun 2008 04:20:53 -0400
In-Reply-To: <485CA347.909@googlemail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "jouni.hogander@nokia.com" <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

> > Hi all,
> >
> > Commit 5b36d70fa08f09de161487fe7f6e04200ffb8d71 breaks boot on OMAP3430 SDP. Reversing the patch allows the boot to work.
> >
> > Bootlog and the patch are shown below.
> >
> > Regards,
> > Anand
> >
> > ================================================
> >
> > commit 5b36d70fa08f09de161487fe7f6e04200ffb8d71
> > Author: Jouni Hogander <jouni.hogander@nokia.com> >
> > Date:   Mon Jun 9 12:32:40 2008 +0300
> >
> >     PRCM: OMAP3: Fix to wrongly modified omap2_clk_wait_ready
> >
> >     omap2_clk_wait_ready was wrongly modified to check
> >     registers contents. This fix changes it back to check
> >     addresses.
> >
> >     Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com> >
> >     Acked-by: Paul Walmsley <paul@pwsan.com> >
> >     Signed-off-by: Tony Lindgren <tony@atomide.com> >
> >
> > diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> > index d3ab537..ed15868 100644
> > --- a/arch/arm/mach-omap2/clock.c
> > +++ b/arch/arm/mach-omap2/clock.c
> > @@ -246,8 +246,8 @@ static void omap2_clk_wait_ready(struct clk *clk)
> >         /* REVISIT: What are the appropriate exclusions for 34XX? */
> >         /* OMAP3: ignore DSS-mod clocks */
> >         if (cpu_is_omap34xx() &&
> > -           ((reg & ~0xff) == cm_read_mod_reg(OMAP3430_DSS_MOD, 0) ||
> > -            (((reg & ~0xff) == cm_read_mod_reg(CORE_MOD, 0)) &&
> > +           ((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
> > +            (((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(CORE_MOD, 0)) &&
> >               clk-> >enable_bit == OMAP3430_EN_SSI_SHIFT)))
> >                 return;
> Hmm, looking at recent git, we already have OMAP34XX_CM_REGADDR
> instead of cm_read_mod_reg there
>
> http://source.mvista.com/git/?p=linux-omap-2.6.git;a=blob;f=arch/arm/mach-omap2/clock.c;h=ed1586847db4dd95cff8016e4259b533f1582737;hb=HEAD
>
> and it seems that this patch is already applied
>
> http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commitdiff;h=5b36d70fa08f09de161487fe7f6e04200ffb8d71
>
> ?
>
> *BUT*: I still see below Unhandled fault at OMAP3 based Beagle board!
> Any idea?

Oops. Sorry for this confusion. The patch inlined in the mail was the commit that
causes the boot failure - not the fix. I would rather have Jouni and Paul look at the
commit. I haven't looked too deeply at the patch to see why it causes the crash.

Until this is fixed, you might just want to apply the patch in reverse.

>
> Btw: Next time sending a patch, adding [PATCH] to subject would be
> helpful. And e.g. "PRCM: OMAP3: Fix to wrongly modified
> omap2_clk_wait_ready" would have been a better subject ;)

Yes, I know. As I've said, this mail was not a patch. Should have worded it better.
I was just trying to save people some time by inlining the contents of the commit.

- Anand
