Return-Path: <SRS0=U0Rm=47=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC38C1975A
	for <linux-omap@archiver.kernel.org>; Sat, 14 Mar 2020 03:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBCF2074D
	for <linux-omap@archiver.kernel.org>; Sat, 14 Mar 2020 03:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgCNDuq (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 13 Mar 2020 23:50:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48586 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgCNDuq (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2020 23:50:46 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 92A7C15A15BB7;
        Fri, 13 Mar 2020 20:50:45 -0700 (PDT)
Date:   Fri, 13 Mar 2020 20:50:45 -0700 (PDT)
Message-Id: <20200313.205045.317042655421471167.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     richardcochran@gmail.com, lokeshvutla@ti.com, tony@atomide.com,
        nsekhar@ti.com, m-karicheri2@ti.com, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/11] net: ethernet: ti: cpts: add irq support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200313224914.5997-10-grygorii.strashko@ti.com>
References: <20200313224914.5997-1-grygorii.strashko@ti.com>
        <20200313224914.5997-10-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 13 Mar 2020 20:50:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Sat, 14 Mar 2020 00:49:12 +0200

> diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
> index fcfd578b81ed..7156d343425d 100644
> --- a/drivers/net/ethernet/ti/cpts.c
> +++ b/drivers/net/ethernet/ti/cpts.c
> @@ -103,6 +103,7 @@ static int cpts_fifo_read(struct cpts *cpts, int match)
>  	unsigned long flags;
>  	int i, type = -1;
>  	u32 hi, lo;
> +	bool need_schedule = false;

Reverse christmas tree, please.
