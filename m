From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 02/33] mfd: omap-usb-host: use match_string() helper
Date: Mon, 21 May 2018 19:57:39 +0800
Message-ID: <1526903890-35761-3-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Yisheng Xie <xieyisheng1@huawei.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/mfd/omap-usb-host.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 7aab376..e11ab12 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -153,27 +153,6 @@ static inline u32 usbhs_read(void __iomem *base, u32 reg)
 	[OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM]	= "ohci-tll-2pin-dpdm",
 };
 
-/**
- * omap_usbhs_get_dt_port_mode - Get the 'enum usbhs_omap_port_mode'
- * from the port mode string.
- * @mode: The port mode string, usually obtained from device tree.
- *
- * The function returns the 'enum usbhs_omap_port_mode' that matches the
- * provided port mode string as per the port_modes table.
- * If no match is found it returns -ENODEV
- */
-static int omap_usbhs_get_dt_port_mode(const char *mode)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(port_modes); i++) {
-		if (!strcmp(mode, port_modes[i]))
-			return i;
-	}
-
-	return -ENODEV;
-}
-
 static struct platform_device *omap_usbhs_alloc_child(const char *name,
 			struct resource	*res, int num_resources, void *pdata,
 			size_t pdata_size, struct device *dev)
@@ -529,7 +508,8 @@ static int usbhs_omap_get_dt_pdata(struct device *dev,
 		if (ret < 0)
 			continue;
 
-		ret = omap_usbhs_get_dt_port_mode(mode);
+		/* get 'enum usbhs_omap_port_mode' from port mode string */
+		ret = match_string(port_modes, ARRAY_SIZE(port_modes), mode);
 		if (ret < 0) {
 			dev_warn(dev, "Invalid port%d-mode \"%s\" in device tree\n",
 					i, mode);
-- 
1.7.12.4
