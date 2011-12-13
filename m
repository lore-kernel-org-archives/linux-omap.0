From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv11 5/8] ARM: OMAP2+: mux: add support for PAD wakeup
 interrupts
Date: Mon, 12 Dec 2011 16:24:29 -0800
Message-ID: <20111213002429.GN32251@atomide.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59788 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753577Ab1LMAYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 19:24:32 -0500
Content-Disposition: inline
In-Reply-To: <1323713733-13115-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [111212 09:44]:
> OMAP mux now parses active wakeup events from pad registers and
> calls corresponding hwmod ISRs once a wakeup is detected. This is
> accomplished by registering an interrupt handler for PRCM IO event,
> which is raised every time the HW detects wakeups.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This will need to be updated once we are using the pinctrl
framework, for now this looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
