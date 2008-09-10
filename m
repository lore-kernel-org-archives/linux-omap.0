From: "Singh, Vimal" <vimalsingh@ti.com>
Subject: RE: [PATCH - Omapzoom] [NAND] Add prefetch and DMA support
Date: Wed, 10 Sep 2008 19:42:05 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD517C43@dbde02.ent.ti.com>
References: <DFEF307E035C8647B119E6A60DB62D4AEE4F7561@dlee02.ent.ti.com>,<200809081527.35446.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38608 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbYIJOMV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 10:12:21 -0400
In-Reply-To: <200809081527.35446.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "Kamat, Nishant" <nskamat@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> On Monday 08 September 2008, Kamat, Nishant wrote:
> > +config MTD_NAND_OMAP_PREFETCH
> > +       bool "GPMC prefetch support for NAND Flash device"
> > +       depends on MTD_NAND && MTD_NAND_OMAP2
> > +       default n
> > +       help
> > +        The NAND device can be accessed for Read/Write using GPMC PREFETCH engine
> > +        to improve the performance.
>
> Is there a reason this isn't always enabled, and the choice is just
> whether to use DMA or not?

Currently I had kept this for experimentation purpose. I will enable it in next patch.

> I'd be interested to see performance measurements for the three cases.
>
>         - current/slow code
>         - the readsw() update I sent previously
>         - this "prefetch engine"

I will do these measurements.

> And I'd expect this "prefetch engine" code would also be improved by
> using readsw() and writesw() when DMA isn't in use.
>
> On one ARM926 I observed a 16% speedup *just* from switching from
> slow byte-at-a-time PIO to using readsb ... this current code has
> that same pessimization.

> - Dave