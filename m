From: Tero Kristo <tero.kristo@nokia.com>
Subject: OMAP3: DVFS core patch set
Date: Thu, 11 Dec 2008 17:52:19 +0200
Message-ID: <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53960 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191AbYLKP7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:15 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBBFxC95006134
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 09:59:13 -0600
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mBBFwchf011022
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 17:58:38 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch set provides DVFS support for OMAP3. First 16 patches contain
clock framework modifications from Paul Walmsley, which are needed for VDD2
OPP clock control to work properly. Rest of the patches are misc fixes for
DVFS control, providing locking interface for OPPs and providing support
for DPLL3 M2 rates higher than 2.


