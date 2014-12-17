From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Wed, 17 Dec 2014 12:44:07 -0800
Message-ID: <20141217204407.GG23854@atomide.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
 <20141217185155.GI11502@n2100.arm.linux.org.uk>
 <20141217190904.GF23854@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35949 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751030AbaLQUrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2014 15:47:05 -0500
Content-Disposition: inline
In-Reply-To: <20141217190904.GF23854@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joel Fernandes <joelf@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Nishanth Menon <nm@ti.com>

* Tony Lindgren <tony@atomide.com> [141217 11:14]:
> 
> Also, in your 3430-LDP logs, the DMA setup_irq related "In-band Error"
> is a mystery. I'm not seeing that with omap2plus_defconfig, but can
> reproduce it here with your LDP .config file. Got any ideas on that one?

Hmm it looks like that's some CONFIG_PREEMPT related regression..
Disablig CONFIG_PREEMPT makes it go away.

Regards,

Tony
