From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Thu, 18 Nov 2010 10:27:52 -0800
Message-ID: <20101118182752.GI9264@atomide.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
 <1290091906-32539-2-git-send-email-j-pihet@ti.com>
 <d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
 <87tyjey6h3.fsf@deeprootsystems.com>
 <4CE55A88.6010300@ti.com>
 <20101118175215.GE9264@atomide.com>
 <AANLkTi=bhULQsXhnN9ugDm7k=2P4E7-SvXEnx06pBwmu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21656 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab0KRS16 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 13:27:58 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=bhULQsXhnN9ugDm7k=2P4E7-SvXEnx06pBwmu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, Jean Pihet-XID <j-pihet@ti.com>

* Jean Pihet <jean.pihet@newoldbits.com> [101118 10:06]:
> On Thu, Nov 18, 2010 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> About the DPLL lock:
> 1) wait_sdrc_ok is only called when back from the non-OFF modes,
> 2) I checked that when running wait_sdrc_ok the CORE is already out of
> idle and the DPLL is already locked. Note: l-o code has no support for
> the voltages OFF and the external clocks OFF.
> 
> What to conclude from 1) and 2)? In my test setup ot looks like
> wait_sdrc_ok is of no use, but I agree this a premature conclusion.

Yeah we should figure out in which cases wait_sdrc_ok is needed.

BTW, are you sure you're hitting core idle in your tests?

Regards,

Tony

