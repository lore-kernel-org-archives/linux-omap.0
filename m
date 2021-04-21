Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30027C43460
	for <linux-omap@archiver.kernel.org>; Wed, 21 Apr 2021 00:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4FB61420
	for <linux-omap@archiver.kernel.org>; Wed, 21 Apr 2021 00:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhDUAUm (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233860AbhDUAUl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 20 Apr 2021 20:20:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 27B4F6141E;
        Wed, 21 Apr 2021 00:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618964409;
        bh=RIr4qco7oPvlFxUjJ0dxqYdzv23CXxpLzMd5EM5X5aY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=k6A1fg2yDSCyYK5jENBBRLdDhbFD4cC4LDsBQDA0D6dY6+N0vXinEGbOoUgz5qBG5
         XaCCIJpKS9EnBVdRd2NvVjtHgBVI8CIYlSgb81T8+McX/Skpe6/tFSW7QKIkOahmwR
         TvO04y9j52iq1zShpnclWoiRx6g4a2Op34scjFmPkHbEB51XNOy5bpuLK2HRjAePjn
         GlwgrtbB3lLuympRZFKxfb6Y0GXESb+xna+poyVLPD/b1L0GuqbtKvl8O//MygsQ8x
         yvRMq7E47w+B93PaUEYBMStL8b6lelrsB92cKSkjm81auwet6FEdIiEL+/ArPCBp5S
         pDP8SP0VYFc2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: davinci_emac: Fix incorrect masking of tx and rx error
 channel
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161896440910.12176.11466899980564946860.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Apr 2021 00:20:09 +0000
References: <20210420171614.385721-1-colin.king@canonical.com>
In-Reply-To: <20210420171614.385721-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Tue, 20 Apr 2021 18:16:14 +0100 you wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The bit-masks used for the TXERRCH and RXERRCH (tx and rx error channels)
> are incorrect and always lead to a zero result. The mask values are
> currently the incorrect post-right shifted values, fix this by setting
> them to the currect values.
> 
> [...]

Here is the summary with links:
  - net: davinci_emac: Fix incorrect masking of tx and rx error channel
    https://git.kernel.org/netdev/net/c/d83b8aa5207d

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


