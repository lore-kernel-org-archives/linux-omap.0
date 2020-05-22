Return-Path: <SRS0=1hos=7E=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EF5C433E1
	for <linux-omap@archiver.kernel.org>; Fri, 22 May 2020 14:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E798F206C3
	for <linux-omap@archiver.kernel.org>; Fri, 22 May 2020 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159381;
	bh=wCEJW245dxBO726etQLlIpRtTbaTWQv+YPDCCDn2mbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RgKmlmmNT5+aoRcMfNqkwty1JH5Xu50xdJ0qXNsue4wN5Mo64X7fOEZrtBPT7/d8Q
	 dumVIH6n7tSlNz6rAhnnSxCSIIyuSkU0J/U63SO4Ypr1ffiwAE5YKZazp46TI848iV
	 CzBHj4Koq4fUlwRS3PSfYHzCgXuKnqB1bqhFv3TM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgEVO4P (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 22 May 2020 10:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730891AbgEVOvF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 22 May 2020 10:51:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EAE8222E7;
        Fri, 22 May 2020 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159065;
        bh=wCEJW245dxBO726etQLlIpRtTbaTWQv+YPDCCDn2mbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nmtcJU2YJfDre/+Ad6GkFDHoHVvtoMv18xZWjaam2GXzcyE1pBHBGm8NVc8Li3Pzq
         5nPtTkTAYCBg02QYkezWRu2X700Ax8XJbEx6TEMpf7DNJyXPHo4ZaOiRN4U0zRn41d
         xbk6lSnVmx6y/cdSQYuqeKzXDGJcGsPJFHV2AKW0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 18/32] usb: dwc3: pci: Enable extcon driver for Intel Merrifield
Date:   Fri, 22 May 2020 10:50:30 -0400
Message-Id: <20200522145044.434677-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145044.434677-1-sashal@kernel.org>
References: <20200522145044.434677-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 066c09593454e89bc605ffdff1c9810061f9b1e1 ]

Intel Merrifield provides a DR support via PMIC which has its own
extcon driver.

Add a property string to link to that driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 7051611229c9..b67372737dc9 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -114,6 +114,7 @@ static const struct property_entry dwc3_pci_intel_properties[] = {
 
 static const struct property_entry dwc3_pci_mrfld_properties[] = {
 	PROPERTY_ENTRY_STRING("dr_mode", "otg"),
+	PROPERTY_ENTRY_STRING("linux,extcon-name", "mrfld_bcove_pwrsrc"),
 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
 	{}
 };
-- 
2.25.1

