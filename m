Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36C9C433F5
	for <linux-omap@archiver.kernel.org>; Mon, 11 Apr 2022 10:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbiDKK5i (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbiDKK5h (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 11 Apr 2022 06:57:37 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9C4C3B2A8;
        Mon, 11 Apr 2022 03:55:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EEFCC809F;
        Mon, 11 Apr 2022 10:52:52 +0000 (UTC)
Date:   Mon, 11 Apr 2022 13:55:22 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] serial: core: Add support of runtime PM
Message-ID: <YlQJGrzyb3ymq0Vm@atomide.com>
References: <20211115084203.56478-1-tony@atomide.com>
 <20211115084203.56478-2-tony@atomide.com>
 <YaX82wxybOZnPKpy@hovoldconsulting.com>
 <YbGwaOj0ZbEuNEPA@atomide.com>
 <YbHb7HRGGFRBorB7@smile.fi.intel.com>
 <YeaLL0cJFeIhz1Tr@atomide.com>
 <YlQEoNDYRtoHDL68@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlQEoNDYRtoHDL68@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [220411 10:37]:
> I'm a bit off of the UART work nowadays, but luckily we have Ilpo who is
> pretty much ramped up on the topic. Please, include him in all your work
> WRT 8250 UART improvements. I hope Ilpo might have time to test the patch
> mentioned in this message or give an idea how to do better, if possibly.

OK, I'll be sending out a preparatory patch that starts managing serial
port devices in addition to serial port with serial_core.c.

Regards,

Tony
