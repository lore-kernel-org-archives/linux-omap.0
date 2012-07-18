From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv6 3/7] ARM: OMAP4: hwmod: flag hwmods/modules not
 supporting module level context status
Date: Wed, 18 Jul 2012 12:00:42 +0300
Message-ID: <1342602042.4672.85.camel@sokoban>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
	 <1339428387-4800-4-git-send-email-t-kristo@ti.com>
	 <CAOMWX4e9bpJivetsx-FD_U7BbjrWh0Xto-7MTUe5YK8Mjpi9Sg@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39896 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704Ab2GRJAx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jul 2012 05:00:53 -0400
In-Reply-To: <CAOMWX4e9bpJivetsx-FD_U7BbjrWh0Xto-7MTUe5YK8Mjpi9Sg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Tue, 2012-07-17 at 03:11 -0500, Menon, Nishanth wrote:
> On Mon, Jun 11, 2012 at 10:26 AM, Tero Kristo <t-kristo@ti.com> wrote:
> > On OMAP4 most modules/hwmods support module level context status. On
> > OMAP3 and earlier, we relied on the power domain level context status.
> > Identify all modules that don't support 'context_offs' by marking the
> > offset as USHRT_MAX. Rest have a valid 'context_offs' populated in
> > .prcm structure already.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > index 86fc513..828e7b8 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -208,6 +208,7 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
> >         .prcm = {
> >                 .omap4 = {
> >                         .clkctrl_offs = OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET,
> > +                       .context_offs = USHRT_MAX,
> 
> OMAP4430_RM_ABE_AESS_CONTEXT? why not use LOSTMEM_AESSMEM ? ABE will
> need to know when it lost context to be able to reload it's firmware,
> no?

You are right, this should be possible to use. I just searched for
modules which didn't have context_offs defined and added USHRT_MAX
blindly there.

-Tero


