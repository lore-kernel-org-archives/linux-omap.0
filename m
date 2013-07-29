From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
Date: Mon, 29 Jul 2013 09:19:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307290917160.30864@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com> <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53806 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab3G2JTR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 05:19:17 -0400
In-Reply-To: <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Linux-OMAP <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>

Hi Linus, 

On Mon, 29 Jul 2013, Linus Walleij wrote:

> If we revert these three patches:
> 
> commit 949eb1a4d29dc75e0b5b16b03747886b52ecf854
> "gpio/omap: fix build error when OF_GPIO is not defined."
> commit b4419e1a15905191661ffe75ba2f9e649f5d565e
> "gpio/omap: auto request GPIO as input if used as IRQ via DT"
> commit 0e970cec05635adbe7b686063e2548a8e4afb8f4
> "gpio/omap: don't create an IRQ mapping for every GPIO on DT"
> 
> Does the OMAP1 boot again after this?

Yep, it boots fine with those three patches reverted:

http://www.pwsan.com/omap/testlogs/bisect_5912osk_boot_fail_v3.11-rc3/20130729030748/boot/5912osk/5912osk_log.txt


- Paul
