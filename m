From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 3/5] ARM: OMAP2: MUSB: Specify omap4 has mailbox
Date: Wed, 6 Feb 2013 18:58:49 +0530
Message-ID: <1360157331-9048-4-git-send-email-kishon@ti.com>
References: <1360157331-9048-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360157331-9048-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, tony@atomide.com, linux@arm.linux.org.uk, eballetbo@gmail.com, javier@dowhile0.org, b-cousson@ti.com, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc: kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Added has_mailbox to the musb platform data to specify that omap uses
an external mailbox (in control module) to communicate with the musb
core during device connect and disconnect.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-musb.c |    3 +++
 include/linux/usb/musb.h       |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 7b33b37..9d27e3f 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -85,6 +85,9 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
+	if (cpu_is_omap44xx())
+		musb_plat.has_mailbox = true;
+
 	if (soc_is_am35xx()) {
 		oh_name = "am35x_otg_hs";
 		name = "musb-am35x";
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index eb50525..053c268 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -99,6 +99,8 @@ struct musb_hdrc_platform_data {
 	/* MUSB_HOST, MUSB_PERIPHERAL, or MUSB_OTG */
 	u8		mode;
 
+	u8		has_mailbox:1;
+
 	/* for clk_get() */
 	const char	*clock;
 
-- 
1.7.10.4
