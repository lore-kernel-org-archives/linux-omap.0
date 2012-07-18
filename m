From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC RESEND 1/4] arm/dts: OMAP: Add timer nodes
Date: Wed, 18 Jul 2012 00:19:07 -0700
Message-ID: <20120718071906.GJ6522@atomide.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
 <1342218413-30116-2-git-send-email-jon-hunter@ti.com>
 <5000D647.4090200@gmail.com>
 <500439A8.1050705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23528 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab2GRHTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 03:19:12 -0400
Content-Disposition: inline
In-Reply-To: <500439A8.1050705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Rob Herring <robherring2@gmail.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>

* Jon Hunter <jon-hunter@ti.com> [120716 09:01]:
> On 07/13/2012 09:15 PM, Rob Herring wrote:
> 
> Tony, Tarun,
> 
> How would you feel on replacing omap_dmtimer_request_specific(int id)
> with say omap_dm_timer_request_by_cap(int cap)?
> 
> I was thinking of changing the name so that it is clear that the API has
> changed. The "int cap" passed to the above function would be an OR of
> the appropriate the capabilities flags we have in dmtimer.h ...
> 
> /* timer capabilities used in hwmod database */
> #define OMAP_TIMER_SECURE                               0x80000000
> #define OMAP_TIMER_ALWON                                0x40000000
> #define OMAP_TIMER_HAS_PWM                              0x20000000
> ...

That may break coprocessors where the firmware may expect a hardcoded
specific timer.. So at least that should be checked before the change.
If the specific timer is still needed for some firmware, it's best to
add a separate function for the capabilities.

Also, I believe it's up to the firmware running in secure mode to
select the secure timers. So unless there's some way to query which
timers are claimed by the secure mode, that too needs to be passed
via DT.

Regards,

Tony
