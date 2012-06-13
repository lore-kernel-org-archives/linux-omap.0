From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Wed, 13 Jun 2012 05:42:15 -0700
Message-ID: <20120613124215.GT12766@atomide.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
 <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998D51@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27726 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab2FMMmS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 08:42:18 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998D51@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120613 05:43]:
> Hi Tony,
> 
> On Wed, Jun 13, 2012 at 17:02:17, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [120612 22:00]:
> > > Yes, that would be better except for too much logging, if Tony
> > > prefers that way I will add. 
> > 
> > If there's a chance it causing file system corruption, we should
> > test it carefully on the boards before applying. If that's done,
> > then there's probably no need for warnings. It's safer to disable
> > NAND for untested boards if there's a chance of breaking the timings.
> 
> By disabling NAND, I understand that you are suggesting to remove
> nand initialization done in board file, right ?

Yes, but before we do that, let's fix things first for cases that we
can test, like tusb6010 DMA.
 
> And boards that can be tested here are omap3evm & beagleboard,
> both of which can't be tested for this change.
> 
> Or should additional timings be achieved without affecting old
> interface, but that it seems would necessitate more code
> duplication.

We should just keep the same timings as before, with values
added for the newly added registers.

Regards,

Tony
