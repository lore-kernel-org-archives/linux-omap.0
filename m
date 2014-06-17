From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for ti,mux-clock
Date: Tue, 17 Jun 2014 11:23:31 +0300
Message-ID: <539FFB03.6070407@ti.com>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com> <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com> <539FF81E.2020606@ti.com> <alpine.DEB.2.02.1406170815460.31106@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40804 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932386AbaFQIXT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 04:23:19 -0400
In-Reply-To: <alpine.DEB.2.02.1406170815460.31106@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>

On 06/17/2014 11:19 AM, Paul Walmsley wrote:
> On Tue, 17 Jun 2014, Tero Kristo wrote:
>
>> I am fine with this approach, as it seems pretty much all the other mux-clock
>> users are setting this flag also. The TI clocks have had this way of using mux
>> clocks from the legacy times... might just be a design flaw.
>
> The non-CCF clock framework never automatically switched parents on rate
> changes, AFAIK.

That might be true yea, so this must have been introduced with CCF.

> The only case that approached this was with PLLs.  PLLs would
> automatically be placed into bypass if the PLL rate was set to the bypass
> rate.

Someone could argue that this is rather strange approach also and would 
be better to use some other API for the purpose.

.Tero

