From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 13:02:22 +0000
Message-ID: <20120319130222.GC5705@sirena.org.uk>
References: <4F22DEF2.5000807@ti.com>
 <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <201203150922.06379.arnd@arndb.de>
 <20120315102736.GA25371@avionic-0098.adnet.avionic-design.de>
 <20120317104751.4F00E3E0910@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44408 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab2CSNCc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 09:02:32 -0400
Content-Disposition: inline
In-Reply-To: <20120317104751.4F00E3E0910@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Mar 17, 2012 at 10:47:51AM +0000, Grant Likely wrote:

> After implementing both schemes (ie. interrupts+interrupt-names && [*-]gpios)
> I definitely prefer the fixed property name plus a separate names property.
> It is easier to use common code with that scheme, and easier to statically
> check for correctness.

It's not a fantastic experience when using the bindings as the arrays
grow large, though - keeping things matched up isn't much fun especially
if any of the elements in the array are optional.
