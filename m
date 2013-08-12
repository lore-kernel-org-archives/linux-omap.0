From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: RX51: kernel message spam from CPUfreq driver
Date: Mon, 12 Aug 2013 11:59:28 +0530
Message-ID: <520880C8.1040907@ti.com>
References: <20130811141336.GA24034@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42276 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754576Ab3HLG3e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Aug 2013 02:29:34 -0400
In-Reply-To: <20130811141336.GA24034@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

On Sunday 11 August 2013 07:43 PM, Sebastian Reichel wrote:
> Hi,
> 
> On RX-51 (Nokia N900) the (mainline) kernel constantly outputs the
> following message about 2-3x per second since some releases:
> 
> [ 1038.314514] cpu cpu0: CPUfreq: Cannot find matching frequency for 125000000
> 
> (The message is from drivers/cpufreq/omap-cpufreq.c, line 100)
> 
> This is really annoying and makes debug output without a "grep -v"
> basically useless. Can you give me some hints how to solve the
> problem?

Whats the system clock frequency used on RX-51? I guess omap2_dpll_round_rate()
for some reason thinks that with the given sys clock its not possible to
lock the DPLL at 125Mhz. If you can send the debug logs from omap2_dpll_round_rate()
that should probably help know whats going wrong.

> 
> -- Sebastian
> 

