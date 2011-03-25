From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Fri, 25 Mar 2011 08:55:49 -0700
Message-ID: <20110325155549.GZ2811@atomide.com>
References: <20110311191324.GE10079@atomide.com>
 <87d3lx5hoo.fsf@ti.com>
 <20110314171240.GB7258@atomide.com>
 <8762rhtnje.fsf@ti.com>
 <20110319002719.GF18583@atomide.com>
 <b65bf7960033964fba8f03e774b46905@mail.gmail.com>
 <20110321170758.GF2811@atomide.com>
 <87sjuge31n.fsf@ti.com>
 <20110321191114.GH2811@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A7E21D7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20772 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999Ab1CYPzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 11:55:53 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A7E21D7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110324 23:53]:
> Hi Tony,
> [...]
> > Well the dmtimer code can then become just a regular platform_device
> > based driver, except for clockevent and clocksource on omap2 & 3.
> Should I re-post the patch series with removal of duplicate initialization
> Which Kevin pointed out + other relevant comments?
> Or, wait for your patch series!

Just wait few days please, I should have something available that mostly
deals with timer-gp.c, so it should not cause too many issues with your
patches.

Thanks,

Tony
