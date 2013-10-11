From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 2/6] ARM: OMAP2+: cleaned-up DT support of various
 ECC schemes
Date: Fri, 11 Oct 2013 11:32:34 -0700
Message-ID: <20131011183234.GX29913@atomide.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <1381498603-15715-3-git-send-email-pekon@ti.com>
 <20131011155527.GP25706@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23942 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752646Ab3JKSdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 14:33:04 -0400
Content-Disposition: inline
In-Reply-To: <20131011155527.GP25706@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Pekon Gupta <pekon@ti.com>, mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, bcousson@baylibre.com, avinashphilipk@gmail.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

* Felipe Balbi <balbi@ti.com> [131011 09:03]:
> On Fri, Oct 11, 2013 at 07:06:39PM +0530, Pekon Gupta wrote:
> > OMAP NAND driver support multiple ECC scheme, which can used in following
> > different flavours, depending on in-build Hardware engines supported by SoC.
> > 
> > +---------------------------------------+---------------+---------------+
> > | ECC scheme                            |ECC calculation|Error detection|
> > +---------------------------------------+---------------+---------------+
> > |OMAP_ECC_HAM1_CODE_HW                  |H/W (GPMC)     |S/W            |
> > +---------------------------------------+---------------+---------------+
> > |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W            |
> > |(requires CONFIG_MTD_NAND_ECC_BCH)     |               |               |
> > +---------------------------------------+---------------+---------------+
> > |OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> > |(requires CONFIG_MTD_NAND_OMAP_BCH &&  |               |               |
> > | ti,elm-id in DT)                      |               |               |
> > +---------------------------------------+---------------+---------------+
> > To optimize footprint of omap2-nand driver, selection of some ECC schemes
> > also require enabling following Kconfigs, in addition to setting appropriate
> > DT bindings
> > - Kconfig:CONFIG_MTD_NAND_ECC_BCH        error detection done in software
> > - Kconfig:CONFIG_MTD_NAND_OMAP_BCH       error detection done by h/w engine
> > 
> > DT binding updates in this patch are:
> > - ti,elm-id: replaces elm_id
> > - ti,nand-ecc-opts: supported values ham1, bch4, and bch8
> > 	selection of h/w or s/w implementation depends on ti,elm-id
> > 
> > Signed-off-by: Pekon Gupta <pekon@ti.com>
> 
> since this maintains backwards compatibility, I think it should be
> alright to apply
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

This patch looks safe to queue via the MTD tree for the arch/arm/*omap*
parts in this patch:

Acked-by: Tony Lindgren <tony@atomide.com>
