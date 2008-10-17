From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/4] bq27x00 updates
Date: Sat, 18 Oct 2008 00:00:44 +0300
Message-ID: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53037 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYJQVBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:01:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Felipe Balbi <felipe.balbi@nokia.com>

The previous driver for bq27x00 batteries was a real
ifdef mess. The following patches separate common code
and create separate drivers for bq27200 and bq27000.

The code looks much cleaner, but we had to keep a global
static pointer to hold the i2c_client (bq27200) or the
w1 device (bq27000).

If anyone has a better solution, I'd like to hear since
keeping that global pointer doesn't look nice.

I could only test bq27200 final driver, I don't have
hw for testing bq27000 so I'd like to ask anyone who
has such hw, please test it.

I'd say that after the following patches we can already
send both drivers to mainline since they look quite
fine now. Improvements might come later, but for now, they
look fine.

David and Anton, I'm Ccing you guys for you to take a look
at the drivers before I send the final version (against mainline)
to you for integration. It would be nice if you guys could take
a look at the patches and if something looks wrong we could fix
it and get the drivers in better shape before asking bugging lkml
with such drivers.

Felipe Balbi (4):
  power_supply: bq27x00: separate common code
  power_supply: bq27200: separate bq27200-specific driver
  power_supply: bq27200: separate bq27000-specific driver
  power_supply: bq27x00: get rid of old code

 drivers/power/Kconfig           |   25 +--
 drivers/power/Makefile          |    3 +-
 drivers/power/bq27000.c         |  173 ++++++++++++
 drivers/power/bq27200.c         |  202 ++++++++++++++
 drivers/power/bq27x00.c         |  190 +++++++++++++
 drivers/power/bq27x00.h         |   54 ++++
 drivers/power/bq27x00_battery.c |  564 ---------------------------------------
 7 files changed, 630 insertions(+), 581 deletions(-)
 create mode 100644 drivers/power/bq27000.c
 create mode 100644 drivers/power/bq27200.c
 create mode 100644 drivers/power/bq27x00.c
 create mode 100644 drivers/power/bq27x00.h
 delete mode 100644 drivers/power/bq27x00_battery.c

