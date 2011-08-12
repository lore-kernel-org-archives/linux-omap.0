From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: [PATCHv2 2/4] OMAP4: Keyboard: Fix section mismatch in the board file
Date: Fri, 12 Aug 2011 17:27:52 +0200
Message-ID: <CAFULf_x_7GXMRY_rNDFk377R-ZWSOvM5KBqOe0a4cYbzGARnYA@mail.gmail.com>
References: <CAFULf_zAqFGcUfgfOMyrm8DLJhg1qXG+48W5u+pjBUwa=PmrRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35866 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab1HLP1x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 11:27:53 -0400
Received: by mail-vx0-f174.google.com with SMTP id 9so2453955vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Aug 2011 08:27:52 -0700 (PDT)
In-Reply-To: <CAFULf_zAqFGcUfgfOMyrm8DLJhg1qXG+48W5u+pjBUwa=PmrRg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

`keypad_pads' is referred to by `keypad_data' which is
not __initdata, so `keypad_pads' should not be __initdata either.

Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
---
V2: Oops.. Add missing sob.

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
