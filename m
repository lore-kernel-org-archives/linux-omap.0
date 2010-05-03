From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2/3/4: DMA: reset controller during init
Date: Mon, 03 May 2010 10:05:06 -0700
Message-ID: <87fx285325.fsf@deeprootsystems.com>
References: <1272891357-27400-1-git-send-email-ext-mika.1.westerberg@nokia.com>
	<87zl0h6khl.fsf@deeprootsystems.com>
	<20100503163600.GQ29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36389 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab0ECRFJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 13:05:09 -0400
Received: by pva4 with SMTP id 4so590151pva.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 10:05:08 -0700 (PDT)
In-Reply-To: <20100503163600.GQ29604@atomide.com> (Tony Lindgren's message of "Mon\, 3 May 2010 09\:36\:01 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100503 08:58]:
>> Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
>> 
>> > If we are softbooting another kernel using kexec, DMA controller state is not
>> > known when we are performing omap_init_dma(). It is possible that some DMA
>> > channels are already active. For example after kexec we get:
>> >
>> > <4>IRQ 0020 for non-allocated DMAchannel 5
>> > <4>IRQ 0020 for non-allocated DMAchannel 5
>> > <4>IRQ 0020 for non-allocated DMAchannel 5
>> > <4>IRQ 0020 for non-allocated DMAchannel 5
>> > <4>IRQ 0020 for non-allocated DMAchannel 5
>> >
>> > To prevent any weird things happening, we perform soft reset for the controller
>> > and disable all per channel interrupts.
>> >
>> > Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
>> 
>> This is a good fix, but we get reset of DMA (and all other blocks) for
>> free when switching to hwmod.  Here's a good reason to convert DMA
>> to hwmod.
>
> Hmm, do we have existing DMA hwmod patches somewhere that work on all omaps?

No, that's my point. 

Rather than implement reset here (then remove it with DMA hwmods) I'd
rather just see a DMA hwmods added, and then we get reset for free.

Kevin
