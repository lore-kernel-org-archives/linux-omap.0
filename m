From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping for
 every GPIO on DT"
Date: Mon, 29 Jul 2013 07:52:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53437 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab3G2Hw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 03:52:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: linux-omap@vger.kernel.org, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, khilman@linaro.org


Hi

your commit 0e970cec05635adbe7b686063e2548a8e4afb8f4 ("gpio/omap: don't 
create an IRQ mapping for every GPIO on DT") breaks the boot on the 
OMAP5912 OSK:

http://www.pwsan.com/omap/testlogs/bisect_5912osk_boot_fail_v3.11-rc3/20130729013931/boot/5912osk/5912osk_log.txt

This test included a stripped-down version of your commit 
949eb1a4d29dc75e0b5b16b03747886b52ecf854 ("gpio/omap: fix build error when 
OF_GPIO is not defined."), since 0e970cec also broke the build.

The previous commit ad81f0545ef01ea651886dddac4bef6cec930092 ("Linux 
3.11-rc1") boots cleanly:

http://www.pwsan.com/omap/testlogs/test_v3.11-rc1/20130721020309/boot/5912osk/5912osk_log.txt

OMAP5912 OSK is an OMAP1 platform, and therefore non-DT.

Could you please put together a fix for this?


regards,

- Paul
