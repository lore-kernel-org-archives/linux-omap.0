From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/10] OMAP3: MMC: Add mux for pins
Date: Thu, 13 Aug 2009 10:26:51 +0100
Message-ID: <20090813092651.GV6132@n2100.arm.linux.org.uk>
References: <20090812120926.17601.85860.stgit@localhost> <20090812121849.17601.42907.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39968 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbZHMJ1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 05:27:00 -0400
Content-Disposition: inline
In-Reply-To: <20090812121849.17601.42907.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org, Chikkature Rajashekar <madhu.cr@ti.com>

On Wed, Aug 12, 2009 at 03:18:49PM +0300, Tony Lindgren wrote:
> +			if (mmc_controller->slots[0].wires == 8)
> +				printk(KERN_WARNING
> +					"\n MMC2: DAT4, DAT5, DAT6, DAT7: "
> +					"Setup the mux in board file");
> +		}
> +		if (controller_nr == 2) {
> +			/* MMC3 */
> +			printk(KERN_WARNING
> +				"\n MMC3: Setup the mux in board file: "
> +				"Multiple options exist, so is board specific");
> +		}

Having printks which issue a level, followed by a newline, message and
omitting the newline at the end looks really wrong:

- firstly, the KERN_WARNING "\n" line creates a blank line in the kernel
  message log.
- the message itself will be at the kernels default message level
- the following kernel message will be appended to the end, with any
  level tag exposed.

So I think the above printk statements are completely wrong and broken.
