From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 1/6] omap: mailbox: check iomem resource before dereferencing it
Date: Tue, 11 Jun 2013 12:03:30 -0500
Message-ID: <1370970210-6669-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52185 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755661Ab3FKRJJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 13:09:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>, Fernando Guzman Lugo <lugo.fernando@gmail.com>

Add a NULL check for iomem resource in mailbox probe functions.

Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap1/mailbox.c | 3 +++
 arch/arm/mach-omap2/mailbox.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index efc8f20..a343d5f 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -152,6 +152,9 @@ static int omap1_mbox_probe(struct platform_device *pdev)
 	list[0]->irq = platform_get_irq_byname(pdev, "dsp");
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -ENOENT;
+
 	mbox_base = ioremap(mem->start, resource_size(mem));
 	if (!mbox_base)
 		return -ENOMEM;
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 0b08026..9fe0bf2 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -382,6 +382,9 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -ENOENT;
+
 	mbox_base = ioremap(mem->start, resource_size(mem));
 	if (!mbox_base)
 		return -ENOMEM;
-- 
1.8.2

