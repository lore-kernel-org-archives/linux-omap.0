From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: wl1271: communication fails with kernel 3.4-rc2 and firmware series
 4
Date: Thu, 12 Apr 2012 14:34:48 +0200
Message-ID: <4F86CBE8.7010309@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:37851 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757566Ab2DLMfH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 08:35:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, mporter@ti.com

I have a problem with WLAN driver wl12xx and 3.4-rc2. I made tests both on AM3517 + W7310 and Pandaboard. Both have wl1271 chip inside. Previous kernels 2.6.37 and 3.3-rc7 made no problem: I could associate with my AP and then reach every host in my LAN. With 3.4-rc2 I can only associate, but IP pings can't be received/sent.

This is my discussion on linux-wireless mailing list:
http://thread.gmane.org/gmane.linux.kernel.wireless.general/88659

Am I missing some important patches? Can someone try and confirm my observations?

Thanks,
Yegor
