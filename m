From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] OMAP3: RX51: support sleep indicator LEDs
Date: Fri, 2 Oct 2009 16:59:44 +0100
Message-ID: <20091002155944.GV1133@earth.li>
References: <1254497755-1822-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from the.earth.li ([217.147.81.2]:41402 "EHLO the.earth.li"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757270AbZJBRC1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Oct 2009 13:02:27 -0400
Content-Disposition: inline
In-Reply-To: <1254497755-1822-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 02, 2009 at 08:35:55AM -0700, Kevin Hilman wrote:
> The sleep indicator LEDs can be enabled/disabled by toggling GPIO162.
> Request this GPIO in RX51 board init, disable by default and expose
> GPIO162 to userspace so LEDs can be toggled from userspace:

Wouldn't this be better done using the LED class subsystem?

> To enable:
> 
>   # echo 1 > /sys/class/gpio/gpio162/value
> 
> To disable:
> 
>   # echo 0 > /sys/class/gpio/gpio162/value
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---

J.

-- 
101 things you can't have too much of : 16 - Time.
