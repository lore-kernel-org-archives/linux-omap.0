From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC] Add support for am33xx which has two musb ports
Date: Mon, 17 Jun 2013 17:13:32 +0200
Message-ID: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39752 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab3FQPNi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 11:13:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi Felipe,

so with these two I can use the second port on my am335x-evm in hostmode.
After the second ports gets noticed by Linux I see over and over:
|musb_bus_suspend 2457: trying to suspend as a_wait_bcon while active

Which disappears once I plug in a device and does not come back after I
unplug it.

Port 0 in device seems to run as well. On the first time i see

| CAUTION: musb: Babble Interrupt Occurred
| g_ncm gadget: high-speed config #1: CDC Ethernet (NCM)

and on the second time I plug it in there is no such babble error. Maybe
there is some kind of init missing here.
Any comments?

Sebastian

