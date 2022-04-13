Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3209C433EF
	for <linux-omap@archiver.kernel.org>; Wed, 13 Apr 2022 04:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiDMEqH (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 13 Apr 2022 00:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiDMEqE (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 13 Apr 2022 00:46:04 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DEB31DDD;
        Tue, 12 Apr 2022 21:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649825025; x=1681361025;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Euy5GyMcnB1dcHLsisZMhR4czkWWcNeX4uR3GjmBfcw=;
  b=rV2BuH1Ma1k9AJGdycvPbJY6qE7b8Kib/9XNR5Yl9XJ0aL6PeOavKTyE
   63wHEjHDTy0Uhwn2PsSY+h/wSZzrfScVFfuBGHDYxwOwZi0QuQtX8l40o
   zAyvKDwKfB6YJqZpx3xB3MUGDZHZ70KDq2cX7yg1Sr4JOBCY4zEU469iV
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Apr 2022 21:43:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 21:43:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 21:43:24 -0700
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 21:43:21 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <tony@atomide.com>, <paul@pwsan.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
Subject: [PATCH] MAINTAINERS: omap: remove me as a maintainer
Date:   Wed, 13 Apr 2022 10:13:03 +0530
Message-ID: <1649824983-29400-1-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The codeaurora.org domain is no longer valid, remove my id
from the maintainers for OMAP PM frameworks.
I haven't contributed to them in years, neither do I plan to
in the future so not updating this with my new quicinc id.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61d9f11..9dbadc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14364,7 +14364,6 @@ F:	arch/arm/*omap*/*pm*
 F:	drivers/cpufreq/omap-cpufreq.c
 
 OMAP POWERDOMAIN SOC ADAPTATION LAYER SUPPORT
-M:	Rajendra Nayak <rnayak@codeaurora.org>
 M:	Paul Walmsley <paul@pwsan.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-- 
2.7.4

