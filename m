From: Illia Smyrnov <illia.smyrnov@ti.com>
Subject: [PATCH 0/3] Input: omap-keypad: Wakeup capability and w/a for i689 errata.
Date: Fri, 26 Jul 2013 19:29:58 +0300
Message-ID: <1374856201-11507-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patchset adds wake up capability for the keypad and
workaround for i689 errata.

Based on top of v3.11-rc2

Depends on:

Input: omap-keypad: Convert to threaded IRQ
https://patchwork.kernel.org/patch/2832920/

Input: omap-keypad: Cleanup - use bitfiled instead of hardcoded values
https://patchwork.kernel.org/patch/2832913/

Axel Haslam (2):
  Input: omap-keypad: errata i689: Correct debounce time
  Input: omap-keypad: Set irq to level instead of edge

Illia Smyrnov (1):
  Input: omap-keypad: Enable wakeup capability for keypad.

 drivers/input/keyboard/omap4-keypad.c |   50 +++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

-- 
1.7.9.5
