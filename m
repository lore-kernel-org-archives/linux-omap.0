From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for
 ti,mux-clock
Date: Wed, 18 Jun 2014 07:06:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406180704120.32511@utopia.booyaka.com>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com> <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1406170814220.31106@utopia.booyaka.com> <20140617213404.32686.34311@quantum>
 <alpine.DEB.2.02.1406180639290.32511@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60596 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846AbaFRHGx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jun 2014 03:06:53 -0400
In-Reply-To: <alpine.DEB.2.02.1406180639290.32511@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>

On Wed, 18 Jun 2014, Paul Walmsley wrote:

> I don't disagree that some platforms might want this behavior.  But it's 
> not a safe default, the flag should be the other way around.  Rare is the 
> software engineer that knows whether the clock muxes on their platform are 
> glitchless.

(beyond all the other issues with unexpected parent changes, races, etc.)


- Paul
