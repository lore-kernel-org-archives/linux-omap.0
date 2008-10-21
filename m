From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt bits
Date: Tue, 21 Oct 2008 23:09:01 +0300
Message-ID: <94a0d4530810211309w28188181rcb8b1b881588ec87@mail.gmail.com>
References: <20081021045809.GJ7341@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:30119 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbYJUUJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 16:09:02 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2574686rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 13:09:01 -0700 (PDT)
In-Reply-To: <20081021045809.GJ7341@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Nathan Monson <nmonson@gmail.com>, lauri.leukkunen@nokia.com, Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>, Rick Bronson <rick@efn.org>

On Tue, Oct 21, 2008 at 7:58 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> Here's a bug fix for the irq -33 issue. So far it looks like the irq
> spurious bits just tell that the irq sorting is invalid.
>
> This patch applies after undoing Lauri's patch
> 5dc857b34441d5c0989b68bf3a488f89983b2645.

You mean?
3da0e10243d075b905dfa8f1b4a6cb3694ab2ce0

> Looks like there are still occasional spurious GPT12 interrupts, so
> I'm now looking into that.

Works perfectly fine with my DSP tests :)

Thanks!

-- 
Felipe Contreras
