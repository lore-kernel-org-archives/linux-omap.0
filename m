From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 0/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
Date: Mon, 8 Apr 2013 10:30:53 -0700
Message-ID: <20130408173052.GR10155@atomide.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EC281C1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26305 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934759Ab3DHRay (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 13:30:54 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC281C1@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@linaro.org" <khilman@linaro.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [130314 04:33]:
> > From: Hiremath, Vaibhav
> > This patch introduces new kernel parameter "omap_debugss_en",
> > which will allow user to control debugSS module enable/disable
> > part during boot-time.
> > 
> > In case of OMAP3, the debugSS is part of EMU domain and
> > is currently controlled by clock tree alone.
> > 
> > In case of OMAP4, the debugSS is part of EMU domain and
> > is currently controlled by clock tree, as MODULEMODE_SWCTRL
> > is not defined for hwmod.
> > 
> > In case of AM335x, the debugSS is in wakeup domain and is currently
> > controlled through hwmod alone. Currently we keep it always enabled.
> 
> Any comments or input on this patch series?

No comments on adding the clocks, but the enabling of
them should be just a regular device driver.

Regards,

Tony
