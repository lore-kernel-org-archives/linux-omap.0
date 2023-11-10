Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E75C4167B
	for <linux-omap@archiver.kernel.org>; Fri, 10 Nov 2023 18:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346068AbjKJSaB (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346064AbjKJS17 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 10 Nov 2023 13:27:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83202AD35;
        Fri, 10 Nov 2023 03:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EF4CC433C7;
        Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699614024;
        bh=5al1T1jdDu+2lAGbHeFM/Y4l/1eJyWvVGIt5NoilUG8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OowxffQfbiB/ixXfRru7AMA7och/GvMwqYBHuWWYSmNUdT7f1Z1XlD4zXC8MrEDSl
         WRQyi0XDZ/FFMqf667ZCLzIGLyH3GqNLqYiPoZSwAx1PJV3MC6wBPstAAY84Mv6qDh
         3EUvVinlUVdJ+qeJhgrLMwmb64IJoGguh/sddQ1AR551axmbRKnBebtj3XpiliLTQ2
         /K9ZQxj5kaTeC2MkcYrsS5Zy5HxemwVu38yLqNBux6UlUrRziyeSkHYVtSkWK//bwb
         PdydxFO5f++VEwFGJgLn2qRIfMUM14CyqtElmAKIacuYMOwlMjg+bAxswCBkZ6VfKo
         lhRynBQAMhIFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29593C43158;
        Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] MAINTAINERS: net: Update reviewers for TI's Ethernet
 drivers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169961402416.16509.13586966017660246315.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Nov 2023 11:00:24 +0000
References: <20231110092749.3618-1-r-gunasekaran@ti.com>
In-Reply-To: <20231110092749.3618-1-r-gunasekaran@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc:     netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, s-vadapalli@ti.com, nm@ti.com,
        srk@ti.com, rogerq@kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Nov 2023 14:57:49 +0530 you wrote:
> Grygorii is no longer associated with TI and messages addressed to
> him bounce.
> 
> Add Siddharth, Roger and myself as reviewers.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> [...]

Here is the summary with links:
  - [v2] MAINTAINERS: net: Update reviewers for TI's Ethernet drivers
    https://git.kernel.org/netdev/net/c/cbe9e68e1e0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


