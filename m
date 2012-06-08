From: Tony Lindgren <tony@atomide.com>
Subject: Re: suspend broken on 3.5-rc1?
Date: Fri, 8 Jun 2012 03:56:12 -0700
Message-ID: <20120608105611.GO12766@atomide.com>
References: <4FD1D570.1010508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32964 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267Ab2FHK4P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 06:56:15 -0400
Content-Disposition: inline
In-Reply-To: <4FD1D570.1010508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: loml <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>

* Rajendra Nayak <rnayak@ti.com> [120608 03:40]:
> Hi,
> 
> I don;t seem to be able to get suspend to work on 3.5-rc1 on
> my 4430 panda. I am not sure if its UART wakeups that are
> an issue or suspend itself is broken.
> Is there anything more than setting
> '/sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup'
> to 'enabled' that I need to do to get UART to be wakeup capable?
> 
> 3.4 major works just fine for me.

Can you try with the fixes branch that Olof just merged?
If it's the UART wake-up events, there's a patch that should
help.

Tony
