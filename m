From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] MTD: OMAP2-NAND: Fix partition reading from board info
Date: Mon, 4 Aug 2008 16:45:19 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361EE18A2@dlee02.ent.ti.com>
References: <9c9fda240807011627v60428f9eh3c2bb17cdc8ce6ea@mail.gmail.com>
 <200808041302.46323.david-b@pacbell.net>
 <20080804201715.GD31974@xi.wantstofly.org>
 <200808041326.38840.david-b@pacbell.net>
 <13B9B4C6EF24D648824FF11BE89671620361EE1833@dlee02.ent.ti.com>
 <20080804213200.GH31974@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59792 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763134AbYHDVpe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 17:45:34 -0400
In-Reply-To: <20080804213200.GH31974@xi.wantstofly.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: David Brownell <david-b@pacbell.net>, "Kamat, Nishant" <nskamat@ti.com>, Tony Lindgren <tony@atomide.com>, Kyungmin Park <kmpark@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

> > The most visible BE-ARM seems to be Intel's IXP network processors.
>
> The IXPs are one of the few cases where the vendors _ships an all-BE
> software development environment by default_ -- but that doesn't mean
> that BE doesn't work on ARM CPUs where the vendor ships a LE software
> development environment by default (BE has certainly worked on all
> ARM CPUs I've ever tried it on).

I wonder how many shipping systems use LE.  A grep of current ARM Linux Kconfig's only shows 3 IXP systems setting CONFIG_CPU_BIG_ENDIAN. Perhaps you are correct about ability but few seem to use it. Seems like a trivia question for ARM Ltd.

At any rate all OMAPs have been hardwired.

Regards,
Richard W.

