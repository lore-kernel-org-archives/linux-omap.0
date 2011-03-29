From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH v3 0/2] isp1704_charger: fix powering for N900
Date: Tue, 29 Mar 2011 16:27:58 +0300
Message-ID: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:51008 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab1C2N3N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 09:29:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, cbouatmailru@gmail.com
Cc: balbi@ti.com, heikki.krogerus@nokia.com, sshtylyov@mvista.com, tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, jhnikula@gmail.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

This patch set enables powering down the isp1704 usb
tranceiver when not in use.

tested on RX-51 and MeeGo.

Thanks to Felipe Balbi, Sergei Shtylyov, and Heikki Krogerus
for comments.

v3:
* fixed power down handling in isp1704_charger_probe
* removed init_done variable
* changed BUG_ON to WARN_ON
* editorial fixes 

v2: fixed boot issue in the 1/2 patch.

Kalle Jokiniemi (2):
  isp1704_charger: allow board specific powering routine
  RX-51: Enable isp1704 power on/off

 arch/arm/mach-omap2/board-rx51-peripherals.c |   27 ++++++++++++++++++++++-
 drivers/power/isp1704_charger.c              |   22 +++++++++++++++++++
 include/linux/power/isp1704_charger.h        |   29 ++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/power/isp1704_charger.h

