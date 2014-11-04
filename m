From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/10] ARM: OMAP2+: Show bootloader GPMC timings to allow
 configuring the .dts file
Date: Tue, 4 Nov 2014 07:49:02 -0800
Message-ID: <20141104154902.GQ31454@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
 <1414628948-30702-7-git-send-email-tony@atomide.com>
 <545248FA.7040201@ti.com>
 <20141030144529.GG2542@atomide.com>
 <54525362.9080000@ti.com>
 <20141030163031.GG2560@atomide.com>
 <5458D731.1010208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:32672 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754518AbaKDPuF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Nov 2014 10:50:05 -0500
Content-Disposition: inline
In-Reply-To: <5458D731.1010208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Roger Quadros <rogerq@ti.com> [141104 05:41]:
> 
> I don't have any board with smsc or working NOR so I called
> gpmc_cs_show_timings() after NAND was setup.
> 
> The printed values match closely to the configured values in the DTS.

OK thanks for checking. I've checked with smsc91x, smsc911x and
8250 so far so I think we're good to go.

Regards,

Tony
