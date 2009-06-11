From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: OMAP3xxx hsmmc : MMC3 doesn't work, always times out?
Date: Thu, 11 Jun 2009 08:09:15 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5345DB6@dbde02.ent.ti.com>
References: <5a7b8b7b0906101913h2dbcbbc6l8f27873b8f81a3e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52500 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbZFKCjY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2009 22:39:24 -0400
In-Reply-To: <5a7b8b7b0906101913h2dbcbbc6l8f27873b8f81a3e0@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hugo Vincent <hugo.vincent@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

Hugo

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hugo
>Vincent
>Sent: Wednesday, June 10, 2009 9:14 PM
>To: linux-omap; General mailing list for gumstix users.
>Subject: OMAP3xxx hsmmc : MMC3 doesn't work, always times out?
>
>Hi everyone,
>
>I'm trying to get the MMC3 slot working on my OMAP3503 Gumstix Overo
>based board working.

Please check if your MMC3 Mux setting are as follows:
Note the input configuration for CLK and CMD. This is needed.

/* MMC3 */
MUX_CFG_34XX("AF10_3430_MMC3_CLK", 0x1d0,
               OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLUP)
MUX_CFG_34XX("AC3_3430_MMC3_CMD", 0x5d8,
               OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
MUX_CFG_34XX("AE11_3430_MMC3_DAT0", 0x5e4,
               OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
MUX_CFG_34XX("AH9_3430_MMC3_DAT1", 0x5e6,
               OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
MUX_CFG_34XX("AF13_3430_MMC3_DAT2", 0x5e8,
               OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
MUX_CFG_34XX("AF13_3430_MMC3_DAT3", 0x5e2,
               OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)


Also we will be soon (tomorrow) posting MUX patch for MMC1,2,3.


>
>Compiling 2.6.29-omap1 with
>    CONFIG_MMC=y
>    CONFIG_MMC_DEBUG=y
>    CONFIG_MMC_BLOCK=y
>    CONFIG_MMC_BLOCK_BOUNCE=y
>and MMC polling enabled (mmc->caps |= MMC_CAP_NEEDS_POLL; in omap_hsmmc.c)
>
>then doing: $ echo 8 > /proc/sys/kernel/printk
>gives the following:
>
>clock 0Hz busmode 1 powermode 1 cs 0 Vdd 20 width 0 timing 0
>mmc2: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
>mmc2: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
>mmc2: starting CMD0 arg 00000000 flags 000000c0
>mmci-omap-hs mmci-omap-hs.2: mmc2: CMD0, argument 0x00000000
>mmci-omap-hs mmci-omap-hs.2: IRQ Status is 1
>mmc2: req done (CMD0): 0: 00000000 00000000 00000000 00000000
>mmc2: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
>mmc2: starting CMD8 arg 000001aa flags 000002f5
>mmci-omap-hs mmci-omap-hs.2: mmc2: CMD8, argument 0x000001aa
>mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>mmc2: req done (CMD8): -110: 00000000 00000000 00000000 00000000
>mmc2: starting CMD5 arg 00000000 flags 000002e1
>mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>mmc2: req failed (CMD5): -110, retrying...
>mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>mmc2: req failed (CMD5): -110, retrying...
>mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>mmc2: req failed (CMD5): -110, retrying...
>mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>mmc2: req done (CMD5): -110: 00000000 00000000 00000000 00000000
>mmc2: starting CMD55 arg 00000000 flags 000000f5
>mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>mmc2: starting CMD55 arg 00000000 flags 000000f5
>mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>mmc2: starting CMD55 arg 00000000 flags 000000f5
>mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>mmc2: starting CMD55 arg 00000000 flags 000000f5
>mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>mmc2: starting CMD1 arg 00000000 flags 000000e1
>mmci-omap-hs mmci-omap-hs.2: mmc2: CMD1, argument 0x00000000
>mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>mmc2: req done (CMD1): -110: 00000000 00000000 00000000 00000000
>mmc2: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
>
>It seems every request returns -110 which is -ETIMEDOUT.
>
>I've checked the hardware, and it appears to be correct (level
>translators etc seem to be doing their job).
>
>During polling, the CMD and CLK signals show activity, but the data
>lines never change; this is presumably why every request is timing
>out.
>
>I've also tried it with 2.6.30-omap1 in git, which changes some
>MMC3-specific stuff (notably DMA), but has the exact same behaviour.
>
>I've also checked pin multiplexing settings and confirmed that the
>correct values are set for the MMC3 data pins. The card I'm using is a
>microSD card that works when attached to MMC1 (the Gumstix Overo
>built-in microSD slot). The slot is powered by 3.3V that is always on,
>there is no provision for power switching with this particular board.
>
>Any ideas?
>
>Many thanks,
>Hugo Vincent
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

