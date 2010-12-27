From: shubhrajyoti@ti.com
Subject: [PATCH 0/3]OMAP4: Keypad support
Date: Mon, 27 Dec 2010 11:21:43 +0530
Message-ID: <1293429106-16543-1-git-send-email-shubhrajyoti@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Shubhrajyoti D <a0393217@india.ti.com>
List-Id: linux-omap@vger.kernel.org

From: Shubhrajyoti D <a0393217@india.ti.com>

Adding the keypad 4430sdp board support and PM runtime change.
Tested on 4430sdp.

Abraham Arce (1):
  OMAP4:keypad: PM runtime

Benoit Cousson (1):
  OMAP4: hwmod data: Add keypad in the hwmod database

Syed Rafiuddin (1):
  OMAP4: keypad: Add the board support.

 arch/arm/mach-omap2/board-4430sdp.c        |   89 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c              |   41 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   70 ++++++++++++++++++++++
 drivers/input/keyboard/omap4-keypad.c      |    8 +++
 4 files changed, 208 insertions(+), 0 deletions(-)

