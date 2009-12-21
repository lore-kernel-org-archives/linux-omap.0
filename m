From: Alexander Shishkin <virtuoso@slind.org>
Subject: [PATCH v2 0/2] omap i2c interrupt handler fixes
Date: Mon, 21 Dec 2009 13:29:57 +0200
Message-ID: <1261394999-20857-1-git-send-email-virtuoso@slind.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27621 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbZLULbm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 06:31:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: nm@ti.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

Hi,

This is the second version of the patchset, now addressing comments
from Nishanth and changing the retry counter into a real timeout.

Regards,
--
Alex
