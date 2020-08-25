Return-Path: <SRS0=udoo=CD=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8D7C433DF
	for <linux-omap@archiver.kernel.org>; Tue, 25 Aug 2020 15:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D6E2067C
	for <linux-omap@archiver.kernel.org>; Tue, 25 Aug 2020 15:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHYPvJ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgHYPvG (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 25 Aug 2020 11:51:06 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB0C061574;
        Tue, 25 Aug 2020 08:51:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 54D9F1344473D;
        Tue, 25 Aug 2020 08:34:19 -0700 (PDT)
Date:   Tue, 25 Aug 2020 08:51:05 -0700 (PDT)
Message-Id: <20200825.085105.471804029075197026.davem@davemloft.net>
To:     m-karicheri2@ti.com
Cc:     kuba@kernel.org, grygorii.strashko@ti.com, nsekhar@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net v3 PATCH 2/2] net: ethernet: ti: cpsw_new: fix clean up
 of vlan mc entries for host port
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200824151053.18449-2-m-karicheri2@ti.com>
References: <20200824151053.18449-1-m-karicheri2@ti.com>
        <20200824151053.18449-2-m-karicheri2@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 25 Aug 2020 08:34:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Murali Karicheri <m-karicheri2@ti.com>
Date: Mon, 24 Aug 2020 11:10:53 -0400

> To flush the vid + mc entries from ALE, which is required when a VLAN
> interface is removed, driver needs to call cpsw_ale_flush_multicast()
> with ALE_PORT_HOST for port mask as these entries are added only for
> host port. Without this, these entries remain in the ALE table even
> after removing the VLAN interface. cpsw_ale_flush_multicast() calls
> cpsw_ale_flush_mcast which expects a port mask to do the job.
> 
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

Applied and queued up for -stable.
