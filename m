From: Tero Kristo <tero.kristo@nokia.com>
Subject: OMAP3 CPU revision fix
Date: Tue, 16 Sep 2008 16:46:36 +0300
Message-ID: <1221572797-15949-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24195 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbYIPL5o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 07:57:44 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8GBvK7f010198
	for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 14:57:42 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8GBv7i7007031
	for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 14:57:07 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

OMAP3 CPU revision check is still a bit broken. Following patch fixes this.
Also added a small performance optimization to the omap_type() check, type
is only read once from the hardware now.
Tested with two chip revisions: ES2.1GP and ES3.0EMU.


