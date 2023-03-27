Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F5DC7619A
	for <linux-omap@archiver.kernel.org>; Mon, 27 Mar 2023 07:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjC0HLZ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjC0HLY (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 27 Mar 2023 03:11:24 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC41F422C;
        Mon, 27 Mar 2023 00:11:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 417618108;
        Mon, 27 Mar 2023 07:11:23 +0000 (UTC)
Date:   Mon, 27 Mar 2023 10:11:21 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     cgel.zte@gmail.com
Cc:     aaro.koskinen@iki.fi, jmkrzyszt@gmail.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] ARM: omap1: remove redundant variables err
Message-ID: <20230327071121.GR7501@atomide.com>
References: <20220830142136.299373-1-cui.jinpeng2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830142136.299373-1-cui.jinpeng2@zte.com.cn>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* cgel.zte@gmail.com <cgel.zte@gmail.com> [220830 17:14]:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> Rturn value directly from platform_device_register()
> instead of getting value from redundant variable err.

Sorry looks like this is still pending, applying into
omap-for-v6.4/omap1 thanks.

Tony
