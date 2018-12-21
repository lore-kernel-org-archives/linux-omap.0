From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 09/14] media: wl128x-radio: load firmware from ti-connectivity/
Date: Fri, 21 Dec 2018 02:17:47 +0100
Message-ID: <20181221011752.25627-10-sre@kernel.org>
References: <20181221011752.25627-1-sre@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221011752.25627-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

All TI WiLink firmware files are loaded from the ti-connectivity
subdirectory, so let's also move the FM firmware.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index 3f189d093eeb..d584ca970556 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -1347,7 +1347,7 @@ static int fm_power_up(struct fmdev *fmdev, u8 mode)
 	fmdbg("ASIC ID: 0x%x , ASIC Version: %d\n",
 		be16_to_cpu(asic_id), be16_to_cpu(asic_ver));
 
-	sprintf(fw_name, "%s_%x.%d.bts", FM_FMC_FW_FILE_START,
+	sprintf(fw_name, "ti-connectivity/%s_%x.%d.bts", FM_FMC_FW_FILE_START,
 		be16_to_cpu(asic_id), be16_to_cpu(asic_ver));
 
 	ret = fm_download_firmware(fmdev, fw_name);
@@ -1355,7 +1355,7 @@ static int fm_power_up(struct fmdev *fmdev, u8 mode)
 		fmdbg("Failed to download firmware file %s\n", fw_name);
 		goto rel;
 	}
-	sprintf(fw_name, "%s_%x.%d.bts", (mode == FM_MODE_RX) ?
+	sprintf(fw_name, "ti-connectivity/%s_%x.%d.bts", (mode == FM_MODE_RX) ?
 			FM_RX_FW_FILE_START : FM_TX_FW_FILE_START,
 			be16_to_cpu(asic_id), be16_to_cpu(asic_ver));
 
-- 
2.19.2
