Return-Path: <SRS0=pFdr=A2=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293E7C433E5
	for <linux-omap@archiver.kernel.org>; Wed, 15 Jul 2020 20:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074892067D
	for <linux-omap@archiver.kernel.org>; Wed, 15 Jul 2020 20:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594846731;
	bh=ybEIdV7HyjnueFZ+8Obnz4ZXgIPGgarf/3fLzo5pYXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hETJvRkrkXl5t9o3d1HJ0TohsGTSFGUMpA2vKhX9kOqVsGkRCBxPbTx02qDvGs9P7
	 Urd5o7DtwMK5aiy6Y9fdRvoAw05FwS0gYwvcgIN/HmeXROjVM5ZU3b12S4qfVcGZCe
	 i9B0E1E72IQLerCpDBtyUsKq9zZ7kHnmdu3C1jVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGOU6u (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:58:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42525 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOU6t (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2020 16:58:49 -0400
Received: by mail-io1-f67.google.com with SMTP id c16so3733345ioi.9;
        Wed, 15 Jul 2020 13:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hvOlrpFh38OhJfQRgWsFESzalTDuzMi9WGh0C3h9sK8=;
        b=lK6hLt8xB4H3LpL4G/OGhS45qxk+agj+vKSSjNDhXspKTqNslZ7Olst5El1JFcPram
         fP6WIU7b13wr3UCTthcuDfehnzf2Hu/Hd6F0zROctZJSMDVONT4ScmlzcaKROZHiZ9sW
         C0mgG+mKMkLdFrozc6EO4YtY0nWxGmglmHN9yW0uKLW7s03NvoD+CuRAsDnvE758RPq6
         0xjk4gOLqOUvjmbySnAb9pdNSIZ63lZ15ZPtlJuHdN+8SENDqLqEavAkYPaK1bJM2Dmo
         PXefT8y8Med+16h1//BzicCzcVDEfVfDRN+glQh3KfvdG2aCyCPwrdJGiucIugSRUtF0
         sseQ==
X-Gm-Message-State: AOAM530/4PC35YTq4fQ8VYWhKd2kw5DJpJ76cH1wwBX/Vwvr9Cs06w7m
        L/6xi692Qs0I1zqZOTe96g==
X-Google-Smtp-Source: ABdhPJwD2sTr16al3pJVQdcYEtWu5BczxSa5mMVZBZJxKwKrlnofFmhPZ73CBtj/agbIaHc83ciPdQ==
X-Received: by 2002:a02:ccb3:: with SMTP id t19mr1387559jap.122.1594846728709;
        Wed, 15 Jul 2020 13:58:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b2sm1644211ilf.0.2020.07.15.13.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:58:48 -0700 (PDT)
Received: (nullmailer pid 805535 invoked by uid 1000);
        Wed, 15 Jul 2020 20:58:47 -0000
Date:   Wed, 15 Jul 2020 14:58:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: omap: Update PRM binding for genpd
Message-ID: <20200715205847.GA805485@bogus>
References: <20200702154513.31859-1-tony@atomide.com>
 <20200702154513.31859-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702154513.31859-2-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Thu, 02 Jul 2020 08:45:08 -0700, Tony Lindgren wrote:
> The PRM (Power and Reset Module) has a register to enable and disable
> the related power domain, so let's update the binding for that.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/prm-inst.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
