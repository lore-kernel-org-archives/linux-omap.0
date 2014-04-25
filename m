From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv4 03/13] HSI: hsi-char: fix driver for multiport scenarios
Date: Fri, 25 Apr 2014 21:06:06 +0200
Message-ID: <1398452776-28638-4-git-send-email-sre@kernel.org>
References: <1398452776-28638-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398452776-28638-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, =?UTF-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE=20=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Fix return code check of alloc_chrdev_region, which
returns 0 on success.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/hsi/clients/hsi_char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/clients/hsi_char.c b/drivers/hsi/clients/hsi_char.c
index e61e5f9..3073320 100644
--- a/drivers/hsi/clients/hsi_char.c
+++ b/drivers/hsi/clients/hsi_char.c
@@ -705,7 +705,7 @@ static int hsc_probe(struct device *dev)
 	if (!hsc_major) {
 		ret = alloc_chrdev_region(&hsc_dev, hsc_baseminor,
 						HSC_DEVS, devname);
-		if (ret > 0)
+		if (ret == 0)
 			hsc_major = MAJOR(hsc_dev);
 	} else {
 		hsc_dev = MKDEV(hsc_major, hsc_baseminor);
-- 
1.9.2
