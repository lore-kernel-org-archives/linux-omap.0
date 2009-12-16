From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] [OMAP] gpio: Simultaneously requested rising and falling edge
Date: Wed, 16 Dec 2009 12:02:41 -0800
Message-ID: <87iqc6adr2.fsf@deeprootsystems.com>
References: <1260841374-7001-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:62802 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZLPUCo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 15:02:44 -0500
Received: by yxe17 with SMTP id 17so1255817yxe.33
        for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 12:02:44 -0800 (PST)
In-Reply-To: <1260841374-7001-1-git-send-email-darkstar6262@gmail.com> (Cory Maccarrone's message of "Mon\, 14 Dec 2009 17\:42\:54 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org

Cory Maccarrone <darkstar6262@gmail.com> writes:

> Some chips, namely any OMAP1 chips using METHOD_MPUIO,
> OMAP15xx and OMAP7xx, cannot be setup to respond to on-chip GPIO
> interrupts in both rising and falling edge directions -- they can
> only respond to one direction or the other, depending on how the
> ICR is configured.
>
> Additionally, current code forces rising edge detection if both
> flags are specified:
>
>         if (trigger & IRQ_TYPE_EDGE_RISING)
>                 l |= 1 << gpio;
>         else if (trigger & IRQ_TYPE_EDGE_FALLING)
>                 l &= ~(1 << gpio);
>         else
>                 goto bad;
>
> This change implements a toggle function that will modify the ICR
> to flip the direction of interrupt for IRQs that are requested with
> both rising and falling flags.  The toggle function is not called
> for chips and GPIOs it does not apply to through the use of a flip_mask
> that's added on a per-bank basis.  The mask is only set for those
> GPIOs where a toggle is necessary.  Edge detection starts out the
> same as above with FALLING mode first.
>
> The toggle happens on EACH interrupt; without it, we have the
> following sequence of actions on GPIO transition:
>
>   ICR    GPIO               Result
>   0x1    0 -> 1 (rising)    Interrupt
>   0x1    1 -> 0 (falling)   No interrupt
>
>   (set ICR to 0x0 manually)
>   0x0    0 -> 1 (rising)    No interrupt
>   0x0    1 -> 0 (falling)   Interrupt
>
> That is, with the ICR set to 1 for a gpio, only rising edge interrupts
> are caught, and with it set to 0, only falling edge interrupts are
> caught.  If we add in the toggle, we get this:
>
>   ICR    GPIO               Result
>   0x1    0 -> 1 (rising)    Interrupt (ICR set to 0x0)
>   0x0    1 -> 0 (falling)   Interrupt (ICR set to 0x1)
>   0x1    0 -> 1 ...
>
> so, both rising and falling are caught, per the request for both
> (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING).
>
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>

This version looks good.

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Kevin
