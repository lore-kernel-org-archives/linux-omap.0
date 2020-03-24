Return-Path: <SRS0=9peH=5J=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8AFC54FCF
	for <linux-omap@archiver.kernel.org>; Tue, 24 Mar 2020 04:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7062A20724
	for <linux-omap@archiver.kernel.org>; Tue, 24 Mar 2020 04:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgCXERG (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 24 Mar 2020 00:17:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56058 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCXERF (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2020 00:17:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CCD25157141E6;
        Mon, 23 Mar 2020 21:17:04 -0700 (PDT)
Date:   Mon, 23 Mar 2020 21:17:03 -0700 (PDT)
Message-Id: <20200323.211703.1079926018361499605.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     richardcochran@gmail.com, lokeshvutla@ti.com, tony@atomide.com,
        nsekhar@ti.com, m-karicheri2@ti.com, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 00/11] net: ethernet: ti: cpts: add irq and
 HW_TS_PUSH events
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200320194244.4703-1-grygorii.strashko@ti.com>
References: <20200320194244.4703-1-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Mar 2020 21:17:05 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 20 Mar 2020 21:42:33 +0200

> Dependency:
>  ff7cf1822b93 kthread: mark timer used by delayed kthread works as IRQ safe
>  which was merged in -next, but has to be back-ported for testing with earlier
>  versions

I don't see this commit in my net-next tree so I cannot merge this.
