From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1] ARM: OMAP3: PM: don't explicitly enable the IO-chain interrupt
Date: Fri, 29 Jun 2012 15:25:02 +0200
Message-ID: <CAAwP0s2F2pfBUpMzDaGJvoDNtQ+mFCTMnN43MoYD=k-rRT1mGw@mail.gmail.com>
References: <1340933123-30401-1-git-send-email-javier@dowhile0.org> <87obo2mg61.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47101 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab2F2NZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 09:25:25 -0400
Received: by pbbrp8 with SMTP id rp8so4514679pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 06:25:24 -0700 (PDT)
In-Reply-To: <87obo2mg61.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jun 29, 2012 at 2:55 PM, Kevin Hilman <khilman@ti.com> wrote:
> +Paul
>
> Javier Martinez Canillas <javier@dowhile0.org> writes:
>
>> commit 99b59df0 ARM: OMAP3: PM: fix shared PRCM interrupt leave disabled at boot
>>
>> set the IRQ_NOAUTOEN flag to the PCRM IO-chain irq to avoid this
>> interrupt until the PM core code is ready to handle the interrupts.
>>
>> It seems that this is not needed anymore after the OMAP PRCM I/O chain
>> code re-implementation introduced on merge commit:
>>
>> 9a17d88 Merge tag 'omap-devel-c-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/
>>
>> The IRQ_NOAUTOEN flags is not set for the PRCM I/O irq anymore on the
>> new implementation. This has the effect that a request_irq() for the
>> PRCM I/O chain irq will auto-enable the requested IRQ and a later call
>> to enable_irq() will lead to the following warning:
>
> I noticed that warning too, but I don't think $SUBJECT patch is the
> right fix.
>
> We still need the IRQ_NOAUTOEN so that cases where PM is not enabled,
> the IO chain interrupts are not enabled.
>
> Looking closer, it looks like the merge of omap-devel-c-for-3.6 removed
> the IRQ_NOAUTOEN in the merge resolution, which wasn't right.
>
> I'll cook up a fix for this.
>
> Kevin
>
>

Hi Kevin,

Yes, I can confirme you that the IRQ_NOAUTOEN was gone. I didn't know
if the right solution was to set that flag again or to just remove the
duplicated enable_irq(). I should had tag my patch with RFC instead of
PATCH I guess :-)

Thanks a lot and best regards,
Javier
