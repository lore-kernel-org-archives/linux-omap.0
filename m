Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F9AC678D4
	for <linux-omap@archiver.kernel.org>; Mon,  6 Mar 2023 07:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCFHmD (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 6 Mar 2023 02:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCFHmC (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 6 Mar 2023 02:42:02 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25BEC1E1F6
        for <linux-omap@vger.kernel.org>; Sun,  5 Mar 2023 23:42:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 813838027;
        Mon,  6 Mar 2023 07:42:01 +0000 (UTC)
Date:   Mon, 6 Mar 2023 09:42:00 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>, Bin Liu <b-liu@ti.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: am335x: performnce issues with FTDI and LOW_LATENCY
Message-ID: <20230306074200.GD7501@atomide.com>
References: <CAGm1_kuc0T5xqdQU0JVbetz+pMZb2=v=jhpgmfvZQhAiPdAG=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGm1_kuc0T5xqdQU0JVbetz+pMZb2=v=jhpgmfvZQhAiPdAG=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Yegor Yefremov <yegorslists@googlemail.com> [230228 08:01]:
> Any idea why the performance drop is so big?

Maybe lots of interrupts and dma not being used for musb in this case?

Tony
