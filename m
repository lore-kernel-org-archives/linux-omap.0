Return-Path: <SRS0=qHWz=5B=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547B3C10F29
	for <linux-omap@archiver.kernel.org>; Mon, 16 Mar 2020 02:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AF120736
	for <linux-omap@archiver.kernel.org>; Mon, 16 Mar 2020 02:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326492;
	bh=8r9H4rfR2MbERS/6jidvQxK29URrmHh+Oxg5FXPgUxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BB342wzjZgt4sNod8lNxbx9tF/Jay0BI3T7j8dhQFo2B88hOeTl8LJXXhlAooGbch
	 iVg+Js+TPb9M+lwIkVSAly10hvar+RKtVtVC5ttIExkwEZVH0yQrfWRzcPGO7x19mi
	 DrCpfPxOFsNQUfXXbolMXd/Tv5ePhLfasl8TMzQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgCPClb (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729565AbgCPCdh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Sun, 15 Mar 2020 22:33:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9842073D;
        Mon, 16 Mar 2020 02:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326016;
        bh=8r9H4rfR2MbERS/6jidvQxK29URrmHh+Oxg5FXPgUxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMKIrhVlM/OxKXOfJPVfAQoKg4nU/zONtHuiy8a8LB9CTTWkr6E6G96CBvpsbSawU
         gfpfqc++vyJjHx8rf0mMbM9AfdwpxW7fuPvKU4gtPkYMZBrZ7IPf8Ao0G4Ee5vow0E
         SRMIxMgbFb4qiiqL+1B+yNTxnCC/IRss47nsp7CA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 14/41] ARM: dts: dra7: Add "dma-ranges" property to PCIe RC DT nodes
Date:   Sun, 15 Mar 2020 22:32:52 -0400
Message-Id: <20200316023319.749-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023319.749-1-sashal@kernel.org>
References: <20200316023319.749-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 27f13774654ea6bd0b6fc9b97cce8d19e5735661 ]

'dma-ranges' in a PCI bridge node does correctly set dma masks for PCI
devices not described in the DT. Certain DRA7 platforms (e.g., DRA76)
has RAM above 32-bit boundary (accessible with LPAE config) though the
PCIe bridge will be able to access only 32-bits. Add 'dma-ranges'
property in PCIe RC DT nodes to indicate the host bridge can access
only 32 bits.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/dra7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 73e5011f531ab..c5af7530be7c8 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -184,6 +184,7 @@
 				device_type = "pci";
 				ranges = <0x81000000 0 0          0x03000 0 0x00010000
 					  0x82000000 0 0x20013000 0x13000 0 0xffed000>;
+				dma-ranges = <0x02000000 0x0 0x00000000 0x00000000 0x1 0x00000000>;
 				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
@@ -238,6 +239,7 @@
 				device_type = "pci";
 				ranges = <0x81000000 0 0          0x03000 0 0x00010000
 					  0x82000000 0 0x30013000 0x13000 0 0xffed000>;
+				dma-ranges = <0x02000000 0x0 0x00000000 0x00000000 0x1 0x00000000>;
 				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
-- 
2.20.1

