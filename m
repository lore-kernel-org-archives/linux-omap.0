From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [RFC 10/23] Input: omap-keypad - raw read and write endian fix
Date: Sat, 16 Nov 2013 02:01:13 +0200
Message-ID: <1384560086-11994-11-git-send-email-taras.kondratiuk@linaro.org>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35087 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab3KPABo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Nov 2013 19:01:44 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so1377729eek.33
        for <linux-omap@vger.kernel.org>; Fri, 15 Nov 2013 16:01:43 -0800 (PST)
In-Reply-To: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linaro-networking@linaro.org, Victor Kamensky <victor.kamensky@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Victor Kamensky <victor.kamensky@linaro.org>

All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
Need to use endian neutral functions to read/write h/w registers.
I.e instead of __raw_read[lw] and __raw_write[lw] functions code
need to use read[lw]_relaxed and write[lw]_relaxed functions.
If the first simply reads/writes register, the second will byteswap
it if host operates in BE mode.

Changes are trivial sed like replacement of __raw_xxx functions
with xxx_relaxed variant.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 drivers/input/keyboard/omap4-keypad.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 30acfd4..952a2eb 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -89,26 +89,26 @@ struct omap4_keypad {
 
 static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
 {
-	return __raw_readl(keypad_data->base +
+	return readl_relaxed(keypad_data->base +
 				keypad_data->reg_offset + offset);
 }
 
 static void kbd_writel(struct omap4_keypad *keypad_data, u32 offset, u32 value)
 {
-	__raw_writel(value,
+	writel_relaxed(value,
 		     keypad_data->base + keypad_data->reg_offset + offset);
 }
 
 static int kbd_read_irqreg(struct omap4_keypad *keypad_data, u32 offset)
 {
-	return __raw_readl(keypad_data->base +
+	return readl_relaxed(keypad_data->base +
 				keypad_data->irqreg_offset + offset);
 }
 
 static void kbd_write_irqreg(struct omap4_keypad *keypad_data,
 			     u32 offset, u32 value)
 {
-	__raw_writel(value,
+	writel_relaxed(value,
 		     keypad_data->base + keypad_data->irqreg_offset + offset);
 }
 
@@ -312,7 +312,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
 		goto err_unmap;
 	}
-	rev = __raw_readl(keypad_data->base + OMAP4_KBD_REVISION);
+	rev = readl_relaxed(keypad_data->base + OMAP4_KBD_REVISION);
 	rev &= 0x03 << 30;
 	rev >>= 30;
 	switch (rev) {
-- 
1.7.9.5

