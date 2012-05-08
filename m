From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP4: twl-common: Add twl6030 V1V8, V2V1 SMPS
 common configuration
Date: Tue, 8 May 2012 16:57:49 -0700
Message-ID: <20120508235748.GX5088@atomide.com>
References: <1335966276-19775-1-git-send-email-peter.ujfalusi@ti.com>
 <1335966276-19775-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36288 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab2EHX5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 19:57:51 -0400
Content-Disposition: inline
In-Reply-To: <1335966276-19775-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120502 06:48]:
> V1V8 supply from twl6030 commonly used as VIO for the machine.
> V2V1 is adviced to supply the twl6040, and also to feed the twl6030's
> VCXIO_IN, and VDAC_IN inputs.
> Create the common regulator configurations for these regulators:
> Make the V2V1 as supply_regulator for VCXIO, VDAC.
> Add twl6040 (1-004b) as consumer for V1V8, and V2V1.

Looks like this needs to be refreshed, it does not seem to apply.
Can you update against v3.4-rc6 and check the others too?

Regards,

Tony
