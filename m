Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EFCC4338F
	for <linux-omap@archiver.kernel.org>; Fri,  6 Aug 2021 23:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC76961164
	for <linux-omap@archiver.kernel.org>; Fri,  6 Aug 2021 23:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhHFXaX (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 6 Aug 2021 19:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhHFXaV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 6 Aug 2021 19:30:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7664B61104;
        Fri,  6 Aug 2021 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628292605;
        bh=DYy+ZIaxswpVjqjePpN6rabkMlJ9RAKKiv/OClreniw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lsUKtkBhihz2HQW6zhyViztoJJCpVlr8W4V6CNJzSX6LPRQk1oaqbBRJZdfDSYepR
         HRQxbTKiPmFX198r5SpWV+VUhY+Y+Tg6LfKU1nuiVvsPtkftyzwpHXZZ4OKaxozqhN
         Jdod+702tD9TjWdevbxOa77iNjTftyZ9dNI9YSky9mQ8ARcg1tgAh+Pl2SzZBpE0wa
         HfxsjtYlIIvVg41Ra3+FHVjjaAiiHK71VRwAJAU+4dT/oj3WLOIDTE86ZF8MISC6iJ
         QsIjySZOa+y1f5EEvzvzA+TDQCz80gBnd6mFv0BMs4+yZSKo4S7wCOtWSwtLI0+6X2
         1NTiEbKX222TQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_cpdma: revert "drop frame
 padding"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162829260541.19160.13562237803383676607.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Aug 2021 23:30:05 +0000
References: <20210806142809.15069-1-grygorii.strashko@ti.com>
In-Reply-To: <20210806142809.15069-1-grygorii.strashko@ti.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, ben.hutchings@essensium.com,
        vigneshr@ti.com, linux-omap@vger.kernel.org, lokeshvutla@ti.com
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Fri, 6 Aug 2021 17:28:09 +0300 you wrote:
> This reverts commit 9ffc513f95ee ("net: ethernet: ti: davinci_cpdma: drop
> frame padding") which has depndency from not yet merged patch [1] and so
> breaks cpsw_new driver.
> 
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20210805145511.12016-1-grygorii.strashko@ti.com/
> Fixes: 9ffc513f95ee ("net: ethernet: ti: davinci_cpdma: drop frame padding")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: ti: davinci_cpdma: revert "drop frame padding"
    https://git.kernel.org/netdev/net-next/c/35ba6abb73e4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


