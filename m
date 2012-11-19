From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v4 0/3] OMAP GPMC DT bindings
Date: Mon, 19 Nov 2012 10:48:23 -0600
Message-ID: <50AA62D7.2040308@ti.com>
References: <1353338956-19420-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40568 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895Ab2KSQsa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 11:48:30 -0500
In-Reply-To: <1353338956-19420-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com


On 11/19/2012 09:29 AM, Daniel Mack wrote:
> This is a series of patches to support GPMC peripherals on OMAP boards.
> 
> Depends on Linus' master +
> omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)
> 
> The only supported peripheral for now is NAND, but other types would be
> easy to add.
> 
> Version 2 addresses details pointed out by Jon Hunter, Afzal Mohammed
> and Rob Herring:
> 
>  - add "reg" and "ti,hwmod" properties to Documentation
>  - use generic of_mtd functions and the property names defined by them,
>    namely "nand-bus-width" and "nand-ecc-mode"
>  - reduce the default register space size in the Documentation to 8K,
>    as found in the hwmod code
>  - switch to a DT layout based on ranges and address translation.
>    Although this property is not currently looked at as long as the
>    handling code still uses the runtime calculation methods, we now
>    have these values in the bindings, eventually allowing us to
>    switch the implementation with less pain.
> 
> Version 3 includes fixes pointed out by Jon Hunter:
> 
>  - better documentation of the 'ranges' property to describe the
>    fact that it's representing the CS lines
>  - GPMC_CS_CONFIGx -> GPMC_CONFIGx in comments
>  - drop interrupt-parent from example bindings
>  - add of_node_put() at the end of the child iteration
> 
> Version 4 fixes compilation for !CONFIG_MTD_NAND and includes more
> details from Jon Hunter and Avinash, Philip:
> 
>  - Add "num-cs" and "num-waitpins" properties, which will eventually
>    be used to get rid of GPMC_CS_NUM
>  - Better description of generic nand DT properties
>  - Dropped patch 3/4 as an equivalent fix was already merged
>  - Added ti,nand-ecc-use-elm property
> 
> Daniel Mack (3):
>   mtd: omap-nand: pass device_node in platform data
>   ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
>   ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
> 
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  84 ++++++++++
>  arch/arm/mach-omap2/gpmc-nand.c                    |   9 +-
>  arch/arm/mach-omap2/gpmc.c                         | 170 +++++++++++++++++++++
>  drivers/mtd/nand/omap2.c                           |   4 +-
>  include/linux/platform_data/mtd-nand-omap2.h       |   2 +
>  5 files changed, 264 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt

Thanks for sending out the update. Am I missing something or did you
drop the gpmc.txt binding documentation?

Cheers
Jon

