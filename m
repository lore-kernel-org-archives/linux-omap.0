From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: [PATCH 0/6] 34XX: PM: Workarounds to get omap3 to retention 4th.
Date: Mon, 30 Jun 2008 11:50:39 +0300
Message-ID: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62064 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbYF3Iuv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 04:50:51 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5U8o49b012735
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 03:50:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This patch set contains all workarounds that are needed to get omap3
to retention. Also patch from Tero Kristo to get PM to work if using
serial console is included in this set. Basically all patches in this
set should be reverted one by one as correct fixes are implemented and
applied.

This patch set superseeds earlier version sent 2008-06-25 9:11:49.

To get Omap into retention, this patch set still depends on:
1. ARCH: OMAP: MUSB: Do not block sleep (Felipe Balbi)

Test:
1. Apply dependency patch and workaround set on top of them

2. Enable disabling/enabling of gpio2-6 and uart clocks on idle:
   $ echo 1 > /sys/power/clocks_off_while_idle

3. Try out static suspend:
   $ echo mem > /sys/power/state
   Wake up from suspend by entering character to serial console. This
   should print out:
   "Successfully put all powerdomains to target state"

4. Try out dynamic sleep:
   $ echo 1 > /sys/power/sleep_while_idle
   On Omap3430 SDP board VCORE_EN led can be used as an indicator. If
   it starts to blink after a while then Omap enters retention on
   idle. To make this work also display needs to be blanked.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
