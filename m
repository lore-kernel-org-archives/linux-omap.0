From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [RESEND PATCHv3 1/4] ARM: Introduce SoC Info into /proc/cpuinfo
Date: Wed,  5 May 2010 11:42:05 +0300
Message-ID: <1273048928-6105-2-git-send-email-eduardo.valentin@nokia.com>
References: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37647 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933833Ab0EEIl3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 04:41:29 -0400
In-Reply-To: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>
Cc: ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "\\\"De-Schrijver Peter (Nokia-D/Helsinki)\\\"" <Peter.De-Schrijver@nokia.com>, santosh.shilimkar@ti.com, felipe.balbi@nokia.com, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch extends the ARM /proc/cpuinfo to include soc info data.
It is implemented via the same way which is done for
system_rev, system_serial_low and system_serial_high.
Then, now we have system_soc_info, which is printed only
if there is something useful there.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/include/asm/system.h |    2 ++
 arch/arm/kernel/setup.c       |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 4ace45e..53a9645 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -71,6 +71,8 @@ struct task_struct;
 extern unsigned int system_rev;
 extern unsigned int system_serial_low;
 extern unsigned int system_serial_high;
+#define SYSTEM_SOC_INFO_SIZE			128
+extern char system_soc_info[SYSTEM_SOC_INFO_SIZE];
 extern unsigned int mem_fclk_21285;
 
 struct pt_regs;
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c91c77b..025d795 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -85,6 +85,9 @@ EXPORT_SYMBOL(system_serial_low);
 unsigned int system_serial_high;
 EXPORT_SYMBOL(system_serial_high);
 
+char system_soc_info[SYSTEM_SOC_INFO_SIZE];
+EXPORT_SYMBOL(system_soc_info);
+
 unsigned int elf_hwcap;
 EXPORT_SYMBOL(elf_hwcap);
 
@@ -847,6 +850,8 @@ static int c_show(struct seq_file *m, void *v)
 	seq_printf(m, "Revision\t: %04x\n", system_rev);
 	seq_printf(m, "Serial\t\t: %08x%08x\n",
 		   system_serial_high, system_serial_low);
+	if (strlen(system_soc_info))
+		seq_printf(m, "SoC Info\t: %s\n",  system_soc_info);
 
 	return 0;
 }
-- 
1.7.0.4.361.g8b5fe.dirty

