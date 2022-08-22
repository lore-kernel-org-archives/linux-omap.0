Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A2FC28D13
	for <linux-omap@archiver.kernel.org>; Mon, 22 Aug 2022 05:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiHVFqR (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 22 Aug 2022 01:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHVFqQ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 22 Aug 2022 01:46:16 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62408255B7;
        Sun, 21 Aug 2022 22:46:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A812480A7;
        Mon, 22 Aug 2022 05:39:09 +0000 (UTC)
Date:   Mon, 22 Aug 2022 08:46:12 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Michael Walle <michael@walle.cc>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Adam Ford <aford173@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 04/11] ARM: defconfig: drop CONFIG_SERIAL_OMAP references
Message-ID: <YwMYJD3ohx2UNMXG@atomide.com>
References: <20220818135522.3143514-1-arnd@kernel.org>
 <20220818135737.3143895-1-arnd@kernel.org>
 <20220818135737.3143895-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818135737.3143895-3-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [220818 13:51]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver is mutually exclusive with the new 8250_OMAP
> driver, so 'make defconfig' turns it off already. Drop
> the reference now.

Acked-by: Tony Lindgren <tony@atomide.com>
