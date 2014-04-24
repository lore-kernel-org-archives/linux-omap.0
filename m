From: yegorslists@googlemail.com
Subject: omap-serial: use mctrl_gpio helpers
Date: Thu, 24 Apr 2014 11:24:30 +0200
Message-ID: <1398331471-16745-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:51956 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755021AbaDXJYz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 05:24:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org

This patch is based on Richard Genoud' patch adding generic GPIO support [1]
and my patch adding get_direction() functionality to OMAP's GPIO driver [2].

So far RTS/DTR are working both as modem control outputs and RTS as RS-485 2-wire controller.

CTS/DSR/DSR/RI are generating interrupts.

Richard, Greg, what is the status of [1]? It seems like it will be available in 3.16 first?

TODO:

1. remove rts_gpio from uart_omap_port
2. perhaps add rts_gpiod to uart_omap_port to avoid numerous invocations of

rts_gpiod = mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS);
3. add device tree documentation 

Yegor

[1] http://comments.gmane.org/gmane.linux.serial/13967
[2] http://www.spinics.net/lists/arm-kernel/msg325162.html

