From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH v3 0/2] omap: serial: handle abort on empty rx fifo read
Date: Tue, 1 Dec 2009 18:05:35 +0200
Message-ID: <20091201160535.GC27669@shisha.kicks-ass.net>
References: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ABC1E2F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.welho.com ([213.243.153.39]:33200 "EHLO smtp5.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbZLAQG0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Dec 2009 11:06:26 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030ABC1E2F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Dec 01, 2009 at 06:50:31 +0530, Gadiyar, Anand wrote:
> Pandita, Vikram wrote:
> > 
> > introduce OMAP3_HAS_UART_NO_EMPTY_FIFO_READ feature
> > 
> > this feature is set for omap3630 and omap4 currently as 
> > empty uart rx fifo read causes an abort
> > 
> > check on this feature on omap3630 and omap4 for now and extend for future
> > vairants in future
> > 
> > Patch history:
> > V1: initial implementation
> > 	http://patchwork.kernel.org/patch/60785/
> > 	http://patchwork.kernel.org/patch/60786/
> > 
> > V2: incorporate review comments from Alan Cox
> > 	http://patchwork.kernel.org/patch/60785/
> > 	to remove 8250.c file changes by override serial_in
> > 	No 8250 driver change required now
> > 
> > V3: incorporate review comments
> > 	khilman: make function override only for affected silicons
> > 	nishant m: interoduce has_feature check, rather than cpu_is
> > 	anand g: minor commit message change
> > 
> > Vikram Pandita (2):
> >   omap: introduce uart_no_empty_fifo_read feature
> >   omap: serial: fix non-empty uart fifo read abort
> > 
> >  arch/arm/mach-omap2/id.c              |    7 +++++++
> >  arch/arm/mach-omap2/serial.c          |   21 +++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/cpu.h |    2 ++
> >  3 files changed, 30 insertions(+), 0 deletions(-)
> > 
> 
> Ping?
> 
> Tony,
> 
> These two patches are the only ones pending to make 3630 platforms boot
> up nicely. Would you consider taking them?

Tested.
---cut---
[    0.000000] OMAP3630 ES1.0 (l2cache iva sgx neon isp uart_no_empty_fifo_read )
---cut---

Acked-by: Alexander Shishkin <virtuoso@slind.org>

Regards,
--
Alex
