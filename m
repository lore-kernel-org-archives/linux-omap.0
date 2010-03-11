From: Tony Lindgren <tony@atomide.com>
Subject: Re: Trying to understand how to use new OMAP mux code
Date: Thu, 11 Mar 2010 14:48:12 -0800
Message-ID: <20100311224812.GU2900@atomide.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56353 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab0CKWqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 17:46:52 -0500
Content-Disposition: inline
In-Reply-To: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>
Cc: linux-omap@vger.kernel.org

* Peter Barada <peter.barada@gmail.com> [100311 14:29]:
> 1) Suppose I want to talk to a bluetooth chip through UART2.  UART2_TX
>  gives me a choice of pins to hook up to, either to pin AA26 in Mode0,
> or pin AF5 in Mode1.  If I use omape_mux_init_signal("uart2_tx",
> OMAP_PIN_OUTPUT), which pin will that map to?

You need to check the omap package type you're using to find
out the correct ball name. If you get lucky, that's already in
mux34xx.c and you don't need search through the TRMs :)
 
> 2) How can I tell the muxing code that I want a specific pin for my
> UART2_TX signal (that's not a GPIO since those can be directly
> specified by GPIO number)?

Then you want to use the full signal name:

omap_mux_init_signal("mode0_name.desired_mode", OMAP_PIN_FLAGS) 

But as the balls can be separate for each package type, you
need to figure that out first.

Regards,

Tony
