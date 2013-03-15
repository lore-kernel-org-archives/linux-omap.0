From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: clocks: Pass static parent pointers
 to common clock core
Date: Fri, 15 Mar 2013 17:57:34 +0530
Message-ID: <514313B6.4050905@ti.com>
References: <1363264618-5071-1-git-send-email-rnayak@ti.com> <1363264618-5071-3-git-send-email-rnayak@ti.com> <20130314170601.GH26093@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58217 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab3COM1s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Mar 2013 08:27:48 -0400
In-Reply-To: <20130314170601.GH26093@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, phaber@broadcom.com

On Thursday 14 March 2013 10:36 PM, Tony Lindgren wrote:
> * Rajendra Nayak <rnayak@ti.com> [130314 05:44]:
>> OMAP clock inits happen quite early, even before the slab is available.
>> As part of the clock init, the common clock core tries to cache parent
>> pointers (if not passed by the caller registering the clock) which
>> fails in case of OMAP since the slab isn't initied.
>> Without CONFIG_DEBUG_SLAB enabled, this just results in the common clock core
>> retrying the caching attempt at some point later.
>> However with CONFIG_DEBUG_SLAB enabled this results in a BUG() as reported
>> in the link below by Tony..
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85932.html
>>
>> Fix this by passing static parent pointers to the common clock core
>> while registering clocks.
> 
> I wonder if we could easily fix this by initializing only some of the
> clocks that early?

We actually don't need any clocks that early (I mean even before slab init)
We only need them before timer init.

This isn't something specific to OMAP so I started looking at what others
in drivers/clk seem to do.

I found imx, spear, mvebu all do their clk inits within .init_time callbacks.
tegra seems to even do it within .init_irq callback.

Either one would work for us too :)

> 
> If we had a two stage initialization we could dynamically allocate the
> rest of the parent clocks without having to add all the static data.
> 
> Regards,
> 
> Tony
> 

