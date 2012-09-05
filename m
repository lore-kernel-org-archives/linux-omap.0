From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix array size for irq_target_cpu
Date: Wed, 5 Sep 2012 18:46:34 +0530
Message-ID: <CAMQu2gxGtLzOWWsBAimW=8tE5Dd9GvOs63rKvfcsNB4X1wqLxw@mail.gmail.com>
References: <20120905000309.GW1303@atomide.com> <50473A67.6000805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:58761 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750947Ab2IENQz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 09:16:55 -0400
Received: by iagf6 with SMTP id f6so2047113iag.1
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 06:16:54 -0700 (PDT)
In-Reply-To: <50473A67.6000805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Sep 5, 2012 at 5:11 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>
> Hi Tony,
>
> On 09/05/2012 02:03 AM, Tony Lindgren wrote:
> > If NR_IRQS is less than MAX_IRQS, we end up writing past the
> > irq_target_cpu array in omap_wakeupgen_init():
> >
> > /* Associate all the IRQs to boot CPU like GIC init does. */
> > for (i = 0; i < max_irqs; i++)
> >       irq_target_cpu[i] = boot_cpu;
> >
> > This can happen if SPARSE_IRQ is enabled as by default NR_IRQS is
> > set to 16. Without this patch we're overwriting other data during
> > the boot.
>
> In fact I already sent a patch to fix that when I started my SPARSE_IRQ
> cleanup, but it looks like it was never merged :-(
> I guess I forgot a little bit that series.
>
Indeed. I remember acking few patches in that series.
Infact this patch set was the basis on which I was talking to Arnd
that SPARSE_IRQ
should work on OMAP. Didn't think that it has not made it yet in mainline.

Regards
Santosh
