From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Fri, 23 May 2014 07:44:26 -0700
Message-ID: <20140523144425.GB2321@atomide.com>
References: <537615EA.3020809@ti.com>
 <20140516212942.GK12881@atomide.com>
 <537A3544.1050307@linaro.org>
 <20140519172338.GJ4849@atomide.com>
 <537A408F.7070301@ti.com>
 <20140519175157.GK4849@atomide.com>
 <537A4827.30604@linaro.org>
 <20140519193622.GA11945@atomide.com>
 <537A5F5B.6050403@linaro.org>
 <537A7522.30007@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58033 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751130AbaEWOof (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2014 10:44:35 -0400
Content-Disposition: inline
In-Reply-To: <537A7522.30007@math.uni-bielefeld.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Alex Shi <alex.shi@linaro.org>, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

* Tobias Jakobi <tjakobi@math.uni-bielefeld.de> [140519 14:19]:
> 
> But even if I don't connect via WiFi at all, just boot and let me system
> run with serial console connected, after some time I get a kernel 'WARNING':
> http://www.math.uni-bielefeld.de/~tjakobi/archive/dmesg.1.log

BTW, care to update the bugzilla page with the second warning
in this log?

That's the WARNING: CPU: 1 PID: 0 at kernel/timer.c:1147 that's
at 238 seconds.

Regards,

Tony
