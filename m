Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56805C64EC4
	for <linux-omap@archiver.kernel.org>; Thu,  9 Mar 2023 13:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCINHE (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 9 Mar 2023 08:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCINHD (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 9 Mar 2023 08:07:03 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B5D5B56FB;
        Thu,  9 Mar 2023 05:07:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CB63A80DE;
        Thu,  9 Mar 2023 13:07:01 +0000 (UTC)
Date:   Thu, 9 Mar 2023 15:07:00 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230309130700.GH7501@atomide.com>
References: <20230309085713.57700-1-tony@atomide.com>
 <ZAnPrwLUA/1Bsq26@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAnPrwLUA/1Bsq26@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230309 12:23]:
> On Thu, Mar 09, 2023 at 10:57:08AM +0200, Tony Lindgren wrote:
> > +	err = pm_runtime_get(port_dev);
> 
> Is not sync API a deliberate choice? Do we need to comment on why is so?

I don't think it can be sync version.. See where all __uart_start() may
get called from. The pm_runtime_get() here is needed so the check for
pm_runtime_active() won't be racy. Maybe we can now leave out the
"start TX anyways" part though.

Thanks for your other comments too, will fix up those for the next
revision.

Regards,

Tony
