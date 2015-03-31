From: Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13.y-ckt 055/143] usb: musb: omap2plus bus glue needs USB
 host support
Date: Tue, 31 Mar 2015 12:47:00 -0700
Message-ID: <1427831308-1854-56-git-send-email-kamal@canonical.com>
References: <1427831308-1854-1-git-send-email-kamal@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-team-bounces@lists.ubuntu.com>
In-Reply-To: <1427831308-1854-1-git-send-email-kamal@canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/options/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/kernel-team>
List-Post: <mailto:kernel-team@lists.ubuntu.com>
List-Help: <mailto:kernel-team-request@lists.ubuntu.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=subscribe>
Errors-To: kernel-team-bounces@lists.ubuntu.com
Sender: kernel-team-bounces@lists.ubuntu.com
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: Kamal Mostafa <kamal@canonical.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

3.13.11-ckt18 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit a8d191c8bb2f11a8f381e7cb98f978b7288c1401 upstream.

The musb/omap2430.c bus glue driver calls usb_hcd_poll_rh_status,
which is only available if CONFIG_USB is also set, i.e. we
are building USB host mode and not just endpoint mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/usb/musb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 57dfc0c..a70f46f 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -74,7 +74,7 @@ config USB_MUSB_TUSB6010
 
 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS && USB
 	select GENERIC_PHY
 
 config USB_MUSB_AM35X
-- 
1.9.1
