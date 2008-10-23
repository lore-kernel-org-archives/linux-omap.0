From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] omap-keypad fixes for OMAP2
Date: Thu, 23 Oct 2008 08:51:30 +0300
Message-ID: <1224741092-21577-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,
The following two patches provides fixes for the omap-keypad
driver on OMAP2.

Peter Ujfalusi (2)
  OMAP2: omap-keypad: interrupt disable fix
  OMAP2: omap-keypad: Enable more than 6 rows

 drivers/input/keyboard/omap-keypad.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)



