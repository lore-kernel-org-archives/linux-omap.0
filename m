From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: [PATCH 0/1] OMAP: McSPI: Unpaired clk_{en,dis}able calls.
Date: Thu, 19 Feb 2009 17:24:01 +0200
Message-ID: <1235057042-6833-1-git-send-email-ext-phil.2.carmody@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64239 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758623AbZBSPZL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 10:25:11 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1JFOh5V018911
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2009 09:25:08 -0600
Received: from localhost.localdomain (esdhcp039196.research.nokia.com [172.21.39.196])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n1JFOGtB026540
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2009 17:24:17 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


It appears that if clk_enable fails for the functional clock, the
interface clock will be left enabled. Any tallying (locks, ref-
counts, whatever) will therefore be out of step between the two 
clocks.
