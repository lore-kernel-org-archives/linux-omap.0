From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] extcon: Fix kernel hang for find_cable_index_by_name() users
Date: Mon, 6 Jul 2015 15:31:29 +0300
Message-ID: <1436185889-773-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cw00.choi@samsung.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

Users of find_cable_index_by_name() will cause a kernel hang
as the while loop counter is never incremented and end condition
is never reached.

Fixes: commit 73b6ecdb93e8 ("extcon: Redefine the unique id of supported external connectors without 'enum extcon' type")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/extcon/extcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 76157ab..1acc830 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -138,6 +138,8 @@ static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
 			id = i;
 			break;
 		}
+
+		i++;
 	}
 
 	if (id == EXTCON_NONE)
-- 
2.1.4
