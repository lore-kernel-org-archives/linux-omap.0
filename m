From: Peter Barada <peter.barada@gmail.com>
Subject: Where did the twl4030 battery charging code go?
Date: Tue, 30 Mar 2010 11:59:30 -0400
Message-ID: <738b3f7e1003300859t633ace94h5945e9974109e176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.211.172]:61271 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0C3P7c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 11:59:32 -0400
Received: by ywh2 with SMTP id 2so5783878ywh.33
        for <linux-omap@vger.kernel.org>; Tue, 30 Mar 2010 08:59:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm looking in linux-2.6.33-rc3 to turn on the battery backup charger
to get the RTC working on a Logic SOM, and I don't see
drivers/mfd/twl4030_bci_battery.c anymore.

Digging through Tony's trees I find it was removed way back at::

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=b122a4b8a18ebbb0b5de90baeb54650a53cd9d7d

Did this code resurface anywhere in the new kernels?
