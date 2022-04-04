Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309F4C48BE8
	for <linux-omap@archiver.kernel.org>; Mon,  4 Apr 2022 21:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379133AbiDDV1Y (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379220AbiDDQqH (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2022 12:46:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB7425C62;
        Mon,  4 Apr 2022 09:44:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 2so2102420pjw.2;
        Mon, 04 Apr 2022 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VidJpygdWDhsPO2PnGTUorRul6XI2t/vnWn1jdgufK8=;
        b=YHcYrPZoBx3AIEnPLlkIjp4d+DhFHUBAZNEMptQgbnoekAnP6pN4qvNlBBwE++iiC4
         5YZoEAxeSMPeIvZiA7urwvcAsay7jJzAMNJ5cEqxUA32iSJKDxWfJhsPU9SYx2ZXKm51
         NDi5IkEKmmb3DmthmBj+qAVdgYaZFrqGX37FotMqcTY7Gb0em6W5eSvuWM7AC0hZYt8O
         OkQqHYAkpGFvGZOgo2FY6dNmpHAqT4o/tBw//AQZCvg2JX79HxLkJQLVY5W1rjz7NCod
         154PV3TU1cgwzRWqbSIYIW963s70jiuYjwV8vHyoHKFkrt0B2SJgeEfaMmZgKo8Ydo8h
         r+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VidJpygdWDhsPO2PnGTUorRul6XI2t/vnWn1jdgufK8=;
        b=EJl9CCSPLiS09/Fj0DxUA7VOxwRi5uKuuidIsduqHbC8OWA3nJDekbX2JB1TtbIu/F
         TIwaeVJaR9B/y/U4wO33CEvN6z4MPhSarsPdV2+hP2or58GQ0YGqlSUokqiT7p7T5XoZ
         VJHCt7q0B8svQNoZSD/NSYUvDZR4JPegBPtpxrWFUODiNhSfQUTj8bXjc+EhvwoeFyvK
         BZZVsy46Gb5U2IOmxCiySkt5OHEV50QEt6FC/Hcg99Uad0wX23rp235rE0AoiSWD+tUT
         2gXW6XWPdpxC2uj8CKmehTRzOViJcDxAYMk8BoYXGAfOI0JMX+/hDLowkJch+GavKpVo
         iF5A==
X-Gm-Message-State: AOAM532BaIEpXbN42w33xRfket9R5GOcjZZD1D2uEWG4497o9ofdgSOF
        qpb0amc/dLHqHz5hwGsYd+A=
X-Google-Smtp-Source: ABdhPJwe7KWOFaQYr15fxkjseF+MIDSOIPq0cWUdmxxhYqC3/S001kgGbB66UaX+2wPv1A0IJWw3LA==
X-Received: by 2002:a17:902:bd95:b0:14f:40ab:270e with SMTP id q21-20020a170902bd9500b0014f40ab270emr684770pls.101.1649090650679;
        Mon, 04 Apr 2022 09:44:10 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s22-20020a056a00179600b004fb28a97abdsm14300835pfg.12.2022.04.04.09.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:44:09 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        =?iso-8859-1?q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     kernel@pengutronix.de, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5 4/9] ARM: dts: bcm283x: fix ethernet node name
Date:   Mon,  4 Apr 2022 09:44:07 -0700
Message-Id: <20220404164407.2291341-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216074927.3619425-5-o.rempel@pengutronix.de>
References: <20220216074927.3619425-1-o.rempel@pengutronix.de> <20220216074927.3619425-5-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Wed, 16 Feb 2022 08:49:22 +0100, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> It should be "ethernet@x" instead of "usbether@x" as required by Ethernet
> controller devicetree schema:
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml
> 
> This patch can potentially affect boot loaders patching against full
> node path instead of using device aliases.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
