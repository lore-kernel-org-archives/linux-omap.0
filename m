Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E78FC433ED
	for <linux-omap@archiver.kernel.org>; Thu, 20 May 2021 17:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0233661261
	for <linux-omap@archiver.kernel.org>; Thu, 20 May 2021 17:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhETRKY (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 20 May 2021 13:10:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47320 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhETRKX (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2021 13:10:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14KH91Vm063779
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2021 12:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621530541;
        bh=zcRpE0kPnfydqEHol8qWXoxu9WNaLV/T3S6DBbQsKDo=;
        h=Date:From:To:Subject;
        b=Ut+88OEd8GDZ5jWhzSNCeZjRhxrwvZl8vK3X7ohmjJmWVHcO8lLpZeVDDCaHUWBK8
         vdKp4DfwmENF9HTz6wPpwvZGzynWca7DUjcCieeCQBbb8MNs9XM5wwU0HNYkm2V9Lg
         3+RrBeW6qevMXiq6vSTCAb1isQQc34boeSlZknoM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14KH91FT129808
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2021 12:09:01 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 12:09:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 20 May 2021 12:09:01 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14KH91WW043165
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2021 12:09:01 -0500
Date:   Thu, 20 May 2021 12:09:01 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <linux-omap@vger.kernel.org>
Subject: IRC
Message-ID: <20210520170901.ksgkkkujl6sjynh2@confident>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi Folks,

Just letting the list know that we have a registered channel on
irc.libera.chat (https://libera.chat) #linux-ti

If folks are interested in chatting away the old IRC style.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
