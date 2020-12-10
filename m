Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6556BC433FE
	for <linux-omap@archiver.kernel.org>; Thu, 10 Dec 2020 02:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D1923BE5
	for <linux-omap@archiver.kernel.org>; Thu, 10 Dec 2020 02:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgLJCu0 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:50:26 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33421 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgLJCuT (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2020 21:50:19 -0500
Received: by mail-oi1-f195.google.com with SMTP id d27so4169067oic.0;
        Wed, 09 Dec 2020 18:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MFCHvUT5RijyoJxSelJHIr/6zlP6ThwWe8MkcUy0U3Q=;
        b=kZzMDkCEjlNEXyH5cHd9puTHxtT2bqDsTk/H+ZQC9f707hH1dPRYTDRzg11lo8jlej
         bz7aw+cKxSFGaYg6LUISwII1Fcu8iftRTq4wAhFUsqjePSA5sBf/r7t9suej7FmYzi5L
         iXFf6k9oDufAWSULwHObRSJ+FGz4+IRWk3z8SjmslEIMnFz6ZWVxlo79Bwu2/Q5SVN+C
         aHTq88vJSWeHTuseTr1XqRhFgVT2NMtayPhfMtLfnXLbKRLVVdwPpv8YhEHpnULyDv2d
         XtSkQ1V75q/LuEwkafpxuIFrFcgXBib1jofI9CKT+khE6ZidxeiDchFhueTsnNizRU+4
         3W3w==
X-Gm-Message-State: AOAM532Eah/XEZT/HZkAbOngy5Az/dhTbfhdx9KFQ4qL2kjkHD8X2mtN
        p7Fnw90aV+aF6/nWbZzcGD6PNFs7Cw==
X-Google-Smtp-Source: ABdhPJyBPDmknnFMQtG7E+zIQ6Pse6U/HenyEqv/yKu2+DMwqq/ARZ3uWkTjg8gm1gmTTjWZyFOM0g==
X-Received: by 2002:aca:d54a:: with SMTP id m71mr1305872oig.30.1607568578810;
        Wed, 09 Dec 2020 18:49:38 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm726117oif.26.2020.12.09.18.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 18:49:37 -0800 (PST)
Received: (nullmailer pid 1543204 invoked by uid 1000);
        Thu, 10 Dec 2020 02:49:36 -0000
Date:   Wed, 9 Dec 2020 20:49:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] dt-bindings: i2c: Add compatible string for AM64 SoC
Message-ID: <20201210024936.GA1543155@robh.at.kernel.org>
References: <20201209165733.8204-1-a-govindraju@ti.com>
 <20201209165733.8204-3-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209165733.8204-3-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Wed, 09 Dec 2020 22:27:33 +0530, Aswath Govindraju wrote:
> Add compatible string for AM64 SoC in device tree binding of OMAP I2C
> modules as the same IP is used.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
