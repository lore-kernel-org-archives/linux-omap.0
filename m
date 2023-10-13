Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C4ACDB47E
	for <linux-omap@archiver.kernel.org>; Fri, 13 Oct 2023 08:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjJMIBK (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 13 Oct 2023 04:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJMIBJ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 13 Oct 2023 04:01:09 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EFA9B8;
        Fri, 13 Oct 2023 01:01:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4864880A2;
        Fri, 13 Oct 2023 08:01:07 +0000 (UTC)
Date:   Fri, 13 Oct 2023 11:01:05 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ARM: OMAP1: ams-delta: Fix MODEM initialization
 failure
Message-ID: <20231013080105.GG34982@atomide.com>
References: <20231011175038.1907629-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011175038.1907629-1-jmkrzyszt@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [231011 20:50]:
> v2: Trim down the warning for prettier git log output (Tony).

Thanks for updating it.

> Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14")

Applying into fixes.

Thanks,

Tony
