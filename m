Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858D0C433DB
	for <linux-omap@archiver.kernel.org>; Tue,  9 Feb 2021 17:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558BD64EA6
	for <linux-omap@archiver.kernel.org>; Tue,  9 Feb 2021 17:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhBIRYj (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:24:39 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40596 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhBIRYX (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2021 12:24:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 119HMjxt106590;
        Tue, 9 Feb 2021 11:22:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612891365;
        bh=WHgIPCsLLd6ED8WO7wT1Vk2f51jRuOg3MuGY4FvRhK4=;
        h=From:To:CC:Subject:Date;
        b=ruwWtSaNXZGrvcvnkZSbjiAujDF+UpbSEW/AIGG96JBfI/xxp0PMx7yV4MIjwMOSO
         adnSehLKrLcxqOhvTijnBXsV/RqmOcO+khftyvRRwabJ0NTRfDPnLnhTks6I4dcHC5
         Kb3aOfFC9z5fiUxE2pbP11mjz58x8huhpyCZVj3s=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 119HMjob112669
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 11:22:45 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Feb
 2021 11:22:45 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Feb 2021 11:22:44 -0600
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 119HMini128800;
        Tue, 9 Feb 2021 11:22:44 -0600
Received: from localhost ([10.250.35.110])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 119HMi4i007466;
        Tue, 9 Feb 2021 11:22:44 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 0/2] Add HwSpinlock support for TI K3 AM64x SoCs
Date:   Tue, 9 Feb 2021 11:22:38 -0600
Message-ID: <20210209172240.2305-1-s-anna@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi Bjorn,

The following is a minor revision of the series [1] that extends the OMAP
HwSpinlock driver for the IP on TI K3 AM64x SoCs. 

Only change is in patch 1 to drop the example in the dt-bindings patch.

regards
Suman

[1] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210125235653.24385-1-s-anna@ti.com/

Suman Anna (2):
  dt-bindings: hwlock: Update OMAP HwSpinlock binding for AM64x SoCs
  hwspinlock: omap: Add support for K3 AM64x SoCs

 .../devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml        | 1 +
 drivers/hwspinlock/omap_hwspinlock.c                          | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.29.2

