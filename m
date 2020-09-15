Return-Path: <SRS0=U+pX=CY=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68715C433E2
	for <linux-omap@archiver.kernel.org>; Tue, 15 Sep 2020 07:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E0E21D1B
	for <linux-omap@archiver.kernel.org>; Tue, 15 Sep 2020 07:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hM/96GIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgIOHq4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 15 Sep 2020 03:46:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45924 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIOHqg (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 15 Sep 2020 03:46:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08F7kU8G061493;
        Tue, 15 Sep 2020 02:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600155990;
        bh=MZTT0c7uKU0TrTpPDh85a6zYXuLVqFP/3UI9EtkemZ0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hM/96GIg5ERFBp/qnDrVRyY13wzkKZRuxuRPkh7QB7glWGz+V+3BKDpzId/wgSaPZ
         CV9C444oD0tISaluXvPge96m3k2n/tFA4xTrrr2hGrwpD+snPW013CLOG86ly5u06y
         BSwTLJPAUteMURQgY85UtS36sU8zESSNn5es+nbU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08F7kU8i095205
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 02:46:30 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 02:46:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 02:46:30 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08F7kSp1054379;
        Tue, 15 Sep 2020 02:46:29 -0500
Subject: Re: [PATCH] memory: omap-gpmc: Fix compile test on SPARC
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200911143251.399-1-krzk@kernel.org>
 <bf9aa130-d5e7-d180-5a52-0cb244ffbf4f@ti.com>
 <CAJKOXPeGckdQbHPCw8-sYQgiwSf7aHKnGL0RJjM0K_U6KdROWg@mail.gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <6163cc96-3f91-893d-3c1c-555ed9ee4b82@ti.com>
Date:   Tue, 15 Sep 2020 10:46:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeGckdQbHPCw8-sYQgiwSf7aHKnGL0RJjM0K_U6KdROWg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org



On 11/09/2020 17:55, Krzysztof Kozlowski wrote:
> On Fri, 11 Sep 2020 at 16:48, Roger Quadros <rogerq@ti.com> wrote:
>>
>> Hi Krzysztof,
>>
>> On 11/09/2020 17:32, Krzysztof Kozlowski wrote:
>>> SPARC comes without CONFIG_OF_ADDRESS thus compile testing fails on
>>> linking:
>>>
>>>     /usr/bin/sparc64-linux-gnu-ld: drivers/memory/omap-gpmc.o: in function `gpmc_probe_generic_child':
>>>     omap-gpmc.c:(.text.unlikely+0x14ec): undefined reference to `of_platform_device_create'
>>>
>>> Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> ---
>>>    drivers/memory/Kconfig | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
>>> index 8072204bc21a..00e013b14703 100644
>>> --- a/drivers/memory/Kconfig
>>> +++ b/drivers/memory/Kconfig
>>> @@ -104,6 +104,7 @@ config TI_EMIF
>>>
>>>    config OMAP_GPMC
>>>        bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
>>> +     depends on OF_ADDRESS
>>
>> but of_platform_device_create() is defined in platform.c which gets built
>> irrespective of OF_ADDRESS.
>>
>> Maybe we need to just depend on CONFIG_OF ?
> 
> No, the of_platform_device_create() is defined there within #ifdef
> CONFIG_OF_ADDRESS
> 
> The CONFIG_OF was already selected and was not enough.
> 
> Other solution is "depends on !SPARC"...
> 

OK. In that case this patch is better.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
