Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A01C2BBCA
	for <linux-omap@archiver.kernel.org>; Wed, 16 Dec 2020 15:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7753A233EA
	for <linux-omap@archiver.kernel.org>; Wed, 16 Dec 2020 15:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgLPPZZ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 16 Dec 2020 10:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgLPPZZ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2020 10:25:25 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D02C061794;
        Wed, 16 Dec 2020 07:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
        In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vmqbyA8EPHg3fkGc3cFk+tYUFuWETWmEPKbASEwl98M=; b=dpq+wRoEBlDe/HuUCkI1/JE9v4
        frdZRNgEtT95AObxVEmFcYsUgtgT4GTh5VeT5kjzhtwkL1o3D/nwZ+HkdiPzGinLXVEeJAPV9xDy0
        X0yQTvIqcNVjahufvZbwWs9j9avf8XWTUuYAQ0nyK8SgKzaV0nLqGr4v5TH48l1UN9U76k7C6DsEI
        PnrrK9ZDjEu2IF8mAgqPC6KfJF41OsYp1ZCp5a4DR3gXPbRBKc7EhyNTqZPYFtzaEUgJxw2uQ5Wr1
        vcnD0PB3XEABhLnhoTKDY5YkOD44iL39L98w6QrghILxqzbM26qz/kioWdW8xUySKLSx1C/r1M69S
        wGXA7EqQ==;
Received: from webng-gw.kapsi.fi ([91.232.154.200] helo=roundcube.kapsi.fi)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <jyri.sarha@iki.fi>)
        id 1kpYfO-0004eY-98; Wed, 16 Dec 2020 17:24:38 +0200
MIME-Version: 1.0
Date:   Wed, 16 Dec 2020 17:24:35 +0200
From:   Jyri Sarha <jyri.sarha@iki.fi>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, jyri.sarha@iki.fi, tomba@kernel.org,
        Sekhar Nori <nsekhar@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>
Subject: Re: [PATCH] MAINTAINERS: Update addresses for TI display drivers
In-Reply-To: <20201216075917.17481-1-tomi.valkeinen@ti.com>
References: <20201216075917.17481-1-tomi.valkeinen@ti.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <65682d92313a1ceec15969ca97ecf451@iki.fi>
X-Sender: jyri.sarha@iki.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.232.154.200
X-SA-Exim-Mail-From: jyri.sarha@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 2020-12-16 9:59, Tomi Valkeinen wrote:
> Update the maintainer email addresses for TI display drivers.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Jyri Sarha <jyri.sarha@iki.fi>

> ---
>  MAINTAINERS | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 281de213ef47..c21471497a18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5932,8 +5932,8 @@
> F:	Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
>  F:	drivers/gpu/drm/stm
> 
>  DRM DRIVERS FOR TI KEYSTONE
> -M:	Jyri Sarha <jsarha@ti.com>
> -M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
> +M:	Jyri Sarha <jyri.sarha@iki.fi>
> +M:	Tomi Valkeinen <tomba@kernel.org>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> @@ -5943,15 +5943,15 @@
> F:	Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
>  F:	drivers/gpu/drm/tidss/
> 
>  DRM DRIVERS FOR TI LCDC
> -M:	Jyri Sarha <jsarha@ti.com>
> -R:	Tomi Valkeinen <tomi.valkeinen@ti.com>
> +M:	Jyri Sarha <jyri.sarha@iki.fi>
> +R:	Tomi Valkeinen <tomba@kernel.org>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/display/tilcdc/
>  F:	drivers/gpu/drm/tilcdc/
> 
>  DRM DRIVERS FOR TI OMAP
> -M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
> +M:	Tomi Valkeinen <tomba@kernel.org>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/display/ti/
