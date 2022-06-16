Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EDBCCA47A
	for <linux-omap@archiver.kernel.org>; Thu, 16 Jun 2022 08:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376652AbiFPIya (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 16 Jun 2022 04:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359801AbiFPIyR (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jun 2022 04:54:17 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34A825E15A;
        Thu, 16 Jun 2022 01:52:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AD90D812F;
        Thu, 16 Jun 2022 08:46:55 +0000 (UTC)
Date:   Thu, 16 Jun 2022 11:51:41 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <YqrvHSjiRGLC4z9p@atomide.com>
References: <20220615062455.15490-1-tony@atomide.com>
 <YqmjnaawQ2gye/pe@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqmjnaawQ2gye/pe@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [220615 09:12]:
> However, I dunno if it will get a lot of benefit, would be nice to see
> bloat-o-meter output for your variant and my proposal.

Yup this saves some instructions, I'm seeing a 0.19% reduction.

Regards,

Tony
