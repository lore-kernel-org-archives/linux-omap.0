Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C255DC77B73
	for <linux-omap@archiver.kernel.org>; Wed, 31 May 2023 05:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjEaFcR (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 31 May 2023 01:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjEaFcR (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 31 May 2023 01:32:17 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F085A11F;
        Tue, 30 May 2023 22:32:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 33B458164;
        Wed, 31 May 2023 05:32:06 +0000 (UTC)
Date:   Wed, 31 May 2023 08:32:04 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Prathu Baronia <quic_pbaronia@quicinc.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: omap1: replace printk() with pr_err macro
Message-ID: <20230531053204.GW14287@atomide.com>
References: <20230518103324.881394-1-quic_pbaronia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518103324.881394-1-quic_pbaronia@quicinc.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Prathu Baronia <quic_pbaronia@quicinc.com> [230518 13:34]:
> Use pr_err() macro instead of printk(KERN_ERR "...").

Thanks applying into omap-for-v6.5/cleanup.

Tony
