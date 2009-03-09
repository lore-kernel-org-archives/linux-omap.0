From: ext-eero.nurkkala@nokia.com
Subject: [PATCH 0/2] OMAP: McBSP: Minor issues
Date: Mon,  9 Mar 2009 09:05:10 +0200
Message-ID: <12365823123402-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23176 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbZCIHI2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 03:08:28 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2978Kfs031991
	for <linux-omap@vger.kernel.org>; Mon, 9 Mar 2009 09:08:22 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

This patchset fixes a few minor issues:
- Keep McBSP fclk active when McBSP is active
- Enable/disable clocks at the proper location

