From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP2+: defconfig: modularize bluetooth, audio and WLAN
Date: Tue, 28 Sep 2010 12:07:29 -0700
Message-ID: <1285700849-10000-3-git-send-email-khilman@deeprootsystems.com>
References: <1285700849-10000-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46274 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806Ab0I1THs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 15:07:48 -0400
Received: by pvg2 with SMTP id 2so1657283pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 12:07:48 -0700 (PDT)
In-Reply-To: <1285700849-10000-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

In working towards a smaller default kernel, only devices used for
early boot should be built in.  Toward that end, build the following
as modules by default:

- bluetooth
- audio: ALSA, ASoC
- WLAN

Uncompressed kernel size comparison:

Before:
   text	   data	    bss	    dec	    hex	filename
6557576	 465088	5616024	12638688	 c0d9e0	vmlinux

After:
   text	   data	    bss	    dec	    hex	filename
5616572	 436448	5610800	11663820	 b1f9cc	vmlinux

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/configs/omap2plus_defconfig |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a3db92b..7deec89 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -87,23 +87,23 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
-CONFIG_BT=y
-CONFIG_BT_L2CAP=y
-CONFIG_BT_SCO=y
+CONFIG_BT=m
+CONFIG_BT_L2CAP=m
+CONFIG_BT_SCO=m
 CONFIG_BT_RFCOMM=y
 CONFIG_BT_RFCOMM_TTY=y
-CONFIG_BT_BNEP=y
+CONFIG_BT_BNEP=m
 CONFIG_BT_BNEP_MC_FILTER=y
 CONFIG_BT_BNEP_PROTO_FILTER=y
-CONFIG_BT_HIDP=y
-CONFIG_BT_HCIUART=y
+CONFIG_BT_HIDP=m
+CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_H4=y
 CONFIG_BT_HCIUART_BCSP=y
 CONFIG_BT_HCIUART_LL=y
-CONFIG_BT_HCIBCM203X=y
-CONFIG_BT_HCIBPA10X=y
-CONFIG_CFG80211=y
-CONFIG_MAC80211=y
+CONFIG_BT_HCIBCM203X=m
+CONFIG_BT_HCIBPA10X=m
+CONFIG_CFG80211=m
+CONFIG_MAC80211=m
 CONFIG_MAC80211_RC_PID=y
 CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_MAC80211_LEDS=y
@@ -139,9 +139,9 @@ CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
 CONFIG_KS8851=y
 CONFIG_KS8851_MLL=y
-CONFIG_LIBERTAS=y
-CONFIG_LIBERTAS_USB=y
-CONFIG_LIBERTAS_SDIO=y
+CONFIG_LIBERTAS=m
+CONFIG_LIBERTAS_USB=m
+CONFIG_LIBERTAS_SDIO=m
 CONFIG_LIBERTAS_DEBUG=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_ALI_M5632=y
@@ -203,8 +203,8 @@ CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_LOGO=y
-CONFIG_SOUND=y
-CONFIG_SND=y
+CONFIG_SOUND=m
+CONFIG_SND=m
 CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
 CONFIG_SND_VERBOSE_PRINTK=y
-- 
1.7.2.1

