From: Illia Smyrnov <illia.smyrnov@ti.com>
Subject: [PATCH v3 0/3] Input: omap-keypad: Convert to threaded IRQ and cleanup
Date: Wed, 24 Jul 2013 18:54:50 +0300
Message-ID: <1374681293-5320-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Replace unclear hardcoded values with bit field, convert to threaded IRQ and
clear interrupts when open the keypad.

Based on top of v3.11-rc2.

Tested on OMAP4 SDP.

Illia Smyrnov (3):
  Input: omap-keypad: Cleanup - use bitfiled instead of hardcoded
    values
  Input: omap-keypad: Convert to threaded IRQ
  Input: omap-keypad: Clear interrupts on open

 drivers/input/keyboard/omap4-keypad.c |   57 +++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 24 deletions(-)
