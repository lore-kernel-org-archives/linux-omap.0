From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: multi_v7_defconfig: Select CONFIG_SOC_DRA7XX
Date: Thu, 6 Feb 2014 09:29:31 -0600
Message-ID: <1391700571-31784-1-git-send-email-nm@ti.com>
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
To: Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Select CONFIG_SOC_DRA7XX so that we can boot dra7-evm.
DRA7 family are A15 based processors that supports LPAE and an
evolutionary update to the OMAP5 generation of processors.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

based on v3.13-rc1 kernel tag - tested on v3.14-rc1 and next-20140206

 arch/arm/configs/multi_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 845bc74..ee69829 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -29,6 +29,7 @@ CONFIG_ARCH_OMAP3=y
 CONFIG_ARCH_OMAP4=y
 CONFIG_SOC_OMAP5=y
 CONFIG_SOC_AM33XX=y
+CONFIG_SOC_DRA7XX=y
 CONFIG_SOC_AM43XX=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SOCFPGA=y
-- 
1.7.9.5
