From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 07/18] ARM: mach-integrator: move CM_CTRL to header file for
 accessing by other functions
Date: Fri, 30 Mar 2012 19:58:22 +0800
Message-ID: <1333108713-12707-8-git-send-email-bryan.wu@canonical.com>
References: <1333108713-12707-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1333108713-12707-1-git-send-email-bryan.wu@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, linux@arm.linux.org.uk, rpurdie@rpsys.net, manuel.lauss@gmail.com, cjb@laptop.org, cbou@mail.ru, dwmw2@infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-integrator/core.c            |    2 --
 arch/arm/mach-integrator/include/mach/cm.h |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index eaf6c63..8c53562 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -172,8 +172,6 @@ static struct amba_pl010_data integrator_uart_data = {
 	.set_mctrl = integrator_uart_set_mctrl,
 };
 
-#define CM_CTRL	IO_ADDRESS(INTEGRATOR_HDR_CTRL)
-
 static DEFINE_RAW_SPINLOCK(cm_lock);
 
 /**
diff --git a/arch/arm/mach-integrator/include/mach/cm.h b/arch/arm/mach-integrator/include/mach/cm.h
index 445d57a..1a78692e 100644
--- a/arch/arm/mach-integrator/include/mach/cm.h
+++ b/arch/arm/mach-integrator/include/mach/cm.h
@@ -3,6 +3,8 @@
  */
 void cm_control(u32, u32);
 
+#define CM_CTRL	IO_ADDRESS(INTEGRATOR_HDR_CTRL)
+
 #define CM_CTRL_LED			(1 << 0)
 #define CM_CTRL_nMBDET			(1 << 1)
 #define CM_CTRL_REMAP			(1 << 2)
-- 
1.7.9.1
