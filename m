From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] make mach-omap2 boot with device tree only for
 v3.14
Date: Tue, 10 Dec 2013 18:45:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312101034360.32309@utopia.booyaka.com>
References: <pull-1386643347-596413>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45094 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab3LJSp7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 13:45:59 -0500
In-Reply-To: <pull-1386643347-596413>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, 9 Dec 2013, Tony Lindgren wrote:

> The following changes since commit f2e2c9d9b4087b74eb9e00d8dfac148354cb0b71:
> 
>   ARM: dts: Fix booting for secure omaps (2013-12-06 15:30:43 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/omap3-board-removal-signed
> 
> for you to fetch changes up to 736e812636ea72be444b85fa7e92554967459069:
> 
>   ARM: OMAP2+: Remove unused platform init code and headers (2013-12-08 14:15:46 -0800)

The description in Tony's pull request below alludes to what regressions 
will occur when this is pulled.  But just to state it in terms of what 
happened on the local testbed here when I tried it:

- CM-T3517 booting will break since there's no .dts file for it.  Are
  there other boards that will be affected here too?

- 2430SDP NFS root will hang during boot, presumably due to the lack 
  of the smc91x patch that is mentioned below

- Dynamic idle PM tests will fail, due to the lack of the first two 
  patches that Tony mentioned.  (This is also a problem now for
  37xxevm in v3.13-rc.)

- The N800 isn't booting here with a concatenated uImage+dtb - but
  maybe I'm doing something wrong with this one.

Best if the pull request were to explicitly state the known 
regressions with this series, in terms of specific boards and 
configurations.  That way, people will know what to expect.


> ----------------------------------------------------------------
> We can now finally make mach-omap2 to boot with device tree only and get
> rid of over 20k lines of platform init code that way.
> 
> Most basic devices already work using device tree based initialization
> and the remaining devices can be initialized using platform data
> with pdata-quirks.c.
> 
> So for most missing boards it's just a question of adding a .dts file
> that should be fairly similar to one of the existing .dts files as
> we've tried to cover all basic omap3 board types.
> 
> For people getting started updating their board files to for device
> tree, there are some basic instructions in commit 8dc8b3ddf5d7
> (ARM: OMAP2+: Remove legacy omap3 board-*.c files and make mach-omap2
> DT only for booting).
> 
> Please also note that there are also some related fixes making their way
> into the mainline kernel that are needed for some use cases:
> 
> PM off-idle for omap3 and wake-up events need the following two patches:
> 
> [PATCH] of/platform: Fix no irq domain found errors when populating interrupts
> http://lkml.org/lkml/2013/11/22/520
> 
> [PATCH] ARM: dts: Fix omap serial wake-up when booted with device tree
> http://www.spinics.net/lists/devicetree/msg13374.html
> 
> EMAC Ethernet on am3517 boards needs:
> 
> [PATCH] net: davinci_emac: Fix platform data handling and make usable for am3517
> http://patchwork.ozlabs.org/patch/296351/
> 
> Ethernet for boards using smc91x needs:
> 
> [PATCH v2] net: smc91x: Fix device tree based configuration so it's usable
> http://www.spinics.net/lists/netdev/msg258913.html
> 

(snip)

- Paul

