From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH RFC 00/13] ARM: OMAP2+: AM43x PRCM support
Date: Thu, 18 Jul 2013 16:37:06 +0530
Message-ID: <51E7CC5A.8020906@ti.com>
References: <cover.1373519192.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38616 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758756Ab3GRLHe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Jul 2013 07:07:34 -0400
In-Reply-To: <cover.1373519192.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>

Hi Tony, Paul,

On 7/11/2013 12:03 PM, Afzal Mohammed wrote:

> AM43x PRCM support (excluding clock tree) is being added with this
> series. AM43x reuses most of the IP's from AM335x, as that is the
> case, it was felt that reusing AM335x code as much as possible for
> AM43x is better - it also helps to keep LOC less.

> Major reuse has been with hwmod database of AM335x, moving common
> elements to a new array and keeping separate arrays for elements that
> are specific only to either one of AM335x or AM43x. And in the cases
> where relevant IP is present in both that has difference in details
> like CLKCTRL register offsets, it is being updated at runtime based on
> the SoC detected.

> This series is being developed with additional clock tree changes that
> would be DT'fied.

> Additional DTS changes are also required for hwmod to get register
> target address space as most of AM335x hwmod address space details has
> been recently cleaned up and moved to DTS.

 > 		********
 >
 > This RFC is being posted to get an early feedback on approach taken
 > here mainly w.r.t reusing AM335x hwmod database for AM43x.
 >
 > 		********

Please let me know your comments on this series.

Most of the IP's in AM335x is reused on AM43x and hence out of the
existing 77 hwmod ocpif entries on AM335x, 73 are reused on AM43x by
moving to a common array (only 4 is left AM335x specific).

Even the address space of those peripherals that are common between
AM335x & AM43x is same. And AM43x has only a few newer IP's as
compared to AM335x.

Regards
Afzal
