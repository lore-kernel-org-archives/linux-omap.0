From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 00/10] hwspinlock-next
Date: Wed, 21 Sep 2011 19:07:55 +0300
Message-ID: <CAK=WgbZw=q1HkU2U6iuzjSW==za5saFXmnf0yaYoHWkJfduZVA@mail.gmail.com>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
 <CAK=Wgbam6u1bq8fG+oMUhxfWH1g3dU7q+VhPWFEZOLgFMV_3vQ@mail.gmail.com>
 <20110920231340.GT18894@atomide.com> <201109211612.33504.arnd@arndb.de>
 <20110921152812.GE2937@atomide.com> <CAK=WgbZ_1M-p+BtJnhw_uvaCnLaFRPA_tyv-rSGWMv2GQcB5Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbZ_1M-p+BtJnhw_uvaCnLaFRPA_tyv-rSGWMv2GQcB5Cw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 21, 2011 at 6:56 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Wed, Sep 21, 2011 at 6:28 PM, Tony Lindgren <tony@atomide.com> wrote:
>> Ohad can you please try this first? Just please make sure your patches are
>> first in next tree before sending in the pull request.
>
> Sure thing.
>
> Stephen, I'll send you the location of my tree in a few.

Just before I do, Tony can I please have your Ack for the mach-omap2
part of this patch-set:

 arch/arm/mach-omap2/hwspinlock.c         |    8 +-

Thanks,
Ohad.
