Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBACCCA47E
	for <linux-omap@archiver.kernel.org>; Tue, 28 Jun 2022 05:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbiF1FKT (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 28 Jun 2022 01:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244388AbiF1FKS (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2022 01:10:18 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C2BF9FCF;
        Mon, 27 Jun 2022 22:10:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E87538106;
        Tue, 28 Jun 2022 05:05:04 +0000 (UTC)
Date:   Tue, 28 Jun 2022 08:10:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Paul Walmsley <paul@pwsan.com>,
        Russell King <linux@armlinux.org.uk>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2: Fix refcount leak in omap3xxx_prm_late_init
Message-ID: <YrqNN6dAISFGbcaO@atomide.com>
References: <20220526073724.21169-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526073724.21169-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Miaoqian Lin <linmq006@gmail.com> [220526 10:33]:
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.

Thanks applying into omap-for-v5.10/soc.

Tony
