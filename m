From: <herman516@totalbb.net.tw>
Subject: About 1-Wire driver of OMAP4
Date: Mon, 10 Dec 2012 09:54:40 +0800
Message-ID: <04b23e3459eb3657ab313de044c95c22@127.0.0.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.totalbb.net.tw ([203.187.14.133]:15219 "EHLO
	smtp1.totalbb.net.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab2LJCFF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 21:05:05 -0500
Received: from webmail.totalbb.net.tw (smtp3 [203.187.14.132])
	by smtp1.totalbb.net.tw (Postfix) with ESMTP id 592CB6D02A
	for <linux-omap@vger.kernel.org>; Mon, 10 Dec 2012 09:54:40 +0800 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I implemented gas gauge driver by 1-Wire interface in OMAP4 CPU, the
driver we used is a GPIO pin to simulate 1-Wire bus but it sometimes can't
work well of timing issue. So we want to use HDQ/1Wire controller in OMAP4,
does anyone have experience of OMAP4 1-Wire driver of using its controller?
Our gas gauge is DS2780 and we use "android-omap-3.0" kernel branch. I
tried to do below steps but it still can't work. Or do you have any
suggestion? Thanks.

1. Add hwmod of hdq1w in omap_hwmod_44xx_data.c file
2. Use omap_hdq.c file
3. Select "CONFIG_HDQ_MASTER_OMAP", "CONFIG_W1", "CONFIG_HDQ_MASTER_OMAP"
and "CONFIG_BATTERY_DS2780" in menuconfig.


Regards,
Herman
