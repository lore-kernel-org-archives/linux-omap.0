Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE9BC63708
	for <linux-omap@archiver.kernel.org>; Thu,  8 Dec 2022 05:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLHFwP (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 8 Dec 2022 00:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLHFwO (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2022 00:52:14 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D327B92A37;
        Wed,  7 Dec 2022 21:52:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 26FB5804D;
        Thu,  8 Dec 2022 05:52:13 +0000 (UTC)
Date:   Thu, 8 Dec 2022 07:52:11 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/1] serial: core: Start managing serial
 controllers to enable runtime PM
Message-ID: <Y5F7i8Ee/jAQKu9n@atomide.com>
References: <20221207124305.49943-1-tony@atomide.com>
 <Y5D187ygOvDEA0UK@smile.fi.intel.com>
 <Y5D3UKLgHCT9feuC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5D3UKLgHCT9feuC@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [221207 20:28]:
> We can avoid this check by caching the platform device.
> 
> 	struct platform_device *ctrl_pdev = NULL;
> 
> 	if (...) {
> 		ctrl_pdev = to_platform_device(ctrl_dev);
> 	}
> 
> 	platform_device_del(ctrl_pdev);

OK yeah that's nicer :)

> > Shouldn't you call platform_device_unregister()?

Outside the error path it should be platform_device_unregister(),
I'll check. Thanks also for your other comments.

Regards,

Tony
