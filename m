From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 3/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
Date: Wed, 10 Apr 2013 10:07:39 -0700
Message-ID: <20130410170737.GA10155@atomide.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-4-git-send-email-hvaibhav@ti.com>
 <20130408172936.GQ10155@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EC47BB2@DBDE01.ent.ti.com>
 <20130409163459.GJ10155@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EC4A236@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20826 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964913Ab3DJRHn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 13:07:43 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC4A236@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@linaro.org" <khilman@linaro.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [130409 22:16]:
> Agreed on making it as a module.
> 
> But do you think we should allow it as a loadable module (M) as well, 
> as user will loose Connectivity to JTAG during boot.
> Another perspective here would be, user can insert the module and
> Get JTAG connectivity, which also seems ok to me.

Yes both ways should be doable.
 
> Can you also confirm on having command line argument? I think
> We can only live with DT based approach, right?

Well I doubt that anybody wants to keep it permanently enabled
because of the power consumption and blocking of PM states, so
an additional cmdline might make sense.

It would be nice to have it most of the time built-in but disable
itself unless something debug is specified in the cmdline.

Maybe the JTAG driver can detect when the cable is connected?
Or maybe that would be only when there's clock coming over
JTAG?

Regards,

Tony
