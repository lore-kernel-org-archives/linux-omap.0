From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/3] OMAP3: OFF command handling
Date: Thu, 28 Aug 2008 16:24:54 +0300
Message-ID: <1219929894.6269.18.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22255 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbYH1NV5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 09:21:57 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7SDKloI015527
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 08:21:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi,

This patch set will introduce a handling mechanism to send the proper
off commands on WFI instruction. These patches do not directly depend o=
n
Jouni H=C3=B6gander's workarounds or Rajendra Nayak's cpu idle patches,=
 but
will not effectively do anything until those sets are integrated.

So this patch set is a enabler for off mode.

A new sysfs interface is introduced:

echo 1 > /sys/power/voltage_off_while_idle

which enables to use the SYS_OFFMODE signal instead of I2C sleep comman=
d
when both CORE & MPU are going into off mode. If triton2 has been loade=
d
with the proper scripts VDD1 and VDD2 will be lowered to 0 volts.

regards,
Kalle Jokiniemi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
