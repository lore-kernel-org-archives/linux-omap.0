From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 29/33] CLK: omap: add omap3 clock init file
Date: Fri, 2 Aug 2013 00:24:16 -0700
Message-ID: <20130802072415.GW7656@atomide.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-30-git-send-email-t-kristo@ti.com>
 <51F81FD7.2060707@ti.com>
 <20130731063512.GP7656@atomide.com>
 <51F928E8.9020806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62243 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631Ab3HBHYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Aug 2013 03:24:20 -0400
Content-Disposition: inline
In-Reply-To: <51F928E8.9020806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

* Tero Kristo <t-kristo@ti.com> [130731 08:17]:
> On 07/31/2013 09:35 AM, Tony Lindgren wrote:
> >* Nishanth Menon <nm@ti.com> [130730 13:26]:
> >>
> >>Tony and a lot of people is not going to like removing support for
> >>non-dt boot for OMAP3 before "it's time is due" ;)
> >
> >I think the only showstopper for that is that we need the
> >pending pinctrl changes merged first to keep off-idle working.
> >So the omap3 legacy code removal probably needs to wait until
> >v3.13 merge window. For omap4 and am33xx we can do it now.
> 
> I'll modify the series in such way that OMAP3 retains the legacy
> clock data within the kernel for now, and will use either DT or
> kernel data based on init type. Kernel data can then be removed when
> time is ripe for it.

OK thanks sounds good to me.

Regards,

Tony
