Return-Path: <SRS0=ohbF=4Q=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5420DC3F2D2
	for <linux-omap@archiver.kernel.org>; Fri, 28 Feb 2020 18:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373432469F
	for <linux-omap@archiver.kernel.org>; Fri, 28 Feb 2020 18:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgB1SCr (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:02:47 -0500
Received: from muru.com ([72.249.23.125]:58278 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1SCr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 28 Feb 2020 13:02:47 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5C966806C;
        Fri, 28 Feb 2020 18:03:31 +0000 (UTC)
Date:   Fri, 28 Feb 2020 10:02:43 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>, ruleh <ruleh@gmx.de>
Subject: [PATCHv2 4/3] Input: omap4-keypad - scan the keys in two phases to
 detect lost key-up
Message-ID: <20200228180243.GM37466@atomide.com>
References: <20200228171223.11444-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228171223.11444-1-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

In addition to handling errata i689 for idle with state, we must also
check for lost key up interrupts on fast key presses.

For example rapidly pressing shift-shift-j can sometimes produce a J
instead of j. Let's fix the issue by scanning the keyboard in two
phases. First we scan for any key up events that we may have missed,
and then we scan for key down events.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/input/keyboard/omap4-keypad.c | 48 ++++++++++++++++++---------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -109,6 +109,34 @@ static void kbd_write_irqreg(struct omap4_keypad *keypad_data,
 		     keypad_data->base + keypad_data->irqreg_offset + offset);
 }
 
+static void omap4_keypad_scan_state(struct omap4_keypad *keypad_data,
+				    unsigned char *key_state,
+				    bool down)
+{
+	struct input_dev *input_dev = keypad_data->input;
+	unsigned int col, row, code, changed;
+	bool key_down;
+
+	for (row = 0; row < keypad_data->rows; row++) {
+		changed = key_state[row] ^ keypad_data->key_state[row];
+		if (!changed)
+			continue;
+
+		for (col = 0; col < keypad_data->cols; col++) {
+			if (changed & (1 << col)) {
+				code = MATRIX_SCAN_CODE(row, col,
+						keypad_data->row_shift);
+				key_down = key_state[row] & (1 << col);
+				if (key_down != down)
+					continue;
+				input_event(input_dev, EV_MSC, MSC_SCAN, code);
+				input_report_key(input_dev,
+						 keypad_data->keymap[code],
+						 key_down);
+			}
+		}
+	}
+}
 
 /* Interrupt handlers */
 static irqreturn_t omap4_keypad_irq_handler(int irq, void *dev_id)
@@ -125,7 +153,6 @@ static bool omap4_keypad_scan_keys(struct omap4_keypad *keypad_data, bool clear)
 {
 	struct input_dev *input_dev = keypad_data->input;
 	unsigned char key_state[ARRAY_SIZE(keypad_data->key_state)];
-	unsigned int col, row, code, changed;
 	u32 *rows_lo = (u32 *)key_state;
 	u32 *rows_hi = rows_lo + 1;
 
@@ -138,22 +165,11 @@ static bool omap4_keypad_scan_keys(struct omap4_keypad *keypad_data, bool clear)
 		*rows_hi = kbd_readl(keypad_data, OMAP4_KBD_FULLCODE63_32);
 	}
 
-	for (row = 0; row < keypad_data->rows; row++) {
-		changed = key_state[row] ^ keypad_data->key_state[row];
-		if (!changed)
-			continue;
+	/* Scan for key up evetns for lost key-up interrupts */
+	omap4_keypad_scan_state(keypad_data, key_state, false);
 
-		for (col = 0; col < keypad_data->cols; col++) {
-			if (changed & (1 << col)) {
-				code = MATRIX_SCAN_CODE(row, col,
-						keypad_data->row_shift);
-				input_event(input_dev, EV_MSC, MSC_SCAN, code);
-				input_report_key(input_dev,
-						 keypad_data->keymap[code],
-						 key_state[row] & (1 << col));
-			}
-		}
-	}
+	/* Scan for key down events */
+	omap4_keypad_scan_state(keypad_data, key_state, true);
 
 	input_sync(input_dev);
 
-- 
2.25.1
