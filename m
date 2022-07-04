Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA29BC43334
	for <linux-omap@archiver.kernel.org>; Mon,  4 Jul 2022 07:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiGDH0o (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 4 Jul 2022 03:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiGDH0o (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jul 2022 03:26:44 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41AD365E7
        for <linux-omap@vger.kernel.org>; Mon,  4 Jul 2022 00:26:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3DBEF80C1;
        Mon,  4 Jul 2022 07:21:18 +0000 (UTC)
Date:   Mon, 4 Jul 2022 10:26:41 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Liang He <windhl@126.com>
Cc:     linux-omap@vger.kernel.org
Subject: Re: [PATCH v3] arm: mach-omap2: omap4-common: Fix refcount leak bug
Message-ID: <YsKWMdKPZzI06RXP@atomide.com>
References: <20220628112939.160737-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628112939.160737-1-windhl@126.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Liang He <windhl@126.com> [220628 14:24]:
> In omap4_sram_init(), of_find_compatible_node() will return a node
> pointer with refcount incremented. We should use of_node_put() when
> it is not used anymore.

Thanks applying into omap-for-v5.20/soc.

Tony
