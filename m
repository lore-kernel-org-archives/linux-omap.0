Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FF0C77B7F
	for <linux-omap@archiver.kernel.org>; Mon,  8 May 2023 11:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjEHLIq (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 8 May 2023 07:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjEHLIZ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 8 May 2023 07:08:25 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F84E33D54;
        Mon,  8 May 2023 04:08:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C92F28111;
        Mon,  8 May 2023 11:08:18 +0000 (UTC)
Date:   Mon, 8 May 2023 14:08:17 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>, Johan Hovold <johan@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] serial: 8250: omap: Fix freeing of resources on
 failed register
Message-ID: <20230508110817.GW14287@atomide.com>
References: <20230508082014.23083-1-tony@atomide.com>
 <20230508082014.23083-2-tony@atomide.com>
 <9ea78388-86f-736b-e46-b3bc6223ddbe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ea78388-86f-736b-e46-b3bc6223ddbe@linux.intel.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [230508 09:55]:
> An unrelated comment to the patch itself, there seems to be somewhat 
> handwavy and possibly wrong calculation for the pm qos latency. First of 
> all, I think it would want something based on port->frame_time, and I'm 
> far from convinced that 64 is right as it matches FIFO size which doesn't 
> feel correct for a wakeup related time.

Thanks for spotting it, good point. I'll take a look at that in a separate
patch.

Regards,

Tony
