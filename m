From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 resend] ARM: OMAP4: twl-common: Support for
 additional devices on i2c1 bus
Date: Fri, 21 Sep 2012 11:56:29 -0700
Message-ID: <20120921185628.GF28835@atomide.com>
References: <1344345145-32125-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30671 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757553Ab2IUS4c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 14:56:32 -0400
Content-Disposition: inline
In-Reply-To: <1344345145-32125-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120807 06:12]:
> On OMAP4 the i2c1 bus is dedicated for the PMIC and audio related devices.
> Manufacturers can opt to use different codec than twl6040 and also can add
> audio related IC to the bus (external amplifier for example on SDP4430).
> 
> Make it possible to add different set of additional devices to i2c1 bus on
> OMAP4 boards.

Sorry I guess I'm quite a bit behind with the platform related patches..
Can you please refresh this again for arm-soc/for-next? It may be
worth then merging this as a fix via the ASoC patches for -rc1.

Regards,

Tony
