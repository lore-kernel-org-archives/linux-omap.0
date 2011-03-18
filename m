From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: mach-omap2: devices: fix omap3_l3_init()
 return value
Date: Fri, 18 Mar 2011 16:43:01 -0700
Message-ID: <20110318234301.GA18583@atomide.com>
References: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com>
 <324bffcaf53be55bd6f392af3f86fa10@mail.gmail.com>
 <4D81C41F.8090702@ti.com>
 <34f6d3df1c7449f43374ecf3e3a74f77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21124 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563Ab1CRXnI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2011 19:43:08 -0400
Content-Disposition: inline
In-Reply-To: <34f6d3df1c7449f43374ecf3e3a74f77@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110317 03:04]:
> > From: Cousson, Benoit [mailto:b-cousson@ti.com]
> >
> > Maybe we should initialize that before, because in theory the
> > timer12 secure violation should have been captured easily with
> > this code?
> >
> The firewall exceptions handling is removed from L3 handler because
> PPA has the trap implemented. We faced issues when the trap was
> enabled in both places.

Applying these into fixes.

Tony
