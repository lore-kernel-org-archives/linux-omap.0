From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V7 0/3] ARM: OMAP: Make OMAP clocksource source
 selection runtime
Date: Thu, 10 May 2012 15:26:44 -0700
Message-ID: <20120510222644.GQ21851@atomide.com>
References: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
 <2430095.tlzScq1o2g@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21800 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761857Ab2EJW0s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 18:26:48 -0400
Content-Disposition: inline
In-Reply-To: <2430095.tlzScq1o2g@acer>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [120510 14:40]:
> 
> Otherwise, if configured with OMAP16xx selected, builds and seems to work 
> correctly for me, to the extent possible to verify without physical 
> access to the hardware. However, please note that the Amstrad Delta 
> doesn't make use of the 32k timer, only mpu_timer.

OK good to hear, thanks!

Tony
