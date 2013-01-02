From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 22/22] mdf: omap-usb-host: get rid of build warning
Date: Wed, 2 Jan 2013 17:00:42 +0200
Message-ID: <1357138842-28964-23-git-send-email-rogerq@ti.com>
References: <1357138842-28964-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56855 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058Ab3ABPB5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jan 2013 10:01:57 -0500
In-Reply-To: <1357138842-28964-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, sameo@linux.intel.com, tony@atomide.com
Cc: keshava_mgowda@ti.com, sshtylyov@mvista.com, bjorn@mork.no, rogerq@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

=46ixes the below build warning when driver is built-in.

drivers/mfd/omap-usb-host.c:750:12: warning:
=E2=80=98usbhs_omap_remove=E2=80=99 defined but not used [-Wunused-func=
tion]

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index bf2a06a..ecdafbd 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -782,7 +782,7 @@ static struct platform_driver usbhs_omap_driver =3D=
 {
 		.owner		=3D THIS_MODULE,
 		.pm		=3D &usbhsomap_dev_pm_ops,
 	},
-	.remove		=3D __exit_p(usbhs_omap_remove),
+	.remove		=3D usbhs_omap_remove,
 };
=20
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
