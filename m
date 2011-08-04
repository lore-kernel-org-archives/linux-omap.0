From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: [PATCH 2/4] OMAP4: Keyboard: Fix section mismatch in the board file
Date: Thu, 4 Aug 2011 20:02:09 +0200
Message-ID: <CAFULf_zAqFGcUfgfOMyrm8DLJhg1qXG+48W5u+pjBUwa=PmrRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62169 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1HDSCK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 14:02:10 -0400
Received: by vxi9 with SMTP id 9so389804vxi.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 11:02:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

`keypad_pads' is referred to by `keypad_data' which is
not __initdata, so `keypad_pads' should not be __initdata either.
---
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c
b/arch/arm/mach-omap2/board-4430sdp.c
index c7cef44..9e423ac 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -129,7 +129,7 @@ static const int sdp4430_keymap[] = {
 	KEY(7, 6, KEY_OK),
 	KEY(7, 7, KEY_DOWN),
 };
-static struct omap_device_pad keypad_pads[] __initdata = {
+static struct omap_device_pad keypad_pads[] = {
 	{	.name   = "kpd_col1.kpd_col1",
 		.enable = OMAP_WAKEUP_EN | OMAP_MUX_MODE1,
 	},
-- 
1.7.1
