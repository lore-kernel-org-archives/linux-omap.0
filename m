Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC79AC4361B
	for <linux-omap@archiver.kernel.org>; Mon,  7 Dec 2020 14:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7515C235FC
	for <linux-omap@archiver.kernel.org>; Mon,  7 Dec 2020 14:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgLGOep (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 7 Dec 2020 09:34:45 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58902 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgLGOeo (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2020 09:34:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B7EXh6k125184;
        Mon, 7 Dec 2020 08:33:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607351623;
        bh=pprfP1SHyvuyCq84UV+Z11bHi/F0RSQPKkG97XTWBjk=;
        h=From:To:CC:Subject:Date;
        b=izzuzv1BJmvOriJ7K/NAh1tj9DKEKMD1dKTRrcdT7CnEmkfXXJsB8lF+7ylClPqnp
         Ye4GgnKFo+QedGUWFyYR7RvDanDKKvFQOkBXQ4fXJM2qkG52H7skB2gBuwy00sJJHp
         F15+cLCD+3xHHuCw6lCsy/rezeJIctspWO9U4twE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B7EXhmm122183
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Dec 2020 08:33:43 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Dec
 2020 08:33:42 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Dec 2020 08:33:43 -0600
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B7EXfwx071446;
        Mon, 7 Dec 2020 08:33:42 -0600
From:   Tero Kristo <t-kristo@ti.com>
To:     <linux-omap@vger.kernel.org>, <tony@atomide.com>
CC:     <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] ARM: dts: couple of DTS patches for DRA7 boards
Date:   Mon, 7 Dec 2020 16:33:36 +0200
Message-ID: <20201207143339.15674-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi Tony,

Here are couple of missing DTS patches for DRA7 family of boards.

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
