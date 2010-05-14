From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: rx51: Move peripheral OMAP gpio setups to
 rx51_omapgpio_setup function
Date: Fri, 14 May 2010 08:33:51 -0700
Message-ID: <20100514153351.GW3428@atomide.com>
References: <1273840778-4830-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57608 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab0ENPdy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 11:33:54 -0400
Content-Disposition: inline
In-Reply-To: <1273840778-4830-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Kalle Valo <kalle.valo@iki.fi>

* Jarkko Nikula <jhnikula@gmail.com> [100514 05:32]:
> Idea is to combine peripheral OMAP gpio setups in single function like what
> rx51_twlgpio_setup is doing for TWL4030 GPIOs.
> 
> Currently this is mostly cleanup for wl1251 gpio setup as not testing the
> gpiolib return values and setting the wl1251_pdata statically. The wl1251
> driver seems to cope well with uninitialized gpios or with negative irq
> number.

We should check the return values always. If gpio_request handling
changes then we have to fix it all over the place.

Regards,

Tony
