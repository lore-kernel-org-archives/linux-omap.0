From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 6/9] omap: dpll: Add allow_idle/deny_idle support for
 all DPLL's
Date: Tue, 8 Feb 2011 08:58:48 +0530
Message-ID: <1eea151edf0ed021258c202c6d9b5bc2@mail.gmail.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
 <1296813544-25170-7-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1102071952300.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:52747 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752779Ab1BHD2w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 22:28:52 -0500
Received: by mail-fx0-f51.google.com with SMTP id 5so5712087fxm.38
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 19:28:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102071952300.21991@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, February 08, 2011 8:27 AM
> To: rnayak@ti.com; Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; b-cousson@ti.com;
linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 6/9] omap: dpll: Add allow_idle/deny_idle support
for all DPLL's
>
> Hi
>
> On Fri, 4 Feb 2011, Santosh Shilimkar wrote:
>
> > From: Rajendra Nayak <rnayak@ti.com>
> >
> > All OMAP3/4 dpll's support hardware level autogating.
> > Populate allow_idle/deny_idle function pointers for all
> > DPLL's in clkops.
> >
> > Also for OMAP4, call omap_clk_enable_autoidle() from PM
> > core (only with CONFIG_PM) to enable hardware level
> > autogating on all clock nodes which support it (For now
> > only DPLL nodes)
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock.c          |    8 +++++++-
> >  arch/arm/mach-omap2/clock.h          |    1 +
> >  arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
> >  arch/arm/mach-omap2/clock44xx_data.c |    2 +-
> >  arch/arm/mach-omap2/pm44xx.c         |    4 ++++
>
> Looks like you add the allow_idle/deny_idle functions for the OMAP3 CORE
> DPLL, but you don't change mach-omap2/pm34xx.c.  Any reason for this?

Nothing specifically. My initial patchset was enabling these only for
OMAP4,
So I thought will keep it that way.

>  It
> seems that the current OMAP3 PM code doesn't enable CORE DPLL autoidle.
> Do you recall why?  Perhaps it is due to some of the autoidle bugs,
where
> DPLL3 would enter auto-idle while some OMAP3 IP blocks that used CORE
> clocks were not idle...

I don't recall any such bug, however I will relook at the errata docs and
also
do some validation around this on OMAP3 and report.

Regards,
Rajendra
>
>
> - Paul
