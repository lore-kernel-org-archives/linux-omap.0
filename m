From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv4 0/8] Idle status patches revisited
Date: Fri, 22 Jan 2010 19:55:43 +0200
Message-ID: <1264182951-9205-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58798 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab0AVQFP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 11:05:15 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o0MG59Eg028820
	for <linux-omap@vger.kernel.org>; Fri, 22 Jan 2010 18:05:12 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o0MG51XI002591
	for <linux-omap@vger.kernel.org>; Fri, 22 Jan 2010 18:05:02 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Following changes done after previous version:

- Added patch 0001:
  * This adds support for checking if HWSUP is enabled on clkdm
  * Powerdomain code uses this check so it can restore correct mode after
    fiddling with the deny_idle / allow_idle mechanism
- Added patch 0006:
  * Just adds bit definition for SGX idle status bit (currently missing)
- Patch 2 (old patch #1):
  * Fixed allow / deny idle logic so that it does not override possible
    SWSUP setting on clockdomain (uses support patch #1)
  * Removed mem_onst hacks that added incorrect INACTIVE state support
    for memories associated with powerdomains
- Patch 3 (old patch #2):
  * Changed the code inside set_pwrdm_state() to cope with the change to
    deny_idle / allow_idle mechanism done in patch #2
- Patch 7 (old patch #5):
  * Improved the readability of the idle / fclk check code
  * Changed all magic numbers in the idlest_mask / fclk_ignores to macro defs
  * Changed some names of variables


