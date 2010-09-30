From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during
 init
Date: Thu, 30 Sep 2010 08:07:13 -0700
Message-ID: <20100930150713.GG3117@atomide.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>
 <4CA45341.3080300@ti.com>
 <87vd5njpyq.fsf@deeprootsystems.com>
 <4CA49ADE.6080202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49772 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab0I3PHU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 11:07:20 -0400
Content-Disposition: inline
In-Reply-To: <4CA49ADE.6080202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Menon, Nishanth" <nm@ti.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [100930 07:04]:
> 
> I think that disabling it should be done only if the CONFIG_OMAP_WDT
> is not set.

How about disabling is done always unless CONFIG_WATCHDOG_NOWAYOUT
is set? That way product kernels can set CONFIG_WATCHDOG_NOWAYOUT
and for the rest of us we can let fsck run the standard Linux way.

Tony
