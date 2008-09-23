From: Timo-Pekka Launonen <ext-timo-pekka.launonen@nokia.com>
Subject: Power management tester
Date: Tue, 23 Sep 2008 12:15:54 +0300
Message-ID: <1222161355.28340.14.camel@vemppakone.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63175 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbYIWJQc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 05:16:32 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8N9GFbw031289
	for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2008 12:16:29 +0300
Received: from [172.22.146.207] (trdhcp146207.ntc.nokia.com [172.22.146.207])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8N9Ft2f013368
	for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2008 12:15:55 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

there is a new project in garage.maemo.org called Power management
tester. It is used to test that kernel and kernel modules implements
working power management functionality. PM-tester loads kernel modules
one by one and tests that they don't prevent suspend or dynamic sleep.
It also verifies that all power domains are in correct state. Project
pages could be found from https://garage.maemo.org/projects/pm-test/ and
short wiki documentation from
https://garage.maemo.org/plugins/wiki/index.php?id=778&type=g .

To use PM-tester kernel needs to have working power management support.
Linux-omap tree has pm-0 branch which could be used. You need to enable
power management support by setting CONFIG_PM=y and suspend
CONFIG_SUSPEND=y. PM-tester also needs to have PM debug and debug fs
enabled, CONFIG_PM_DEBUG=y and CONFIG_DEBUG_FS=y.

Prebuilt armel deb package can be downloaded from
https://garage.maemo.org/frs/?group_id=778

Regards,
Timo Launonen


