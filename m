Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E96C4338F
	for <linux-omap@archiver.kernel.org>; Fri,  6 Aug 2021 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF79060ED6
	for <linux-omap@archiver.kernel.org>; Fri,  6 Aug 2021 10:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbhHFKFI (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 6 Aug 2021 06:05:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43392 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhHFKFH (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2021 06:05:07 -0400
Received: from localhost (unknown [149.11.102.75])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 73F62501F51E5;
        Fri,  6 Aug 2021 03:04:50 -0700 (PDT)
Date:   Fri, 06 Aug 2021 11:04:44 +0100 (BST)
Message-Id: <20210806.110444.1042687466668709790.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        ben.hutchings@essensium.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, lokeshvutla@ti.com
Subject: Re: [PATCH net-next 0/3] net: ethernet: ti: cpsw/emac: switch to
 use skb_put_padto()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <49dbe558-cf18-484b-9167-e43ad1c83db5@ti.com>
References: <20210805145555.12182-1-grygorii.strashko@ti.com>
        <162824220602.18289.6086651097784470216.git-patchwork-notify@kernel.org>
        <49dbe558-cf18-484b-9167-e43ad1c83db5@ti.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 06 Aug 2021 03:04:52 -0700 (PDT)
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 6 Aug 2021 13:00:30 +0300

> 
> I'm very sorry again - can it be dropped?

Easiest is for you to send a fixup or a revert to the list, thanks.


