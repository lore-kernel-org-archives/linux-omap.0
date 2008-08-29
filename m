From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/1] ARM:OMAP3: Smartreflex disable/enable fix
Date: Fri, 29 Aug 2008 13:05:33 +0300
Message-ID: <1220004333.6269.41.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23365 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbYH2KCV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 06:02:21 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7TA20Pu013542
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 05:02:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Smartreflex is missing disable/enable calls for pm-idle and cpu idle
idle paths. I'm sending the following patch for people to test with. It
moves the disable/enable calls to omap_sram_idle in pm34xx.c. Whis
covers all idle paths.

The problem has been verifying that this actually works. Using the
unstable test values for smartreflex autocompensation, the patch had
instability problems on my ES2.0 sdp board but worked fine on ES2.1
device.

Please give it a try with jouni h=C3=B6gander's workaround patches that
enable retention and SMARTREFLEX_TESTING config flag. Both suspend and
dynamic idle should work without crashes.

echo 1 > /sys/power/clocks_off_while_idle
echo 1 > /sys/power/sr_vdd1_autocomp
echo 1 > /sys/power/sr_vdd2_autocomp

If your device crashes here, the testing values don't fit your device's
real parameters.

echo mem > /sys/power/state

echo 1 > /sys/power/sleep_while_idle

If no problems arise, this patch could be pushed.

regards,=20
Kalle
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
