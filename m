From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ARM: OMAP: Overo: remove illegal extra call to
	overo_ads7846_init()
Date: Fri, 17 Jun 2011 17:21:50 +0200
Message-ID: <1308324110-21918-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, linux-omap@vger.kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/board-overo.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 175e1ab..110475f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -568,7 +568,6 @@ static void __init overo_init(void)
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	overo_spi_init();
-	overo_ads7846_init();
 	overo_init_smsc911x();
 	overo_display_init();
 	overo_init_led();
-- 
1.7.5.1
