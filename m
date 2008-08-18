From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: HSMMC pending fixes
Date: Mon, 18 Aug 2008 18:13:14 +0300
Message-ID: <1219072400-7814-1-git-send-email-jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55370 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbYHRPQw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 11:16:52 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7IFGBkW015871
	for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 10:16:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>


Hi alll

Here are some pending patches for Omap HSMMC driver.

=46irst two patches are PM patches by Jouni H=C3=B6grander:

1: Do not try to call board specific suspend / resume functions if ther=
e
   is no such.
2: Disable smartidle mode while suspending (workaround)

Next four patches are cleanups, slot_name, and cover_state sysfs
entries by Francisco Alecrim:

3: Readable output for IRQ status register
4: Re organizing some goto at hsmmc probe
5: Add slot_name entry to sysfs
6: Add sysfs file cover_switch.patch

Cheers
Jarkko Lavinen

 omap_hsmmc.c |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+--------
 1 file changed, 119 insertions(+), 17 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
