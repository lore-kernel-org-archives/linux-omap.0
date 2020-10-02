Return-Path: <SRS0=L0Mx=DJ=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6896FC4363D
	for <linux-omap@archiver.kernel.org>; Fri,  2 Oct 2020 12:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D7B206DC
	for <linux-omap@archiver.kernel.org>; Fri,  2 Oct 2020 12:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s+WbHlRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJBMuP (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:50:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34948 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgJBMuP (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2020 08:50:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 092Co1Ka007386;
        Fri, 2 Oct 2020 07:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601643001;
        bh=CC4gXG7aOGKfKxxsAnloTCn02Xxbpxqr/NTxKczU0gY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=s+WbHlRIu9FrV6twoahUa8T/1Gme1GZ709ooQUCOqMu16Ok3a04UOO05Y7iqo6WiZ
         KS/aZYAMVZHeLae1kb7Uap9S1LWr9c421hwnQFf8RKw+xwgrBqTZOlmQTzMTURnY1h
         qCVkBRaVaHWjmjrCGys4ZlmjaiGfrv9u59Ks+UXQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 092Co1cM097252
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Oct 2020 07:50:01 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 07:50:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 2 Oct 2020 07:50:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 092Co0oD120957;
        Fri, 2 Oct 2020 07:50:00 -0500
Date:   Fri, 2 Oct 2020 07:50:00 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
CC:     Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: ti: Enable networking options
 for nfs boot
Message-ID: <20201002125000.5b5kho4e5de7jjrj@akan>
References: <20201001202725.16034-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201001202725.16034-1-grygorii.strashko@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 23:27-20201001, Grygorii Strashko wrote:
> Enable networking options required for NFS boot on TI platforms, which is
> widely for automated test systems.
> - enable new TI CPSW switch driver and related NET_SWITCHDEV config
> - enable TI DP83867 phy
> - explicitly enable PTP clock support to ensure dependent networking
> drivers will stay built-in
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 

[...]

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
