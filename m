From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 7/8] musb: set 'extvbus = 0' for Davinci boards
Date: Tue, 17 Nov 2009 20:39:55 +0530
Message-ID: <1258470596-24321-8-git-send-email-ajay.gupta@ti.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-3-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-4-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-5-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-6-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-7-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52430 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbZKQPKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 10:10:40 -0500
In-Reply-To: <1258470596-24321-7-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, felipe.balbi@nokia.com, david-b@pacbell.net, cooloney@kernel.org, gadiyar@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Default value of 'extvbus' is being set as '0' to maintain the
current programming state of all Davinci musb boards.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c     |    1 +
 arch/arm/mach-davinci/board-dm355-leopard.c |    1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    |    1 +
 arch/arm/mach-davinci/board-sffsdr.c        |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 31c5741..ed011ae 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -322,6 +322,7 @@ static struct spi_board_info dm355_evm_spi_info[] __initconst = {
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 250,	/* (power in mA)/2 */
 	.potpgt = 4,	/* (potpgt in msec)/2 */
+	.extvbus = 0,
 };
 
 static __init void dm355_evm_init(void)
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 2c534f1..4ab8ab5 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -248,6 +248,7 @@ static struct spi_board_info dm355_leopard_spi_info[] __initconst = {
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 250,	/* (power in mA)/2 */
 	.potpgt = 4,	/* (potpgt in msec)/2 */
+	.extvbus = 0,
 };
 
 static __init void dm355_leopard_init(void)
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 307520e..9e99882 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -443,6 +443,7 @@ static struct pcf857x_platform_data pcf_data_u18 = {
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 250,	/* (power in mA)/2 */
 	.potpgt = 4,	/* (potpgt in msec)/2 */
+	.extvbus = 0,
 };
 
 /* U35 - various I/O signals used to manage USB, CF, ATA, etc */
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index e61d7d7..c6c9b20 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -154,6 +154,7 @@ static struct davinci_uart_config uart_config __initdata = {
 static struct musb_hdrc_board_data musb_bdata __initdata = {
 	.power = 0,	/* (power in mA)/2 */
 	.potpgt = 0,	/* (potpgt in msec)/2 */
+	.extvbus = 0,
 };
 
 static void __init davinci_sffsdr_map_io(void)
-- 
1.6.2.4

