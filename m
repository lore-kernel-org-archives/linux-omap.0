Return-Path: <SRS0=SDee=CS=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38C5C433E2
	for <linux-omap@archiver.kernel.org>; Wed,  9 Sep 2020 16:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596302087C
	for <linux-omap@archiver.kernel.org>; Wed,  9 Sep 2020 16:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wps6n6OO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgIIQv0 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:51:26 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45890 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbgIIQvU (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 9 Sep 2020 12:51:20 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 089Gp7Pa047647;
        Wed, 9 Sep 2020 11:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599670267;
        bh=XqRw5QT7qAOnA0fHlBfRovQaKRWcEo/7X0wdNzUW/5g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wps6n6OO9R6UmvqkUtasili/Tgvw8xxS5fisiW8Vm91sOxmwDWAs1IaC+Au76LhQV
         Sv92Jv4J1/rFqWLO9++qxexT1BcGikpAM8b/lSMqLw7jWAKr1LlAd47bw6CzQ1EaI6
         ydRsOtW15tJkhtot90HM4yasQgZZzgvKwlZDbd3c=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 089Gp7DW110141;
        Wed, 9 Sep 2020 11:51:07 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Sep
 2020 11:51:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Sep 2020 11:51:07 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 089Gp59h087921;
        Wed, 9 Sep 2020 11:51:05 -0500
Subject: Re: [PATCH net-next v2 2/9] net: ethernet: ti: ale: add static
 configuration
To:     David Miller <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <kuba@kernel.org>, <vigneshr@ti.com>,
        <m-karicheri2@ti.com>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20200907143143.13735-1-grygorii.strashko@ti.com>
 <20200907143143.13735-3-grygorii.strashko@ti.com>
 <20200908.192845.1191873689940729972.davem@davemloft.net>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <61332531-0166-c5af-0475-1c338d2ea043@ti.com>
Date:   Wed, 9 Sep 2020 19:51:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908.192845.1191873689940729972.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org



On 09/09/2020 05:28, David Miller wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> Date: Mon, 7 Sep 2020 17:31:36 +0300
> 
>> +	ale_dev_id = cpsw_ale_match_id(cpsw_ale_id_match, params->dev_id);
>> +	if (ale_dev_id) {
>> +		params->ale_entries = ale_dev_id->tbl_entries;
>> +		params->major_ver_mask = ale_dev_id->major_ver_mask;
> ...
>> -	if (!ale->params.major_ver_mask)
>> -		ale->params.major_ver_mask = 0xff;
> 
> This is exactly the kind of change that causes regressions.
> 
> The default for the mask if no dev_id is found is now zero, whereas
> before the default mask would be 0xff.
> 
> Please don't make changes like this, they are very risky.
> 
> In every step of these changes, existing behavior should be maintained
> as precisely as possible.  Be as conservative as possible.
> 

Sorry and thank you for catching it.
This part belongs to Patch 6. I'll fix it.

-- 
Best regards,
grygorii
