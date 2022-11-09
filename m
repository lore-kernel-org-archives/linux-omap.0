Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECB8C4332F
	for <linux-omap@archiver.kernel.org>; Wed,  9 Nov 2022 08:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiKIIUN (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 9 Nov 2022 03:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKIIUM (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 9 Nov 2022 03:20:12 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C3BD1CB33
        for <linux-omap@vger.kernel.org>; Wed,  9 Nov 2022 00:20:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EFF8080FB;
        Wed,  9 Nov 2022 08:10:23 +0000 (UTC)
Date:   Wed, 9 Nov 2022 10:20:09 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     paul@pwsan.com, linux@armlinux.org.uk, khilman@kernel.org,
        daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] Remove unused declarations from arm
Message-ID: <Y2tiucLEcPyTTmwv@atomide.com>
References: <20220920130110.1104272-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920130110.1104272-1-cuigaosheng1@huawei.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

* Gaosheng Cui <cuigaosheng1@huawei.com> [220920 15:53]:
> This series contains a few cleanup patches, to remove unused
> declarations which have been removed. Thanks!

FYI, let's wait a bit longer with these until we have Arnd's pending
clean-up patches in Linux next as they remove some unused functions
too.

Regards,

Tony
