From: Paul Walmsley <paul@pwsan.com>
Subject: Broken UART I/O wakeups on v3.4-rc4+
Date: Mon, 7 May 2012 23:05:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205072249090.9984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42511 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab2EHFFH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 01:05:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: govindraj.raja@ti.com
Cc: tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org


Govindraj,

After your commit bce492c04ba8fc66a4ea0a52b181ba255daaaf54 ("ARM: OMAP2+: 
UART: Fix incorrect population of default uart pads"), the kernel does not 
return from static suspend when off-mode is enabled upon an incoming 
serial character.

The following steps reproduce the problem:

echo 1 > /debug/pm_debug/enable_off_mode
echo mem > /sys/power/state
(send a serial character after suspend is entered)

(N.B., on the BeagleBoard, the GPIO-connected "USER" button can be used to 
wake the system at this point.)

Could you please fix this?  We probably aren't too far from the v3.5 merge 
window opening, so there isn't much time to fix it.


thanks

- Paul
