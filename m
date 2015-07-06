From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] extcon: fixes for v4.2-rc1
Date: Mon, 6 Jul 2015 17:46:56 +0300
Message-ID: <1436194018-18696-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cw00.choi@samsung.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

First patch fixes kernel hang and incorrect states when
extcon_get/set_cable_state() is used.

Second patch fixes extcon_cable_get_state() users from getting old
state after notifier callback.

cheers,
-roger

Roger Quadros (2):
  extcon: fix hang and extcon_get/set_cable_state().
  extcon: Fix extcon_cable_get_state() from getting old state after
    notification

 drivers/extcon/extcon.c | 50 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 13 deletions(-)

-- 
2.1.4
