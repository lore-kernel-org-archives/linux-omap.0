Return-Path: <SRS0=PuJa=4O=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A889FC4BA13
	for <linux-omap@archiver.kernel.org>; Wed, 26 Feb 2020 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7705A2467B
	for <linux-omap@archiver.kernel.org>; Wed, 26 Feb 2020 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582735377;
	bh=SNhpkmwpPzdNx6pHbNYuQSm52rtYQ/VqzBwVUvf8a9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=az4NUr9BflFn7g4ylXQrdNMxBz6IlzflmKEtsL4haWaEm0OAXwAZ9ERMn1njrJJ/j
	 +1kSf7xJrsEYJ2QY5PH8JFDbyDTjzkr6VQVFxOszOIhOgCqN6LEK9Bf40mI4PuqNq+
	 6n+oaVRK1V0OWdkOqsRD5Qfa1txwB1CZcisahbUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgBZQm4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:42:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41198 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBZQm4 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 26 Feb 2020 11:42:56 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so115742oie.8;
        Wed, 26 Feb 2020 08:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eY/fUT/C6oQ+QC1Pf/KsMcbEMs5cnwFzzHJNeLH63I8=;
        b=W8QTrGfRrgmgENYs9NHw4vwjUacGv6J04ylPQGffTtUki17JwjpaSypJU6truuhQ7l
         O+qNIEIXFkG5xJscTPkgqfWWA2LM3kKB8pFoieakar4zU/MOl/de+ZHnMTBozUd7goc0
         LN2PvVK4FUTDYlPeK16li19Kh7xBq/TGXqUrEYrUAcQI6be39kGDiwOBbz0uwoue8UfW
         e6dMgf65Zgvk9s/8MjAtjLXV3K2DNo+2r6bKefnjyb38R9LTCrV5xn5YKGfRmpWLA01C
         W+cNU7/NYxxnAoJo4x33w3BLnZETO+UtPNLx1IG27CDR4y2Y2+IvaWI/eW/bokvIcyis
         9EXQ==
X-Gm-Message-State: APjAAAVJfhIt/albPuRSyLfnbLWwECIAzFPTSz6urtDZOTboUrHJTQzn
        Yg2HRN6wMlpkFjwC1tCtCLMl5jfhLg==
X-Google-Smtp-Source: APXvYqwuFuJGSLcpUl13Q/1bN0T2897C4B8RcNWIhS7t01d1JzVHOG6PYlE8aPe2Vxsf6j+6u0q5vQ==
X-Received: by 2002:aca:3354:: with SMTP id z81mr3882297oiz.129.1582735375610;
        Wed, 26 Feb 2020 08:42:55 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f1sm946487otq.4.2020.02.26.08.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 08:42:54 -0800 (PST)
Received: (nullmailer pid 11570 invoked by uid 1000);
        Wed, 26 Feb 2020 16:42:54 -0000
Date:   Wed, 26 Feb 2020 10:42:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: mfd: motmdm: Add binding for
 motorola-mdm
Message-ID: <20200226164254.GA11512@bogus>
References: <20200220195943.15314-1-tony@atomide.com>
 <20200220195943.15314-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220195943.15314-4-tony@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Thu, 20 Feb 2020 11:59:42 -0800, Tony Lindgren wrote:
> Add a binding document for Motorola modems controllable by
> TS 27.010 UART line discipline using serdev drivers.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../mfd/motorola,mapphone-mdm6600.yaml        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
