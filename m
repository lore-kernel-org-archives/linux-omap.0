From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] hwspinlock-next
Date: Tue, 20 Sep 2011 16:13:40 -0700
Message-ID: <20110920231340.GT18894@atomide.com>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
 <CAK=Wgbam6u1bq8fG+oMUhxfWH1g3dU7q+VhPWFEZOLgFMV_3vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK=Wgbam6u1bq8fG+oMUhxfWH1g3dU7q+VhPWFEZOLgFMV_3vQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

* Ohad Ben-Cohen <ohad@wizery.com> [110920 01:34]:
> On Mon, Sep 12, 2011 at 7:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> 
> I'm wondering how hwspinlock updates like this should go upstream.
> 
> The first hwspinlock batch was picked by Tony, because it involved a
> bulk of OMAP changes.
> 
> Hwspinlock isn't OMAP-specific anymore though (we gained support for
> STE's u8500) and the vast majority of changes are in drivers/. We're
> still very much ARM-related, though this may change too at some point
> (c6x has a similar "hardware semaphore" peripheral like the u8500
> does).
> 
> Tony, if you're still willing to pick up these updates I'd be happy to
> send you pull requests of course.

I'd prefer for Greg to take these as these are drivers.

If he's not taking it at this point based on it being ARM only,
I can take it then.

Regards,

Tony
