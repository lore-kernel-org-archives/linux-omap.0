From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] OMAP3: GPIO fixes for off-mode
Date: Tue, 2 Dec 2008 11:56:55 +0200
Message-ID: <B71CE868F2BC2847B3F23C5A8EE39430D9C2E0@vaebe110.NOE.Nokia.com>
References: <> <1228131512-12099-1-git-send-email-tero.kristo@nokia.com> <1228131512-12099-2-git-send-email-tero.kristo@nokia.com> <200812011126.55412.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27894 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbYLBJ5F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 04:57:05 -0500
Content-class: urn:content-classes:message
In-Reply-To: <200812011126.55412.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david-b@pacbell.net
Cc: linux-omap@vger.kernel.org

Hi,

>On Monday 01 December 2008, Tero Kristo wrote:
>> Off mode is now using the omap2 retention fix code for 
>scanning GPIOs 
>> only during off-mode transitions. All the *non_wakeup_gpios 
>variables 
>> are now used for off-mode transition tracking on OMAP3. This patch 
>> fixes cases where GPIO state changes are missed during off-mode.
>
>I second the "no #ifdefs" comment ...

I agree the code looks horrible at the moment with the multitude of
#ifdef:s, I just did not feel comfortable fixing all of those, so I
continued the way it has been written so far...

>Could you uplevel your description here a bit?  I'm trying to 
>understand if what this does is complete and correct.
>
>My understanding is that we currently have several mechanisms 
>interacting to affect things that relate to the OMAP3-only 
>"off" modes for pins used as GPIOs:
>
> - irq_chip.set_wake() calls, for GPIOs used as IRQs.
>   We should assume that if the IRQ is wake-enabled, that
>   applies to OFF mode too.  (AFAICT, this mechanism is
>   not handled by this patch.)

Off mode wakeup requires setting up IO pads according to the wakeup
scheme you want to have. This is rather nasty limitation of the HW and
you need to be careful how you configure these things. This patch
assumes you have configured your IO pads in a way that you get wakeups
for your GPIOs during off, and when you eventually wakeup, it will
scan all GPIOs to see if any GPIO "interrupt" has happened. You will
not get edge sensitive interrupts from GPIOs during off-mode, because
the hardware block handling the edge sensing has no power at all.

> - Hmm, and because a goal is to transparently enter OFF
>   modes to save power, rather than only after drivers
>   get suspend() calls that tend to trigger set_wake(),
>   an un-commented conclusion seems to be that all GPIOs
>   used as IRQs implicitly act like set_wake() was called.
>   (Something which *is* partially addressed here.)

Yes, this is correct. I think this is somewhat against the design of
the omap2 code, as the GPIOs can wakeup the device from both suspend
and dynamic idle. However, this is mainly caused by the IO pad wakeup
mechanism of omap3, which does not care whether you are in dynamic idle
or in suspend. Handling this correctly would require creating IO pad
control mechanism to the kernel, something that I am not sure if we
want to do (we would need to have separate IO pad config for suspend
and dynamic idle.)

>
> - omap_cfg_reg() configuration for any pin can include
>   its OFF-mode parameters.  Virtually unused ... and
>   not addressed by this patch, so I'm puzzled how pins
>   are expected to be kept active with just this patch.

Mux configuration for OMAP3 is handled mostly by boot loader at the
moment, this is the behavior at least on TI SDP implementation.

>
> - OMAP2-specific bug workarounds, some GPIOs can't be
>   used for wakeup, ergo bank->non_wakeup_gpios.  This
>   is resolved for OMAP3, yes?

Well, basically only bank 0 can be used for wakeup in omap3, wakeups
for all the rest are handled via IO pad.

>
>When I looked at this issue a while back, I came to believe 
>that we'd need to map GPIOs to their config registers so we 
>could diddle the OFF-mode bits.  And I don't see such a 
>mapping (table) here...

Yep, if we want to have different configs for suspend and dynamic
idle, this is something we should do. However, having around 190
pins in OMAP3 you can potentially configure as GPIOs, I am really
hesitant writing such piece of code.

