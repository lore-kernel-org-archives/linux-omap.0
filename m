Return-Path: <SRS0=uMh/=4J=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCEEC35642
	for <linux-omap@archiver.kernel.org>; Fri, 21 Feb 2020 10:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B0624650
	for <linux-omap@archiver.kernel.org>; Fri, 21 Feb 2020 10:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sTiOX98E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgBUKTz (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:19:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60398 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgBUKTz (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 21 Feb 2020 05:19:55 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01LAJrTI015219;
        Fri, 21 Feb 2020 04:19:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582280393;
        bh=fzx9UZNviOKGYzgrbhDQuJU1OqfT2VTJO9LbMa1Qz+s=;
        h=From:To:CC:Subject:Date;
        b=sTiOX98Ekll9pqrYqBTlUMW1RVuyfAhYXN27cneNIl1R+MDXxgsYHYzW100J6WzGA
         vbzm0jzN0fr1lJs1vg2mGD+kbJcI0j++ll8d+eooW6BVcSCnLjPUjTYcm7P4SbEDZq
         jgCYsfjONuJ9AUDtUDJouSReTQDzSWWNf5m6wE9Y=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01LAJrmG115787
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Feb 2020 04:19:53 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 21
 Feb 2020 04:19:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 21 Feb 2020 04:19:52 -0600
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01LAJnwn034983;
        Fri, 21 Feb 2020 04:19:50 -0600
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>, <afd@ti.com>, <s-anna@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCHv7 00/15] remoteproc: updates for omap remoteproc support
Date:   Fri, 21 Feb 2020 12:19:21 +0200
Message-ID: <20200221101936.16833-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

Sorry for one more spin... Hopefully this is the final revision of the
series though.

Anyways, this version just contains one bigger change (patch #12),
and then a number of minor cosmetic fixes only (patch #1-#3, #5, #10,
#11, #14), and one new patch (#15).

Patch #12 has the most extensive modifications to warp around the runtime
PM support to the shape Suman wanted it. Rest of the cosmetic changes are
pretty much originated from Suman also (we synced offline that this version
of the series should be fine and contains all the changes he also wanted still
in.) In addition to this, patch #15 was added for switching the omap
remoteproc header to SPDX license identifier.

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
