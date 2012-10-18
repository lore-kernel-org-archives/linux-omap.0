From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: clockdomain: Fix OMAP4 ISS clk domain to
 support only SWSUP
Date: Thu, 18 Oct 2012 14:41:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210181441020.8746@utopia.booyaka.com>
References: <50800679.2030202@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48996 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992Ab2JROl5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 10:41:57 -0400
In-Reply-To: <50800679.2030202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 18 Oct 2012, Benoit Cousson wrote:

> From: Miguel Vadillo <vadillo@ti.com>
> 
> Since CAM domain (ISS) has no module wake-up dependency
> with any other clock domain of the device and the dynamic
> dependency from L3_main_2 is always disabled, the domain
> needs to be in force wakeup in order to be able to access
> it for configure (sysconfig) it or use it.
> 
> Also since there is no clock in the domain managed automatically
> by the hardware, there is no use to configure automatic
> clock domain transition. SW should keep the SW_WKUP domain
> transition as long as a module in the domain is required to
> be functional.
> 
> Signed-off-by: Miguel Vadillo <vadillo@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

Thanks queued for 3.7-rc.


- Paul
