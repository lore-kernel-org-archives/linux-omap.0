From: Illia Smyrnov <illia.smyrnov@ti.com>
Subject: [PATCH v3 0/3] Input: omap-keypad: Wakeup capability and w/a for i689 errata.
Date: Mon, 29 Jul 2013 19:45:08 +0300
Message-ID: <1375116311-13999-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

This patchset adds wake up capability for the keypad and
workaround for i689 errata.

Based on top of v3.11-rc3

Depends on:

Input: omap-keypad: Convert to threaded IRQ
https://patchwork.kernel.org/patch/2832920/

Input: omap-keypad: Cleanup - use bitfiled instead of hardcoded values
https://patchwork.kernel.org/patch/2832913/

Axel Haslam (1):
  Input: omap-keypad: errata i689: Correct debounce time

Illia Smyrnov (2):
  Input: omap-keypad: Enable wakeup capability for keypad.
  Input: omap-keypad: Setup irq type from DT

 drivers/input/keyboard/omap4-keypad.c |   52 ++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

-- 
1.7.9.5

