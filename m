Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259A3C433EF
	for <linux-omap@archiver.kernel.org>; Mon, 11 Apr 2022 10:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiDKKfv (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbiDKKfu (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 11 Apr 2022 06:35:50 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CBB6434B6;
        Mon, 11 Apr 2022 03:33:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EA2B0809F;
        Mon, 11 Apr 2022 10:31:04 +0000 (UTC)
Date:   Mon, 11 Apr 2022 13:33:34 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH 2/2] serial: 8250: Fix runtime PM for start_tx() for
 empty buffer
Message-ID: <YlQD/gvwYp+cJxX9@atomide.com>
References: <20220411094805.45696-1-tony@atomide.com>
 <20220411094805.45696-2-tony@atomide.com>
 <YlP/P/JeZ/fS1zAK@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlP/P/JeZ/fS1zAK@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Johan Hovold <johan@kernel.org> [220411 10:10]:
> On Mon, Apr 11, 2022 at 12:48:05PM +0300, Tony Lindgren wrote:
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1677,8 +1677,10 @@ static void serial8250_start_tx(struct uart_port *port)
> >  
> >  	serial8250_rpm_get_tx(up);
> >  
> > -	if (!port->x_char && uart_circ_empty(&port->state->xmit))
> > +	if (!port->x_char && uart_circ_empty(&port->state->xmit)) {
> > +		serial8250_rpm_put_tx(up);
> >  		return;
> > +	}
> 
> Move this before the runtime pm get instead?

Yup good idea.

Tony
