From: Eliad Peller <eliad@wizery.com>
Subject: [PATCH 3/3] omap: board-sdp4430: declare support for MMC_PM_KEEP_POWER
Date: Tue, 22 Nov 2011 16:02:19 +0200
Message-ID: <1321970539-7104-3-git-send-email-eliad@wizery.com>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1321970539-7104-1-git-send-email-eliad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Declare support for keeping the power of the wlan chip
while suspended. this is needed for Wakeup-On-Wireless.

Signed-off-by: Eliad Peller <eliad@wizery.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c7cef44..fd8b2a5 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -420,6 +420,7 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 5,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
+		.pm_caps	= MMC_PM_KEEP_POWER,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.ocr_mask	= MMC_VDD_165_195,
-- 
1.7.6.401.g6a319

