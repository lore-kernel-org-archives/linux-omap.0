From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 04/39] ARM: OMAP2+: gpmc: Acquire NAND CS value
Date: Mon, 14 May 2012 10:33:38 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98BD5A@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <10220de398d22fad5de783d8f58fc55ebac85338.1335874494.git.afzal@ti.com>
 <4FA05292.7030902@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9829B0@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45578 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754997Ab2ENKdp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 May 2012 06:33:45 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9829B0@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi All,

On Thu, May 03, 2012 at 14:12:11, Mohammed, Afzal wrote:

> > > Some boards depend on bootloader to update chip select value for NAND.
> > > It is felt that Kernel should not depend on bootloader to get CS, as
> > > for a particular board CS is hardwired and is fixed, hence this can
> > > directly be updated in Kernel. But as CS value for boards that depend
> > > on this behaviour is not available, educate gpmc driver to acquire
> > > chip select value for NAND. this ideally should be removed once CS
> > > for those boards are available.
> > 
> > Do you know how many boards require this? If so which are those boards?
> 
> devkit8000, beagle board, omap3touchbook, overo.
> 
> Beagle board, found out to be zero.

I need a help.

Can someone familiar with boards - devkit8000, omap3touchbook, overo boards,
let me know GPMC CS on which NAND is connected.

Hi Tony,

I am planning to provide actual CS # used for NAND on above boards instead of
finding the value at runtime. Is there any reason that NAND CS# is found out
at runtime ? (hence remove necessity of omap_nand_flash_init()).

Presence of this also causes an additional dependency of bootloader.

As CS # depends on wiring on the board, my understanding is that it will be
fixed for a given board. Are you ok if acquiring NAND CS # is removed ?

Removal of this helps in simplifying gpmc driver (undergoing conversion).

Regards
Afzal
