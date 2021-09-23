Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007A3C433EF
	for <linux-omap@archiver.kernel.org>; Thu, 23 Sep 2021 15:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7CA6121F
	for <linux-omap@archiver.kernel.org>; Thu, 23 Sep 2021 15:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbhIWPHK (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:07:10 -0400
Received: from muru.com ([72.249.23.125]:36530 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241792AbhIWPHK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 23 Sep 2021 11:07:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5BDB980C0;
        Thu, 23 Sep 2021 15:06:06 +0000 (UTC)
Date:   Thu, 23 Sep 2021 18:05:36 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] serial: 8250: Implement prep_tx for power management
Message-ID: <YUyXwJnmPhm1940B@atomide.com>
References: <20210921103346.64824-1-tony@atomide.com>
 <20210921103346.64824-5-tony@atomide.com>
 <YUx399WBrMiZDhno@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUx399WBrMiZDhno@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Johan Hovold <johan@kernel.org> [210923 12:50]:
> On Tue, Sep 21, 2021 at 01:33:44PM +0300, Tony Lindgren wrote:
> > +static int serial8250_prep_tx(struct uart_port *port)
> > +{
> > +	struct uart_8250_port *up = up_to_u8250p(port);
> > +	struct device *dev = up->port.dev;
> > +	int err;
> > +
> > +	if (!(up->capabilities & UART_CAP_RPM))
> > +		return 0;
> > +
> > +	if (!pm_runtime_suspended(dev)) {
> > +		pm_runtime_mark_last_busy(dev);
> > +		return 0;
> > +	}
> > +
> > +	err = pm_request_resume(dev);
> > +	if (err < 0) {
> > +		dev_warn(dev, "prep_tx wakeup failed: %d\n", err);
> > +		return err;
> > +	}
> 
> How is this supposed to work without a runtime PM usage-counter
> increment? What's to prevent the port from suspending again while it's
> transmitting?

Hmm yeah we should at pm_runtime_get() and pm_runtime_put() to write()
unless serial8250_rpm_get() and serial8250_rpm_put() are doing it.

Or pair prep with finish and deal with the usage count there.

Regards,

Tony
