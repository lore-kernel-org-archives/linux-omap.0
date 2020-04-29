Return-Path: <SRS0=+eaT=6N=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C36C83004
	for <linux-omap@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B502083B
	for <linux-omap@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZdTKzclD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgD2NNw (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:13:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37836 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgD2NNw (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2020 09:13:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03TDDl5U011380;
        Wed, 29 Apr 2020 08:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588166027;
        bh=K1UtLlq5m9T/dALmzwD0ejAI6fpKPOMS8Z0RGqrTI64=;
        h=From:To:CC:Subject:Date;
        b=ZdTKzclDfWTFN5/zdFl9o3YRhJO3xynLV6rY+N6emEPDX2d2cDF9A/g3thSe/K63S
         yNb5x4nUSTCzT3HCNKpAvbfny2EEfF1QyQ+8+Rzo1GBwpCwYEaYnouA0sFdzNBkcGo
         EwMgZ/0VsMtitC26U0r3fK6OZ4EUV50Ui6jqgxX4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03TDDlSu062916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Apr 2020 08:13:47 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 29
 Apr 2020 08:13:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 29 Apr 2020 08:13:47 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03TDDjrn113387;
        Wed, 29 Apr 2020 08:13:46 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <linux-clk@vger.kernel.org>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-omap@vger.kernel.org>, <tony@atomide.com>
Subject: [PATCH 0/3] clk: ti: couple of fixes towards 5.8
Date:   Wed, 29 Apr 2020 16:13:38 +0300
Message-ID: <20200429131341.4697-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

The issues fixed by these patches have been around for a while, so they
can be picked up for 5.8.

Patch #1 fixes a memory leak within composite clock registration, which
is only visible on platforms actually using composite clocks;
omap4/omap5.

Last two patches fix parenting of the l4-secure clocks for omap4/omap5,
which was apparenly missed when the clkctrl data for these domains was
created.

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
