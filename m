From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Thu, 14 Jun 2012 03:19:02 -0700
Message-ID: <20120614101901.GI12766@atomide.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
 <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com>
 <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52253 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453Ab2FNKTF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 06:19:05 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120614 03:15]:
> Hi Tony,
> 
> On Wed, Jun 13, 2012 at 17:28:33, Mohammed, Afzal wrote:
> > On Wed, Jun 13, 2012 at 17:24:45, Tony Lindgren wrote:
> > 
> > > > If there's a chance it causing file system corruption, we should
> > > > test it carefully on the boards before applying. If that's done,
> > > > then there's probably no need for warnings. It's safer to disable
> > > > NAND for untested boards if there's a chance of breaking the timings.
> > > 
> > > Actually this patch breaks at least DMA on tusb6010 on n8x0. That's
> > > a MUSB hardware in a wrapper connected to GPMC that's very picky with
> > > the timings.
> > > 
> > > Got any hints what should be done with the cycle2cycle stuff for
> > > tusb6010?
> > 
> > Not as of now, let me try to find out.
> 
> Probably with the below patch [1], we can get values set by bootloader &
> calculate back value to entered in Kernel, of course that may not work
> if tusb6010 works with different gpmc i/p frequency.

Well I took a look at the values, and it seems the only difference is the
static GPMC_CONFIG1_CLKACTIVATIONTIME(1) that your patch now overwrites 0.

Tony
