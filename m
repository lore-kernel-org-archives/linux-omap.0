From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of
 individual hwmods
Date: Wed, 2 Mar 2011 09:54:23 -0800
Message-ID: <20110302175422.GY20560@atomide.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
 <4D651998.3040002@ti.com>
 <alpine.DEB.2.00.1102271928550.505@utopia.booyaka.com>
 <4D6B845A.9000900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61565 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585Ab1CBRy1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 12:54:27 -0500
Content-Disposition: inline
In-Reply-To: <4D6B845A.9000900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Gopinath, Thara" <thara@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

> On 2/28/2011 3:31 AM, Paul Walmsley wrote:
> >Tony, I guess the omap-for-linus branch will probably need to get rebuilt
> >to drop that patch, once this series is merged...

Let's rather apply a fix or revert instead than start messing with
omap-for-linus. That branch is supposed to be a stable base for others
to base their branches on.

Tony
