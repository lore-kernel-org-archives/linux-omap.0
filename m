From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 0/7] 34XX: PM: Workarounds to get omap3 to retention 3rd.
Date: Wed, 25 Jun 2008 12:11:49 +0300
Message-ID: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57978 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbYFYJLy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 05:11:54 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5P9Bjto005602
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 12:11:51 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This patch set contains all workarounds that are needed to get omap3
to retention. Also patch from Tero Kristo to get PM to work if using
serial console is included in this set. Basically all patches in this
set should be reverted one by one as correct fixes are implemented and
applied.

This patch set superseeds earlier version sent 2008-06-17 7:28:35.

To get Omap into retention, this patch set still depends on:
1. ARCH: OMAP: MUSB: Do not block sleep (Felipe Balbi)
2. ARM: OMAP: SmartReflex driver: enable in omap_3430sdp_defconfig (Kal=
le
   Jokiniemi)
3. PRCM: 34XX: Fix wrong shift value used in dpll4_m4x2_ck enable bit
4. Patch which removes control of usbhost_sar_fck from clock tree (Paul
   Walmsley will send this soon)

Test:
1. Apply dependency patches and workaround set on top of them

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
