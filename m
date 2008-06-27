From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: gpio bug for 34xx
Date: Fri, 27 Jun 2008 17:48:14 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BB6EABF@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60491 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858AbYF0WsV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2008 18:48:21 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

Hi,

I was just debugging some hang and noticed that the WAKEUPEN bits of gpio banks was cleared out unexpectedly when doing a post mordem.

The array in 1466 will almost be certainly wrong on an OMAP3.  It's probably a bit off for OMAP2 for that matter.  Things which are not wake up capable from RET or OFF still can wake you up from a domain in INACTIVE mode.


1464 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
1465                 if (bank->method == METHOD_GPIO_24XX) {
1466                         static const u32 non_wakeup_gpios[] = {
1467                                 0xe203ffc0, 0x08700040

Regards,
Richard W.
