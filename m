From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 3/5] First set of omap1 related changes
Date: Wed, 29 Feb 2012 21:06:40 +0000
Message-ID: <201202292106.40731.arnd@arndb.de>
References: <0Mfo5g-1RocQt3wlY-00NttP@mx.kundenserver.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57960 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174Ab2B2VGu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 16:06:50 -0500
In-Reply-To: <0Mfo5g-1RocQt3wlY-00NttP@mx.kundenserver.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 29 February 2012, Tony Lindgren wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap1
> 
> Janusz Krzysztofik (7):
>       ARM: OMAP1: ams-delta: register latch dependent devices later
>       ARM: OMAP1: ams-delta: convert latches to basic_mmio_gpio
>       ARM: OMAP1: ams-delta: supersede custom led device by leds-gpio
>       LED: drop leds-ams-delta driver
>       MTD: NAND: ams-delta: use GPIO instead of custom I/O
>       omapfb: lcd_ams_delta: drive control lines over GPIO
>       input: serio: ams-delta: toggle keyboard power over GPIO
> 

Since these are all for ams-delta, I pulled them into next/boards together
with other board specific updates.

Thanks,

	Arnd
