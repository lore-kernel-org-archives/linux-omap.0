From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: Legacy support for wl12xx when booted
 with devicetree
Date: Fri, 26 Apr 2013 08:51:38 -0700
Message-ID: <20130426155138.GB29360@atomide.com>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
 <20130426035210.26065.39995.stgit@muffinssi.local>
 <0104F687-1726-476D-B2DF-7E72223B127A@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42471 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab3DZPvr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 11:51:47 -0400
Content-Disposition: inline
In-Reply-To: <0104F687-1726-476D-B2DF-7E72223B127A@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-arm-kernel@lists.infradead.org, Luciano Coelho <coelho@ti.com>, devicetree-discuss@lists.ozlabs.org, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, Jason Kridner <jkridner@beagleboard.org>

* Koen Kooi <koen@dominion.thruhere.net> [130426 02:39]:
> 
> Op 26 apr. 2013, om 05:52 heeft Tony Lindgren <tony@atomide.com> het volgende geschreven:
> 
> > Without WLAN we cannot switch omap4 to use device tree
> > only booting. This patch can be reverted when the
> > binding for wl12xx is added.
> 
> How much boards am I allowed to add to this? I need to get the wl12xx wifi expansionboards for beagleboard, beagleboard xM and beaglebone working with DT :)

As long as it's trivial changes, go for it. It will be
gone after we have the binding for wl12xx.

But let's not add the bluetooth serial port hack.. And
let's not churn the board-*.c files, at this point pretty
much the next step is to start dropping the board-*.c
files.

Regards,

Tony
