Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32043C388F9
	for <linux-omap@archiver.kernel.org>; Wed, 11 Nov 2020 12:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2354206C0
	for <linux-omap@archiver.kernel.org>; Wed, 11 Nov 2020 12:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lgCtNG3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgKKMEK (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:04:10 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50250 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgKKMD4 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2020 07:03:56 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ABC3kej022377;
        Wed, 11 Nov 2020 06:03:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605096226;
        bh=zQ+3rQU5P5ByNF5jLqAR+Z1eJZmvyE5qwKK+nGxlJ6I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lgCtNG3/W1Spd5++M3rR/CnWQjbmNl1JodMsmUhq5WLALt8YCCzECapGS5MbhiLKf
         4aunbufrN6Ai/q7nbNX/HsKxjBqSWR7w3Td3r/I+BQ+9Qsz+yJnFKAlaCKlWfuSVuG
         e+qRYFb792tQW4zBGQFJrBkOx1lsWL3QdFZ4754k=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ABC3kP5082746
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 06:03:46 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 06:03:45 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 11 Nov 2020 06:03:45 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ABC3hvf048539;
        Wed, 11 Nov 2020 06:03:44 -0600
Subject: Re: [PATCH v3 37/56] drm/omap: panel-dsi-cm: support unbinding
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Sebastian Reichel <sre@kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        <linux-omap@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20201105120333.947408-1-tomi.valkeinen@ti.com>
 <20201105120333.947408-38-tomi.valkeinen@ti.com>
 <20201109104939.GH6029@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <4f68998c-5171-a67a-ca7d-22ffe53f1fb7@ti.com>
Date:   Wed, 11 Nov 2020 14:03:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109104939.GH6029@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 09/11/2020 12:49, Laurent Pinchart wrote:
> Hi Tomi and Sebastian,
> 
> On Thu, Nov 05, 2020 at 02:03:14PM +0200, Tomi Valkeinen wrote:
>> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>>
>> Now, that the driver implements the common DRM panel API
>> the unbind no longer needs to be suppressed.
>>
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I'd be curious to know what happens when you try to unbind through sysfs
> though...

I'm sure it crashes. The same happens if you unload the modules in wrong order (unload panel first,
then omapdrm). I haven't looked at this yet, it's low priority issue...

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
