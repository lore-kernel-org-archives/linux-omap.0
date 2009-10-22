From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/10] omap2: Fix console serial port number for n8x0
Date: Thu, 22 Oct 2009 15:12:39 -0700
Message-ID: <20091022221239.27408.80500.stgit@localhost>
References: <20091022221013.27408.443.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091022221013.27408.443.stgit@localhost>
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
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

With the recent changes omap serial ports match the physical
numbering like they should. Fix the kernel CMDLINE accordingly
so console works.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/n8x0_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/n8x0_defconfig b/arch/arm/configs/n8x0_defconfig
index 8da75de..264f52b 100644
--- a/arch/arm/configs/n8x0_defconfig
+++ b/arch/arm/configs/n8x0_defconfig
@@ -304,7 +304,7 @@ CONFIG_ALIGNMENT_TRAP=y
 CONFIG_ZBOOT_ROM_TEXT=0x10C08000
 CONFIG_ZBOOT_ROM_BSS=0x10200000
 # CONFIG_ZBOOT_ROM is not set
-CONFIG_CMDLINE="root=1f03 rootfstype=jffs2 console=ttyS0,115200n8"
+CONFIG_CMDLINE="root=1f03 rootfstype=jffs2 console=ttyS2,115200n8"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
