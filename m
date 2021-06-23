Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C1EC48BC2
	for <linux-omap@archiver.kernel.org>; Wed, 23 Jun 2021 17:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AC061241
	for <linux-omap@archiver.kernel.org>; Wed, 23 Jun 2021 17:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWRfI (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:35:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60350 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFWRfH (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2021 13:35:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15NHWh6Q099614;
        Wed, 23 Jun 2021 12:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624469563;
        bh=UMriVpcWrX6duGiVHg7tPEUFGtafE5BAdZAD1GnH89s=;
        h=From:To:CC:Subject:Date;
        b=C0X7ByiTT0zj4YHc6mISQsNZIPvHkDrI+w5oBRFmVsxcn3oDNpnhB2oSjHWOEII2j
         58iZzc3EW7OPfqbZzajP6+SfV+vsKmcQNiii4DH5xqx0QZQOWH+bSV/gdTvBKTSZ+x
         lNvrhMns3JDrdX/KYUMN5TVqNfy6+9jO/ahmDqRU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15NHWhfP083262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jun 2021 12:32:43 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 23
 Jun 2021 12:32:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 23 Jun 2021 12:32:43 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15NHWhq3122560;
        Wed, 23 Jun 2021 12:32:43 -0500
Received: from localhost ([10.250.33.41])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 15NHWhBB028848;
        Wed, 23 Jun 2021 12:32:43 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] Add AM64x SoC support to PRU remoteproc driver
Date:   Wed, 23 Jun 2021 12:32:40 -0500
Message-ID: <20210623173243.7862-1-s-anna@ti.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi All,

The following series updates the PRU remoteproc driver to support the
PRU, RTU and Tx_PRU cores present within the ICSSG IP on AM64x SoCs.
Patches are on top of latest rproc-next branch based on v5.13-rc1,
commit 30da589dba53 ("dt-bindings: remoteproc: qcom: pas: Fix indentation
warnings").

There are some minor differences around the PRU cores like different
Broadside RAM (BSRAM) sizes, but otherwise behave functionally the same
as the PRU cores on previous SoCs.

regards,
Suman

Suman Anna (2):
  dt-bindings: remoteproc: pru: Update bindings for K3 AM64x SoCs
  remoteproc: pru: Add support for various PRU cores on K3 AM64x SoCs

 .../devicetree/bindings/remoteproc/ti,pru-rproc.yaml         | 5 +++++
 drivers/remoteproc/pru_rproc.c                               | 3 +++
 2 files changed, 8 insertions(+)

-- 
2.30.1

