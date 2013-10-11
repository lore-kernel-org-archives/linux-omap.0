From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 1/6] mtd: nand: omap: combine different flavours of
 1-bit hamming ecc schemes
Date: Fri, 11 Oct 2013 11:33:45 -0700
Message-ID: <20131011183344.GY29913@atomide.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <1381498603-15715-2-git-send-email-pekon@ti.com>
 <20131011155535.GQ25706@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43507 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab3JKSeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 14:34:15 -0400
Content-Disposition: inline
In-Reply-To: <20131011155535.GQ25706@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Pekon Gupta <pekon@ti.com>, mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, bcousson@baylibre.com, avinashphilipk@gmail.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

* Felipe Balbi <balbi@ti.com> [131011 09:04]:
> On Fri, Oct 11, 2013 at 07:06:38PM +0530, Pekon Gupta wrote:
> > OMAP NAND driver currently supports multiple flavours of 1-bit Hamming
> > ecc-scheme, like:
> > - OMAP_ECC_HAMMING_CODE_DEFAULT
> > 	1-bit hamming ecc code using software library
> > - OMAP_ECC_HAMMING_CODE_HW
> > 	1-bit hamming ecc-code using GPMC h/w engine
> > - OMAP_ECC_HAMMING_CODE_HW_ROMCODE
> > 	1-bit hamming ecc-code using GPMC h/w engin with ecc-layout compatible
> > 	to ROM code.
> > 
> > This patch combines above multiple ecc-schemes into single implementation:
> > - OMAP_ECC_HAM1_CODE_HW
> > 	1-bit hamming ecc-code using GPMC h/w engine with ROM-code compatible
> > 	ecc-layout.
> > 
> > Signed-off-by: Pekon Gupta <pekon@ti.com>
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

This one looks safe to queue via the MTD tree for the arch/arm/*omap* parts:

Acked-by: Tony Lindgren <tony@atomide.com>
