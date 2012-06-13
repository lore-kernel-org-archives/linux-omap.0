From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Wed, 13 Jun 2012 04:54:45 -0700
Message-ID: <20120613115445.GM12766@atomide.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
 <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27358 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab2FMLyt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 07:54:49 -0400
Content-Disposition: inline
In-Reply-To: <20120613113217.GK12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Tony Lindgren <tony@atomide.com> [120613 04:36]:
> * Mohammed, Afzal <afzal@ti.com> [120612 22:00]:
> > Hi Jon,
> > 
> > On Tue, Jun 12, 2012 at 23:06:53, Hunter, Jon wrote:
> > 
> > > Should you at least warn, if you are going to over-write a value?
> > 
> > Yes, that would be better except for too much logging, if Tony
> > prefers that way I will add. 
> 
> If there's a chance it causing file system corruption, we should
> test it carefully on the boards before applying. If that's done,
> then there's probably no need for warnings. It's safer to disable
> NAND for untested boards if there's a chance of breaking the timings.

Actually this patch breaks at least DMA on tusb6010 on n8x0. That's
a MUSB hardware in a wrapper connected to GPMC that's very picky with
the timings.

Got any hints what should be done with the cycle2cycle stuff for
tusb6010?

Tony
