From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/7] ARM: Select CONFIG_ARCH_NO_SYSDEV_OPS
Date: Mon, 28 Mar 2011 01:30:31 +0200
Message-ID: <201103280130.31353.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201103280125.11750.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-omap@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the ARM architecture select CONFIG_ARCH_NO_SYSDEV_OPS to
indicate that sysdevs are not used for power management any more on
this architecture.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -28,6 +28,7 @@ config ARM
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_GENERIC_HARDIRQS
 	select HAVE_SPARSE_IRQ
+	select ARCH_NO_SYSDEV_OPS
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
