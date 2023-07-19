Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1534EB64DA
	for <linux-omap@archiver.kernel.org>; Wed, 19 Jul 2023 05:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjGSF2P (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 19 Jul 2023 01:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGSF2O (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jul 2023 01:28:14 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6335D2;
        Tue, 18 Jul 2023 22:28:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1181380AA;
        Wed, 19 Jul 2023 05:28:13 +0000 (UTC)
Date:   Wed, 19 Jul 2023 08:28:11 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Add support for dev_name:0.0 naming for
 kernel console
Message-ID: <20230719052811.GH5194@atomide.com>
References: <20230719051525.46494-1-tony@atomide.com>
 <35758c24-1543-6f96-7957-b371dc94e59d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35758c24-1543-6f96-7957-b371dc94e59d@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Jiri Slaby <jirislaby@kernel.org> [230719 05:25]:
> On 19. 07. 23, 7:15, Tony Lindgren wrote:
> > +/*
> > + * Add preferred console if configured on kernel command line with naming
> > + * "console=dev_name:0.0".
> > + */
> > +static int serial_core_add_preferred_console(struct uart_driver *drv,
> > +					     struct uart_port *port)
> > +{
> > +	char *port_match, *opt, *name;
> > +	int len, ret = 0;
> > +
> > +	port_match = kasprintf(GFP_KERNEL, "console=%s:%i.%i",
> > +			       dev_name(port->dev), port->ctrl_id,
> > +			       port->port_id);
> > +	if (!port_match)
> > +		return -ENOMEM;
> > +
> > +	opt = strstr(saved_command_line, port_match);
> > +	if (!opt)
> > +		goto free_port_match;
> > +
> > +	len = strlen(port_match);
> > +
> > +	if (strlen(opt) > len + 1 && opt[len] == ',')
> > +		opt += len + 1;
> > +	else
> > +		opt = NULL;
> > +
> > +	name = kstrdup(drv->dev_name, GFP_KERNEL);
> 
> Why do you dup the name here?

I was getting ignoring const warning, but maybe the right solution is
to just use const char *name here.. Let me check.

Regards,

Tony
