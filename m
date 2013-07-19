From: Illia Smyrnov <illia.smyrnov@globallogic.com>
Subject: [PATCH 0/2] Input: omap-keypad: Cleanup - remove hardcoded values and IRQ enabling/disabling
Date: Fri, 19 Jul 2013 16:03:45 +0300
Message-ID: <1374239027-3927-1-git-send-email-illia.smyrnov@globallogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Illia Smyrnov <illia.smyrnov@ti.com>

Replace unclear hardcoded values with bit field and remove 
unnecessary IRQ enabling/disabling.

Based on top of v3.10-rc1.

Tested on OMAP4 SDP.

Illia Smyrnov (2):
  Input: omap-keypad: Cleanup - use bitfiled instead of hardcoded
    values
  Input: omap-keypad: Cleanup - remove unnecessary IRQ
    enabling/disabling

 drivers/input/keyboard/omap4-keypad.c |   40 ++++++++++++--------------------
 1 files changed, 15 insertions(+), 25 deletions(-)

