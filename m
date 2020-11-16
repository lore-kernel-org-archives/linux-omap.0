Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE8DC5519F
	for <linux-omap@archiver.kernel.org>; Mon, 16 Nov 2020 23:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A6D24641
	for <linux-omap@archiver.kernel.org>; Mon, 16 Nov 2020 23:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy4tJbCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgKPXuF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 16 Nov 2020 18:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgKPXuF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 16 Nov 2020 18:50:05 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605570605;
        bh=q3wS+H3J9kjKcuqBT+lCDYUtl0zMHa8jz4ZrJptsUjI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qy4tJbCNHsE0+HplofsAMdEAXIue/6ZS6msl/YTlH1kHRrM6QcD4DX+2TlPrnPTAF
         ip8KmPdOT7Kw8MGZsHhs0zTKej7QwzjPpcfpAc1/DKZ6D1oILk+SjnjcTVmbcRBE3T
         1i8kVFY/FfOX/pQ7WlGg1SdLjiwqPF0okEf+HU+0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ti: cpsw: fix error return code in
 cpsw_probe()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160557060526.20238.18082560282045278910.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Nov 2020 23:50:05 +0000
References: <1605250173-18438-1-git-send-email-zhangchangzhong@huawei.com>
In-Reply-To: <1605250173-18438-1-git-send-email-zhangchangzhong@huawei.com>
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net, kuba@kernel.org,
        m-karicheri2@ti.com, brouer@redhat.com, richardcochran@gmail.com,
        yanaijie@huawei.com, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Fri, 13 Nov 2020 14:49:33 +0800 you wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 83a8471ba255 ("net: ethernet: ti: cpsw: refactor probe to group common hw initialization")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: cpsw: fix error return code in cpsw_probe()
    https://git.kernel.org/netdev/net/c/35f735c66511

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


