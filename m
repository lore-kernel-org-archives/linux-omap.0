From: Paul Walmsley <paul@pwsan.com>
Subject: v3.5-rc4 doesn't wake from dynamic idle on 3530ES3 Beagle
Date: Wed, 27 Jun 2012 11:03:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271101220.27496@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55040 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab2F0RDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 13:03:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com


Looks like something broke between v3.5-rc3 and v3.5-rc4 with dynamic 
idle on 3530ES3 Beagle.  37xx EVM doesn't seem to be affected.

Taking a closer look now.


- Paul

echo mem > /sys/power/state
#
echo mem > /sys/power/state
#
cat /debug/pm_debug/count
#
echo 1000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
echo 1000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
echo 1000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
echo 1000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms

(hang)
