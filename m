From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for
 ti,mux-clock
Date: Tue, 17 Jun 2014 08:19:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406170815460.31106@utopia.booyaka.com>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com> <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com> <539FF81E.2020606@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47508 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072AbaFQITS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 04:19:18 -0400
In-Reply-To: <539FF81E.2020606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>

On Tue, 17 Jun 2014, Tero Kristo wrote:

> I am fine with this approach, as it seems pretty much all the other mux-clock
> users are setting this flag also. The TI clocks have had this way of using mux
> clocks from the legacy times... might just be a design flaw.

The non-CCF clock framework never automatically switched parents on rate 
changes, AFAIK.

The only case that approached this was with PLLs.  PLLs would 
automatically be placed into bypass if the PLL rate was set to the bypass 
rate.


- Paul
