From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Wed, 13 Jun 2012 11:58:33 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
 <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com> <20120613115445.GM12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59146 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab2FML6n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 07:58:43 -0400
In-Reply-To: <20120613115445.GM12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Wed, Jun 13, 2012 at 17:24:45, Tony Lindgren wrote:

> > If there's a chance it causing file system corruption, we should
> > test it carefully on the boards before applying. If that's done,
> > then there's probably no need for warnings. It's safer to disable
> > NAND for untested boards if there's a chance of breaking the timings.
> 
> Actually this patch breaks at least DMA on tusb6010 on n8x0. That's
> a MUSB hardware in a wrapper connected to GPMC that's very picky with
> the timings.
> 
> Got any hints what should be done with the cycle2cycle stuff for
> tusb6010?

Not as of now, let me try to find out.

Regards
Afzal
