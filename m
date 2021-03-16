Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4FAC4332E
	for <linux-omap@archiver.kernel.org>; Tue, 16 Mar 2021 20:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15FB64D9D
	for <linux-omap@archiver.kernel.org>; Tue, 16 Mar 2021 20:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCPUZj (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 16 Mar 2021 16:25:39 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:12984 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCPUZS (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 16 Mar 2021 16:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1615926319; x=1647462319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xPHHLCf7ZvBUG+y5LNfWWLREmAHRu22m1USDWCJuPBU=;
  b=eUtZ9c+tZLbeX/fq1LyPw7fUtg6tEfL94wOi9QD+eaUBa/m8fhvkRADM
   xwU4QWtKzIGO1E4sJ4ewCkEAGzqIsbvAUxLhB886d01tCbmLs5Zq0kvJ7
   l3t9RlNgm0VwvxFj/yZ7/mwAVQpgofc93Hu2ryP1CMbV0hjarrLaSO448
   Q=;
X-IronPort-AV: E=Sophos;i="5.81,254,1610409600"; 
   d="scan'208";a="99356089"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 16 Mar 2021 20:25:16 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 1BB2AA1C59;
        Tue, 16 Mar 2021 20:25:15 +0000 (UTC)
Received: from u8a88181e7b2355.ant.amazon.com (10.43.160.48) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Mar 2021 20:25:08 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <tony@atomide.com>, <haojian.zhuang@linaro.org>,
        <linus.walleij@linaro.org>
CC:     <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <tgershi@amazon.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hhhawa@amazon.com>
Subject: [PATCH v2 3/3] pinctrl: pinctrl-single: fix pcs_pin_dbg_show() when bits_per_mux != 0
Date:   Tue, 16 Mar 2021 22:24:34 +0200
Message-ID: <20210316202434.27555-4-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316202434.27555-1-hhhawa@amazon.com>
References: <20210316202434.27555-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D02UWB003.ant.amazon.com (10.43.161.48) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

An SError was detected when trying to print the supported pins in a
pinctrl device which supports multiple pins per register. This change
fixes the pcs_pin_dbg_show() in pinctrl-single driver when
bits_per_mux != 0. In addition move offset calculation and pin offset in
register to common function.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/pinctrl/pinctrl-single.c | 66 ++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index f3394517cb2e..434f90c8b1b3 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -270,20 +270,53 @@ static void __maybe_unused pcs_writel(unsigned val, void __iomem *reg)
 	writel(val, reg);
 }
 
+static unsigned int pcs_pin_reg_offset_get(struct pcs_device *pcs,
+					   unsigned int pin)
+{
+	unsigned int offset, mux_bytes;
+
+	mux_bytes = pcs->width / BITS_PER_BYTE;
+
+	if (pcs->bits_per_mux) {
+		unsigned int pin_offset_bytes;
+
+		pin_offset_bytes = (pcs->bits_per_pin * pin) / BITS_PER_BYTE;
+		offset = (pin_offset_bytes / mux_bytes) * mux_bytes;
+	} else {
+		offset = pin * mux_bytes;
+	}
+
+	return offset;
+}
+
+static unsigned int pcs_pin_shift_reg_get(struct pcs_device *pcs,
+					  unsigned int pin)
+{
+	return ((pin % (pcs->width / pcs->bits_per_pin)) * pcs->bits_per_pin);
+}
+
 static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
 					struct seq_file *s,
 					unsigned pin)
 {
 	struct pcs_device *pcs;
-	unsigned val, mux_bytes;
+	unsigned int val;
 	unsigned long offset;
 	size_t pa;
 
 	pcs = pinctrl_dev_get_drvdata(pctldev);
 
-	mux_bytes = pcs->width / BITS_PER_BYTE;
-	offset = pin * mux_bytes;
-	val = pcs->read(pcs->base + offset);
+	offset = pcs_pin_reg_offset_get(pcs, pin);
+
+	if (pcs->bits_per_mux) {
+		unsigned int pin_shift_in_reg = pcs_pin_shift_reg_get(pcs, pin);
+
+		val = pcs->read(pcs->base + offset)
+			& (pcs->fmask << pin_shift_in_reg);
+	} else {
+		val = pcs->read(pcs->base + offset);
+	}
+
 	pa = pcs->res->start + offset;
 
 	seq_printf(s, "%zx %08x %s ", pa, val, DRIVER_NAME);
@@ -384,7 +417,6 @@ static int pcs_request_gpio(struct pinctrl_dev *pctldev,
 	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
 	struct pcs_gpiofunc_range *frange = NULL;
 	struct list_head *pos, *tmp;
-	int mux_bytes = 0;
 	unsigned data;
 
 	/* If function mask is null, return directly. */
@@ -392,29 +424,27 @@ static int pcs_request_gpio(struct pinctrl_dev *pctldev,
 		return -ENOTSUPP;
 
 	list_for_each_safe(pos, tmp, &pcs->gpiofuncs) {
+		u32 offset;
+
 		frange = list_entry(pos, struct pcs_gpiofunc_range, node);
 		if (pin >= frange->offset + frange->npins
 			|| pin < frange->offset)
 			continue;
-		mux_bytes = pcs->width / BITS_PER_BYTE;
 
-		if (pcs->bits_per_mux) {
-			int byte_num, offset, pin_shift;
+		offset = pcs_pin_reg_offset_get(pcs, pin);
 
-			byte_num = (pcs->bits_per_pin * pin) / BITS_PER_BYTE;
-			offset = (byte_num / mux_bytes) * mux_bytes;
-			pin_shift = pin % (pcs->width / pcs->bits_per_pin) *
-				    pcs->bits_per_pin;
+		if (pcs->bits_per_mux) {
+			int pin_shift = pcs_pin_shift_reg_get(pcs, pin);
 
 			data = pcs->read(pcs->base + offset);
 			data &= ~(pcs->fmask << pin_shift);
 			data |= frange->gpiofunc << pin_shift;
 			pcs->write(data, pcs->base + offset);
 		} else {
-			data = pcs->read(pcs->base + pin * mux_bytes);
+			data = pcs->read(pcs->base + offset);
 			data &= ~pcs->fmask;
 			data |= frange->gpiofunc;
-			pcs->write(data, pcs->base + pin * mux_bytes);
+			pcs->write(data, pcs->base + offset);
 		}
 		break;
 	}
@@ -724,14 +754,8 @@ static int pcs_allocate_pin_table(struct pcs_device *pcs)
 	for (i = 0; i < pcs->desc.npins; i++) {
 		unsigned offset;
 		int res;
-		int byte_num;
 
-		if (pcs->bits_per_mux) {
-			byte_num = (pcs->bits_per_pin * i) / BITS_PER_BYTE;
-			offset = (byte_num / mux_bytes) * mux_bytes;
-		} else {
-			offset = i * mux_bytes;
-		}
+		offset = pcs_pin_reg_offset_get(pcs, i);
 		res = pcs_add_pin(pcs, offset);
 		if (res < 0) {
 			dev_err(pcs->dev, "error adding pins: %i\n", res);
-- 
2.17.1

