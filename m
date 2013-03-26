From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: AM33XX: Add missing .clkdm_name to clkdiv32k_ick
 clock
Date: Tue, 26 Mar 2013 18:13:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303261812010.23957@utopia.booyaka.com>
References: <1364211443-27536-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39013 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab3CZSNU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 14:13:20 -0400
In-Reply-To: <1364211443-27536-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Mon, 25 Mar 2013, Vaibhav Hiremath wrote:

> During common-clock migration, .clkdm_name field got missed
> for "clkdiv32k_ick" clock, which leaves "clk_24mhz_clkdm"
> unused; so boot process will try to disable the clockdomain
> even childs of this clock is enabled, which keeps child modules
> in idle mode.

Looks fine to me.  You're planning to update the patch description, right?  
So should I wait until you repost it?

Also you should probably trim the crash log after "[    2.626025] LR is at 
clk_enable+0x30/0x3c"



- Paul
