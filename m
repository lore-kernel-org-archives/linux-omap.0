Return-Path: <SRS0=ENkJ=CL=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3809CC43461
	for <linux-omap@archiver.kernel.org>; Wed,  2 Sep 2020 15:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1722C20826
	for <linux-omap@archiver.kernel.org>; Wed,  2 Sep 2020 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599060608;
	bh=7VArxsirM7MWSSuesMf8ry8JGHAwP+ti3mTL7EnExKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xNj3C66pnDCveOuFfqws8e9QgnMzZiiBc9bQ9en+hLbSm4G7Boewaccwacj4D5hS5
	 R0KXnh8VujMuk0gt2zaE2L223ZI/RVqEpkrTudrDVU+T7kLyj1xIlOmLn0dKBOsprm
	 Lz45/mzzVVp214FD72h/2VOqzDPqC6kdtqMYyjbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgIBPaF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:30:05 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:41311 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgIBP3j (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 2 Sep 2020 11:29:39 -0400
Received: by mail-ej1-f65.google.com with SMTP id lo4so7240817ejb.8;
        Wed, 02 Sep 2020 08:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ehqFNeLfYlTgzhjXsHjpxPHQB/qAgGP+bEZCpgojj5E=;
        b=IkRqLdZBkNQ4pFkAZ2mhpLhO+gCpJ0bTqpJyf3XivXYTCuj1I2TOlX99pVs5H9jaN8
         e9zyhwIyzh72MHaqSZ7g/gwNMliFBvYbEW7RWzVGwWEygyMSSJqwZbCWctGufcTK3oAq
         oVIhpWSgTsONk3msd31Mb/Xfj1FXYETcKh0aPkdeS4e2KNdO3K2qo26iDTTj9H8xEzz0
         wWkmnOLEAu1G9kOMJAgY6hPzv4/tlpVHBCeUFQMIKerJfNHn/2M2Hw8UP8f22bjHalqW
         ijt1N+XKwOu9lWdOUQ1bsiutwuM5jtBpRsf+/KR2D655LWryIHRocfQ5iBuHn/GTYz8G
         wHnA==
X-Gm-Message-State: AOAM532Iqly3V4TLI7D1AXXa/i0ZMvmwk40ZaOo39cqDqV48Sdn5DqRp
        rDBHGZ+UmpkTEDGS3rTRplamOk4gmQnBrQ==
X-Google-Smtp-Source: ABdhPJwUN0BtGTTfUP4Xy44jcruznJYTW75f8W7prpQVrUstD60vT1TKImhOHy/NbwctTiBfW/3HTg==
X-Received: by 2002:a17:907:270f:: with SMTP id w15mr562515ejk.141.1599060575101;
        Wed, 02 Sep 2020 08:29:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id r15sm4351182edv.94.2020.09.02.08.29.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 08:29:34 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:29:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     rogerq@ti.com, tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 -next] memory: omap-gpmc: Fix -Wunused-function
 warnings
Message-ID: <20200902152932.GA20369@kozik-lap>
References: <20200901035642.22772-1-yuehaibing@huawei.com>
 <20200901112832.3084-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200901112832.3084-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Tue, Sep 01, 2020 at 07:28:32PM +0800, YueHaibing wrote:
> If CONFIG_OF is not set, make W=1 warns:
> 
> drivers/memory/omap-gpmc.c:987:12: warning: ‘gpmc_cs_remap’ defined but not used [-Wunused-function]
>  static int gpmc_cs_remap(int cs, u32 base)
>             ^~~~~~~~~~~~~
> drivers/memory/omap-gpmc.c:926:20: warning: ‘gpmc_cs_get_name’ defined but not used [-Wunused-function]
>  static const char *gpmc_cs_get_name(int cs)
>                     ^~~~~~~~~~~~~~~~
> drivers/memory/omap-gpmc.c:919:13: warning: ‘gpmc_cs_set_name’ defined but not used [-Wunused-function]
>  static void gpmc_cs_set_name(int cs, const char *name)
>              ^~~~~~~~~~~~~~~~
> Move them to #ifdef CONFIG_OF block to fix this.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v3: move the functions to #ifdef block
> v2: update commit log
> ---
>  drivers/memory/omap-gpmc.c | 114 ++++++++++++++++++-------------------

Thanks, applied.

Best regards,
Krzysztof

