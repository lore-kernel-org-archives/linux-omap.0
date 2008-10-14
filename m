From: Tero Kristo <tero.kristo@nokia.com>
Subject: PM: OMAP3 HS/EMU off-mode support
Date: Tue, 14 Oct 2008 15:23:25 +0300
Message-ID: <1223987011-25667-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54177 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYJNKiH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 06:38:07 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9EAbgN8014252
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:38:02 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9EAbjLs000373
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:37:46 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patchset provides off-mode support for OMAP3 HS/EMU devices. Due to
secure environment in these devices, wake-up from off-mode is slightly
different than in GP devices. This code has been tested on following chip
versions: ES2.1GP, ES3.0EMU, ES3.0HS.


