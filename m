From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 00/13] ARM: OMAP2+: AM43x PRCM support
Date: Wed, 21 Aug 2013 17:14:58 +0530
Message-ID: <5214A83A.5080701@ti.com>
References: <cover.1375443858.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41846 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab3HULph (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Aug 2013 07:45:37 -0400
In-Reply-To: <cover.1375443858.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, Paul Walmsley <paul@pwsan.com>, benoit.cousson@gmail.com, Benoit Cousson <bcousson@baylibre.com>

On Friday 02 August 2013 07:05 PM, Afzal Mohammed wrote:
> Hwmod database of AM335x is reused by moving common elements to a new
> array (most of AM335x IP's are present in AM43x) and keeping separate
> arrays for elements that are specific only to either one of AM335x or
> AM43x. And in the cases where relevant IP is present in both that has
> difference in details like CLKCTRL register offsets, it is being
> updated at runtime based on the SoC detected.

I feel the reuse part is good but we need to structure them such that we
don't compromise too much on readability of the data.

So what I suggest is
1. Create something like omap_hwmod_am43_am33_interconnect_data.c and have all common
interconnect ocp_if structs
2. Create something like omap_hwmod_am43_am33_ipblock_data.c and have all common
hwmod structs.
3. Since most PRCM register offsets are different, have them all inited in *one* place
(even for the ones which are common), instead of common ones being statically defined
and others dynamically inited.
4. For instances like clkdm being different or clock topology has changed (which is in
rare cases) have seperate structures for am33xx and am43xx. Once we move some of the clocks etc
to DT we can then move them into common files if needed.

Paul/Benoit, does the above make sense?
