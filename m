From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 0/2] legacy gpio phaseout (IV) ...
Date: Tue, 25 Nov 2008 16:12:12 +0200
Message-ID: <1227622334-27227-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25791 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYKYONe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 09:13:34 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAPED5rY011879
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 16:13:32 +0200
Received: from localhost.localdomain (esdhcp042162.research.nokia.com [172.21.42.162])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAPECRm6015809
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 16:12:27 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Let's do this gpiolib conversion in smaller steps...

At this time I applied David's four conversion patches for (OMAP and mainline)
on top of mainline. Then I applied my previous set, dropped out the conflicting
files and applied that set on top of linux-omap and did these two commits.

However, some files have huge offsets like -89 lines when applying back to
mainline. But applies anyway.

Have to look what to do for remaining conflicting files.


Jarkko
