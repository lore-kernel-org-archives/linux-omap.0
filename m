From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
Date: Thu, 7 Jun 2012 15:14:03 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9962E7@DBDE01.ent.ti.com>
References: <cover.1338790117.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39288 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761200Ab2FGPOP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 11:14:15 -0400
In-Reply-To: <cover.1338790117.git.afzal@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Cc: "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>

Hi,

On Mon, Jun 04, 2012 at 12:15:01, Mohammed, Afzal wrote:
> Hi,
> 
> This series cleans up gpmc mtd interactions so that GPMC driver
> conversion which is going to happen shortly would happen smoothly
> by not creating much disturbance outside of arch/arm/*omap*/
> 
> This series,
> 1. provides the ability for OMAP NAND driver to configure GPMC-NAND
>    registers by NAND driver itself instead of using exported GPMC
>    symbols
> 2. modifies GPMC to provide OMAP ONENAND & NAND drivers with GPMC
>    allocated address space as resource
> 3. creates a fictitious GPMC interrupt chip and provide the clients
>    with interrupts that could be handled using standard APIs (helps
>    in removing the requirement for driver of peripheral connected to
>    GPMC having the knowledge about GPMC interrupt handling). The
>    only user is OMAP NAND driver, it has also been modified to take
>    advantage of this
> 
> This series has been made over 3.5-rc1

Ping

Regards
Afzal
