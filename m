Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38A9C433EF
	for <linux-omap@archiver.kernel.org>; Mon,  4 Jul 2022 07:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiGDHXU (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 4 Jul 2022 03:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiGDHXS (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jul 2022 03:23:18 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04BAB62EF
        for <linux-omap@vger.kernel.org>; Mon,  4 Jul 2022 00:23:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 218F480C1;
        Mon,  4 Jul 2022 07:17:53 +0000 (UTC)
Date:   Mon, 4 Jul 2022 10:23:16 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Liang He <windhl@126.com>
Cc:     p.zabel@pengutronix.de, linux-omap@vger.kernel.org
Subject: Re: Re:Re: [PATCH v2] bus/ti-sys: Fix refcount leak bugs
Message-ID: <YsKVZG8ITDSNkMPI@atomide.com>
References: <20220620145619.4074665-1-windhl@126.com>
 <YrqZX+bwQYQNgZ6m@atomide.com>
 <462f1827.4050.181a8edfab0.Coremail.windhl@126.com>
 <72f5a5a8.42a3.181a8fb4c13.Coremail.windhl@126.com>
 <YrqhBcq3exSgiJkC@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrqhBcq3exSgiJkC@atomide.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [220628 07:06]:
> * Liang He <windhl@126.com> [220628 06:19]:
> > I have re-checked the sysc_init_stdout_path(), I think the second of_node_put 
> > is not needed as the second 'np' will be escaped out into global 'stdout_path'.
> 
> Yup you're right, thanks for checking it.

Applying into omap-for-v5.20/ti-sysc thanks.

Tony
