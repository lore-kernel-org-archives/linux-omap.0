From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3 0/4] RFC: OMAP GPMC DT bindings
Date: Fri, 2 Nov 2012 14:29:07 -0500
Message-ID: <50941F03.2030701@ti.com>
References: <1351869956-2787-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38796 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096Ab2KBT30 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 15:29:26 -0400
In-Reply-To: <1351869956-2787-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, robherring2@gmail.com, linux-omap@vger.kernel.org, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com


On 11/02/2012 10:25 AM, Daniel Mack wrote:
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

Thanks. But I am still not completely happy with this. You may wish to
wait until we have resolved all the current comments before sending out
another version.

Cheers
Jon
