From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [RFC][PATCH 0/2] OMAP: PM: Fix boot with SMARTREFLEX and PM_NOOP/PM_NONE
Date: Tue, 28 Apr 2009 12:37:45 +0300
Message-ID: <1240911467-12269-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29349 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbZD1Jih (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 05:38:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, ext-roger.quadros@nokia.com

Hi,

This series fixes booting on RX51 when OMAP_SMARTREFLEX is enabled along with
OMAP_PM_NOOP or OMAP_PM_NONE

Patches apply on top of pm branch of Kevin's pm tree
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

regards,
-roger


