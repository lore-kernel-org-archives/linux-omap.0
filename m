From: =?utf-8?q?tapio=20laxstr=C3=B6m?= <ext-tapio.laxstroem@nokia.com>
Subject: [PATCH 0/1] Fix n800 dummy audio init function declaration
Date: Fri,  4 Apr 2008 13:59:35 +0300
Message-ID: <1207306776-19509-1-git-send-email-ext-tapio.laxstroem@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kusti.hard.ware.fi ([194.111.136.51]:36328 "EHLO
	kusti.hard.ware.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbYDDLK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 07:10:26 -0400
Received: from localhost (localhost.hard.ware.fi [127.0.0.1])
	by kusti.hard.ware.fi (Postfix) with ESMTP id 1559D60486
	for <linux-omap@vger.kernel.org>; Fri,  4 Apr 2008 14:01:21 +0300 (EEST)
Received: from pwmailex01.almare2.tre (osmium.hard.ware.fi [10.31.32.25])
	by kusti.hard.ware.fi (Postfix) with ESMTP id 9A36460488
	for <linux-omap@vger.kernel.org>; Fri,  4 Apr 2008 14:01:18 +0300 (EEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This dummy init function is only used when kernel is compiled without audio support.


