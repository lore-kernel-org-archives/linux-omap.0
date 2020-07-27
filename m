Return-Path: <SRS0=9aII=BG=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA590C433E4
	for <linux-omap@archiver.kernel.org>; Mon, 27 Jul 2020 08:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3822070B
	for <linux-omap@archiver.kernel.org>; Mon, 27 Jul 2020 08:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595837770;
	bh=MPyFWXSZMImoVE4V6Abj0NcJRcQ88TQd+X6EEqL144U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b5i8zM1nFDGXS07RSUrvRxtwMcOLdIVfXQSLLvVWooGBDkxObqy9FhXs/iWU2PyE4
	 ryftPNLcyBTYBdJMOLWHlIFAqQJ4Zl9c6T4I3HZdg9ZaZgd6IVy76obi4gGq8/cSIB
	 HuXsXnOSQVsvfLjtR/EEfVx3fMFrWFyaIqXLxUHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgG0IQH (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:16:07 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:45080 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgG0IQG (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2020 04:16:06 -0400
Received: by mail-ej1-f68.google.com with SMTP id g7so7850991ejw.12;
        Mon, 27 Jul 2020 01:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BVm9KZ1ItmtQcoQoho+nku6oWIHjiniWmY/d+r5eHn0=;
        b=Z0BZl7xHxFmiiXt3PIwAeWMGWaLCc0Nqej2/qoWJOqFGhpbzU0c0M0YthiHfIIbgou
         J7KQa2s6GzTIeBMv3OEA+vLB4KCD8FN0pNqSePk6FfIU6ftja/XvtR5KeWzahxnViNvD
         x0sGGNc2kaMhXRVDtPhAQFmR7WGS1/pOOeoQDGvyrHom7uTmIBGBGhJi46m0wgnuTKMI
         QBe6TZTqIBsax1hica01jGxSKBT/5YwSZndxZQb0/p2ms0a+YosR/ZvdBEu8VmpYBvhw
         wdY7m5bwrKlPnqxeXt6uxI1AwYX4kTAHjNI4uX4p+3znJ+mlz9UxK+dqggr1WsJG1Ix6
         n75Q==
X-Gm-Message-State: AOAM531aZEp038ofW5OScgvmXjGLyt8vHS1ZJ3YpriIuApEVYgnwoILr
        Wx0zEv/CYv2KrvtJbwYXiGc=
X-Google-Smtp-Source: ABdhPJy9X/SPQJRXF2VPAVbGEnLO0h8KCgWUYwxBATSXbJFyOWs5bdwKPjJ2ePIJKHiSVsVbpKOisw==
X-Received: by 2002:a17:906:7709:: with SMTP id q9mr19541353ejm.123.1595837764415;
        Mon, 27 Jul 2020 01:16:04 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id by3sm5043491ejb.9.2020.07.27.01.16.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:16:03 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:16:01 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/16] memory: omap-gpmc: Enclose macro argument usage in
 parenthesis
Message-ID: <20200727081601.GE17644@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724182328.3348-6-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, Jul 24, 2020 at 08:23:17PM +0200, Krzysztof Kozlowski wrote:
> Macros arguments should be enclosed by parenthesis for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied to drivers/memory tree.

Best regards,
Krzysztof
