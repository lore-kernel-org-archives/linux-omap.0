From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/3] OMAP3: Remove auto-selection of PMICs
Date: Thu, 22 Sep 2011 15:25:17 -0700
Message-ID: <20110922222517.GX2937@atomide.com>
References: <1316698155-954-1-git-send-email-abhilash.kv@ti.com>
 <1316698155-954-2-git-send-email-abhilash.kv@ti.com>
 <1316698155-954-3-git-send-email-abhilash.kv@ti.com>
 <1316698155-954-4-git-send-email-abhilash.kv@ti.com>
 <877h50qlne.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24518 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab1IVWZV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Sep 2011 18:25:21 -0400
Content-Disposition: inline
In-Reply-To: <877h50qlne.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Abhilash K V <abhilash.kv@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, sameo@linux.intel.com, christian.gmeiner@gmail.com, santosh.shilimkar@ti.com, premi@ti.com, david.woodhouse@intel.com

* Kevin Hilman <khilman@ti.com> [110922 14:30]:
> Abhilash K V <abhilash.kv@ti.com> writes:
> 
> > The current implementation almost assumes that only
> 
> almost?  ;)
> 
> > TWL4030/TWL5030/TWl6030 are (or can be) used with the
> > OMAP processors. This is, however, not true.
> >
> > This patch removes the automatic selection of the PMIC
> > from Kconfig.
> > All currently used PMICs are now added to omap2plus_defconfig;
> 
> I don't think adding them to omap2plus_defconfig is right either, as
> those will get stripped out the next time that file is (re)generated.
> 
> > any new PMIC that gets supported in future could now be
> > enabled here rather than by changing Kconfig for
> > ARCH_OMAP2PLUS_TYPICAL
> 
> IMO, the right fix is to have the board Kconfig entries select the PMIC
> being used on those boards.  That is the only solution that will scale,
> and also work when using 'make randconfig'.

Agreed.

Tony
