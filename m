From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] ARM: dts: remove previously generated .dtb files on clean
Date: Fri, 28 Jun 2013 09:41:02 +0530
Message-ID: <1372392662-6833-1-git-send-email-lokeshvutla@ti.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: nm@ti.com, paul@pwsan.com, shawn.guo@linaro.org, linux@arm.linux.org.uk, arnd@arndb.de, lokeshvutla@ti.com, gregkh@linuxfoundation.org, rnayak@ti.com, linux-kernel@vger.kernel.org, tony@atomide.com, khilman@linaro.org, olof@lixom.net, benoit.cousson@linaro.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

*.dtb used to be generated in the *arch/arm/boot* directory
which is different from where it is generated now.
Current rules delete the previously generated files only for
*make dtbs*.
Let distclean delete all the generated dtb files.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f0895c5..d293167 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -219,4 +219,4 @@ endif
 dtbs: $(addprefix $(obj)/, $(dtb-y))
 	$(Q)rm -f $(obj)/../*.dtb
 
-clean-files := *.dtb
+clean-files := *.dtb ../*.dtb
-- 
1.7.9.5
