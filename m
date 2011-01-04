From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] OMAP: TWL: sparse fixes
Date: Tue, 04 Jan 2011 14:44:46 -0800
Message-ID: <1294181086.18162.38.camel@localhost>
References: <1294081110-23695-1-git-send-email-nm@ti.com>
	 <8762u47dmk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:57552 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750875Ab1ADWou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 17:44:50 -0500
Received: by ewy27 with SMTP id 27so6450899ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 14:44:49 -0800 (PST)
In-Reply-To: <8762u47dmk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>

On Tue, 2011-01-04 at 10:00 -0800, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Source:
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> > branch: omap-for-linus
> >
> > Doing a rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/
> > resulted in the following sparse warnings:
> > http://pastebin.mozilla.org/907954
> >
> > This series fixes the twl warnings
> > Nishanth Menon (2):
> >   OMAP2+: TWL: make conversion routines static
> >   OMAP2+: TWL: include pm header for init protos
> >
> >  arch/arm/mach-omap2/omap_twl.c |   10 ++++++----
> >  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Tony, these should probably queue for .38 if it's not too late.

On second thought, it's too late for the main 2.6.38 merge window for
these.  I'll queue these in my pm-fixes branch for the 2.6.38-rc cycle.

Kevin


