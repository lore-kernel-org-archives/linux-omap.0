From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/06] OMAP3 CPUidle patches - supports C0-C5
Date: Tue, 26 Aug 2008 18:33:02 +0530 (IST)
Message-ID: <63857.192.168.10.89.1219755782.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38652 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756010AbYHZNJE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Aug 2008 09:09:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Hi,

This is an updated set of CPUidle patches for OMAP3 with a few more comment
fixes, cleanup, 2.6.27-rc3 migration.
Thanks to Paul Walmsley for the detailed review of these patches.

This patch set supports only C0-C5 cpuidle states.
I would post another set with support for context save/restore and enabling
state C6 optionally using a Kconfig option as discussed earlier.

As always, these apply/work on top of Jouni's latest Workaround set and with
the following sysfs enables.
$ echo 1 > /sys/power/sleep_while_idle
$ echo 1 > /sys/power/clocks_off_while_idle

regards,
Rajendra



