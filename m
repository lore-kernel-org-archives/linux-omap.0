From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/5] omap4: l2x0 fixes and cleanup
Date: Tue, 14 Dec 2010 10:38:20 +0530
Message-ID: <8e452d427e061b34d119e860a0e30b31@mail.gmail.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com> <cc00e38ed5f706eff13e0fad542af71c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:33093 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751077Ab0LNFIX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 00:08:23 -0500
Received: by pxi1 with SMTP id 1so39174pxi.13
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 21:08:23 -0800 (PST)
In-Reply-To: <cc00e38ed5f706eff13e0fad542af71c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: Nishanth Menon <nm@ti.com>, mans@mansr.com, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

ping
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Thursday, December 02, 2010 5:28 PM
> To: tony@atomide.com
> Cc: Nishanth Menon; mans@mansr.com; khilman@deeprootsystems.com; linux-
> arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 0/5] omap4: l2x0 fixes and cleanup
>
> Tony,
> > -----Original Message-----
> > From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> > Sent: Friday, November 19, 2010 11:01 PM
> > To: linux-omap@vger.kernel.org
> > Cc: nm@ti.com; mans@mansr.com; tony@atomide.com;
> > khilman@deeprootsystems.com; linux-arm-kernel@lists.infradead.org;
> Santosh
> > Shilimkar
> > Subject: [PATCH 0/5] omap4: l2x0 fixes and cleanup
> >
> > This series is outcome of the below discussion thread.
> > 	http://www.spinics.net/lists/arm-kernel/msg104254.html
> >
> > The series in brief has following patches
> > 	- adds PL310 aux-control register bitfields
> > 	- Use these bitfields instead of hardcoded values as part of init
> > 	- Enable PL310 intsruction, Data prefetch hints and  BRESP to
> > 		improve performance
> > 	- Set share-override bit to avoid non-cached buffer corruption
> >
> > Thanks to Nishant Menon for testing this series on OMAP4 panda using
> > the memspeed utility. Have boot tested this series on OMAP4 SDP with
> > omap2plus_defconfig.
> >
> How about merging this series in omap-testing if you are ok
> with it. Patch  " ARM: l2x0: Add aux control register bitfields"
> is already acked by Catalin.
>
> > The following changes since commit
> > e53beacd23d9cb47590da6a7a7f6d417b941a994:
> >   Linus Torvalds (1):
> >         Linux 2.6.37-rc2
> >
> > Mans Rullgard (1):
> >       omap4: l2x0: enable instruction and data prefetching
> >
> > Santosh Shilimkar (4):
> >       ARM: l2x0: Add aux control register bitfields
> >       omap4: l2x0: Construct the AUXCTRL value using defines
> >       omap4: l2x0: Set share override bit
> >       omap4: l2x0: Enable early BRESP bit
> >
> >  arch/arm/include/asm/hardware/cache-l2x0.h |   12 ++++++++++-
> >  arch/arm/mach-omap2/omap4-common.c         |   30
> +++++++++++++++++++++--
> > ----
> >  2 files changed, 34 insertions(+), 8 deletions(-)
