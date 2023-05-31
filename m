Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DC0C77B7C
	for <linux-omap@archiver.kernel.org>; Wed, 31 May 2023 05:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjEaFFC (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 31 May 2023 01:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjEaFFB (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 31 May 2023 01:05:01 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08356EC;
        Tue, 30 May 2023 22:05:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 546678164;
        Wed, 31 May 2023 05:04:59 +0000 (UTC)
Date:   Wed, 31 May 2023 08:04:58 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: ti-sysc: convert sysfs sprintf to sysfs_emit
Message-ID: <20230531050458.GR14287@atomide.com>
References: <20230504085522.2635-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504085522.2635-1-liubo03@inspur.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Bo Liu <liubo03@inspur.com> [230504 11:55]:
> Follow the advice of the Documentation/filesystems/sysfs.rst
> and show() should only use sysfs_emit() or sysfs_emit_at()
> when formatting the value to be returned to user space.

Thanks applying into omap-for-v6.5/ti-sysc.

Tony
