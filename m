Return-Path: <SRS0=PCbK=57=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ED8C352BE
	for <linux-omap@archiver.kernel.org>; Wed, 15 Apr 2020 00:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364DA2078B
	for <linux-omap@archiver.kernel.org>; Wed, 15 Apr 2020 00:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586909607;
	bh=dRngsPvuG+kETgs2smktXaw9v1l2uk2emjkFea1ZosU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nvrbLAHPV7TfIFC49S5flyvk1i9uu8HnPw5ROMEhfhnk3QQ0oZpDC4vlD6JVu6mv2
	 n+v1R1VSGRE1jL/QrFXWXxADl21XCRtfJ11WyL3tvEN9oc5QxzRKvH+SG3ZqynJWmU
	 yfIuCBpFET50MZ9ENpg6v1TTsVYk25rTV1nffveo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392314AbgDOANR (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392311AbgDOANP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 14 Apr 2020 20:13:15 -0400
Received: from localhost (mobile-166-175-184-103.mycingular.net [166.175.184.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC3120774;
        Wed, 15 Apr 2020 00:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586909593;
        bh=dRngsPvuG+kETgs2smktXaw9v1l2uk2emjkFea1ZosU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNc70G7YwSQcq2MM9qgM51emm22lpt/Tuq/i8nVHyR/l+0y5zCxciz4rG1GVYkmKj
         pUBkZ4veIBiIho+l1qIauTrjurx2Pt/rtbf2BZMIQRMLtDj8bjmTc/esrjKJk6Cczd
         2DETdj5iD/rHgC9jtVpQ90O9wrblPLZxrC1g86Sg=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH 1/4] PCI: dra7xx: Don't select CONFIG_PCI_DRA7XX_HOST by default
Date:   Tue, 14 Apr 2020 19:12:41 -0500
Message-Id: <20200415001244.144623-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200415001244.144623-1-helgaas@kernel.org>
References: <20200415001244.144623-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Drivers should not be selected by default because that bloats the kernel
for people who don't need them.

Remove the "default y" for CONFIG_PCI_DRA7XX_HOST.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org
---
 drivers/pci/controller/dwc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 03dcaf65d159..ea335ee7ca8e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -26,7 +26,6 @@ config PCI_DRA7XX_HOST
 	depends on OF && HAS_IOMEM && TI_PIPE3
 	select PCIE_DW_HOST
 	select PCI_DRA7XX
-	default y
 	help
 	  Enables support for the PCIe controller in the DRA7xx SoC to work in
 	  host mode. There are two instances of PCIe controller in DRA7xx.
-- 
2.26.0.110.g2183baf09c-goog

