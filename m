From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv3 0/5] Misc fixes [for PM branch]
Date: Thu, 12 Nov 2009 12:07:19 +0200
Message-ID: <1258020444-3809-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60109 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbZKLKZC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 05:25:02 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nACAOwrg019620
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 04:25:07 -0600
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nACAOXWq012786
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 12:24:34 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This set contains following changes compared to previous one:

1) Removed accepted patches
2) ARM aux ctrl and L2 aux ctrl register save/restore uses now arm_context
   as save area
3) Added more detail to I2C4 repeated start disable fix description
4) Refreshed patches against PM branch


