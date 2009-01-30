From: Timo Kokkonen <timo.t.kokkonen@nokia.com>
Subject: [PATCH 0/1] Export dmtimer functions
Date: Fri, 30 Jan 2009 11:22:54 +0200
Message-ID: <1233307375-5943-1-git-send-email-timo.t.kokkonen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46253 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZA3JXH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 04:23:07 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0U9MehA004781
	for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 11:23:04 +0200
Received: from localhost.localdomain (ouped117211.nmp.nokia.com [172.23.117.211])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n0U9MuUw006909
	for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 11:22:56 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Currently the dmtimer function symbols are not exported, thus it is
not possible to use any dmtimers from modules. I have a need to access
the timer functions from my module (which will be propably published
at later time). I'm sending this patch for review, code inclusion in
linux-omap tree would be also preferred if there are no objections.

Thanks.

-Timo


