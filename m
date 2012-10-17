From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Only write the sysconfig on idle when necessary
Date: Wed, 17 Oct 2012 15:37:09 -0500
Message-ID: <507F16F5.9020803@ti.com>
References: <1350504742-19995-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1210172023130.9767@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46854 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757846Ab2JQUhP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 16:37:15 -0400
In-Reply-To: <alpine.DEB.2.00.1210172023130.9767@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, rnayak@ti.com, linux-arm <linux-arm-kernel@lists.infradead.org>


On 10/17/2012 03:25 PM, Paul Walmsley wrote:
> cc Rajendra
> 
> Hi Jon
> 
> On Wed, 17 Oct 2012, Jon Hunter wrote:
> 
>> Currently, whenever we idle a device _idle_sysc() is called and writes to the
>> devices SYSCONFIG register to set the idle mode. A lot devices are using the
>> smart-idle mode and so the write to the SYSCONFIG register is programming the
>> same value that is already stored in the register.
>>
>> Writes to the devices SYSCONFIG register can be slow, for example, writing to
>> the DMTIMER SYSCONFIG register takes 3 interface clock cycles and 3 functional
>> clock cycles. If the DMTIMER is using the slow 32kHz functional clock this can
>> take ~100us.
>>
>> Furthermore, during boot on an OMAP4430 panda board, I see that there are 100
>> calls to _idle_sysc(), however, only 3 out of the 100 calls actually write
>> the SYSCONFIG register with a new value.
>>
>> Therefore, to avoid unnecessary writes to device SYSCONFIG registers when
>> idling the device, only write the value if the value has changed. It should be
>> safe to do this on idle as the context of the register will never be lost while
>> the device is active.
>>
>> Verified that suspend, CORE off and retention states are working with this
>> change on OMAP3430 Beagle board.
> 
> The code used to do what you propose in _write_sysconfig(), which applied 
> to all sysconfig writes, not just idle.  But it was changed by commit 
> 233cbe5b94096f95ba7bca2162d63275b0b90b5b ("OMAP2+: hwmod: Update the 
> sysc_cache in case module context is lost"). Could you take a look at
> this and maybe discuss it with Rajendra?  It seems to make more sense to 
> me to cache it by default, and only invalidate it when we know that 
> context is lost.

Ok, thanks. Yes, only updating the register when the cache value changed
would not work due to the possibility of context being lost. So
Rajendra's change makes sense. However, I think there is room to
optimise this.

With this change, on idle, the cache value and register value are only
updated when needed. This should be safe.

Are you looking to go one step further and only update the sysconfig on
enabling when the context has been lost? That would require more
changes. This was a quick optimisation I saw when reviewing the code.

Rajendra, let me know if you have any comments.

Cheers
Jon
