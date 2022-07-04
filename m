Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA3C433EF
	for <linux-omap@archiver.kernel.org>; Mon,  4 Jul 2022 07:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiGDHUK (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 4 Jul 2022 03:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGDHUK (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jul 2022 03:20:10 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73F2C2ACD;
        Mon,  4 Jul 2022 00:20:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8ED0780C1;
        Mon,  4 Jul 2022 07:14:44 +0000 (UTC)
Date:   Mon, 4 Jul 2022 10:20:07 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, aaro.koskinen@iki.fi,
        jmkrzyszt@gmail.com
Subject: Re: [PATCH] ARM: omap1: call platform_device_put() in error case in
 omap1_dm_timer_init()
Message-ID: <YsKUp0ynGBHrDjeR@atomide.com>
References: <20220701094602.2365099-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701094602.2365099-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Yang Yingliang <yangyingliang@huawei.com> [220701 12:30]:
> If platform_device_add() is not called or failed, it should call
> platform_device_put() in error case.

Thanks applying into omap-for-v5.20/omap1.

Regards,

Tony
