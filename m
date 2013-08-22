From: "Smyrnov, Illia" <illia.smyrnov@ti.com>
Subject: RE: [PATCH v3 0/3] Input: omap-keypad: Convert to threaded IRQ and
 cleanup
Date: Thu, 22 Aug 2013 11:34:04 +0000
Message-ID: <6F887CA5EE8CA64BB614602A7379818F60A26D@DNCE04.ent.ti.com>
References: <1374681293-5320-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374681293-5320-1-git-send-email-illia.smyrnov@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Dmitry,

should I take any additional action regarding these patches?

Best regards,
Illia Smyrnov


________________________________________
From: linux-kernel-owner@vger.kernel.org [linux-kernel-owner@vger.kernel.org] on behalf of Smyrnov, Illia
Sent: Wednesday, July 24, 2013 6:54 PM
To: Dmitry Torokhov
Cc: Balbi, Felipe; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; linux-omap@vger.kernel.org
Subject: [PATCH v3 0/3] Input: omap-keypad: Convert to threaded IRQ and cleanup

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

