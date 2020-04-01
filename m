Return-Path: <SRS0=p3h7=5R=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813A3C43331
	for <linux-omap@archiver.kernel.org>; Wed,  1 Apr 2020 12:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54513206F8
	for <linux-omap@archiver.kernel.org>; Wed,  1 Apr 2020 12:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K8iDVkcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbgDAMJr (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:09:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37174 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732273AbgDAMJr (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2020 08:09:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 031C9P8a091776;
        Wed, 1 Apr 2020 07:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585742965;
        bh=5IaTEDrQgJjdu/7yF0s5OsEdojoFFxCD6wr2zUPxmbo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=K8iDVkcP72xHpSYe/uDdwDm5ZXgsOu1gOzn3PcdLALA0EwRtbuDL+KSSYr5WuzuYe
         1xCUL3gCNSuXIQ1rrW6vtuIKdhwU5mcBVNPCPW87bHLTkOvs3P2LjkWw6BHfykSfHl
         3V3KCzsShc253JQLykbFgbk3C4aoeYw1u5GoQWi0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 031C9PhF104321;
        Wed, 1 Apr 2020 07:09:25 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 1 Apr
 2020 07:09:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 1 Apr 2020 07:09:25 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 031C9M50101834;
        Wed, 1 Apr 2020 07:09:23 -0500
Subject: Re: [PATCHv2 18/56] drm/omap: panel-dsi-cm: use common MIPI DCS 1.3
 defines
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh@kernel.org>, <linux-omap@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <kernel@collabora.com>
References: <20200224232126.3385250-1-sebastian.reichel@collabora.com>
 <20200224232126.3385250-19-sebastian.reichel@collabora.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <2ce834ec-6025-24c9-2045-9949562bf828@ti.com>
Date:   Wed, 1 Apr 2020 15:09:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224232126.3385250-19-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 25/02/2020 01:20, Sebastian Reichel wrote:
> Drop local definition of common MIPI DCS 1.3 defines.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>   drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
