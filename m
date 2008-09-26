From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: CPU idle init sequence
Date: Fri, 26 Sep 2008 11:02:58 +0300
Message-ID: <1222416178.23638.9.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16491 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbYIZH5f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 03:57:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, =?ISO-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>

Hi Rajendra,

We found a problem in the sequencing of omap_pm_init and
omap3_idle_init. It seems that cpu idle is initialized before pm. This
can cause omap_sram_idle to be called before the neccessary inits are
done. I'll post a patch that fixes this by moving the omap3_idle_init
call to omap_pm_init. Check it out if it has any problems.

Compile & boot tested the patch on SDP, with and without
CONFIG_CPU_IDLE.

regards,
Kalle
