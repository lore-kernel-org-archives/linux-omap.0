From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/3] ARM: mach-omap2: remove bogus "or_module" from
 rx51-peripherals
Date: Sat, 23 Jul 2016 10:14:22 -0400
Message-ID: <20160723141421.GC12632@windriver.com>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
 <20160720041332.30789-2-paul.gortmaker@windriver.com>
 <20160722064101.GW28140@atomide.com>
 <20160722140242.GC11410@windriver.com>
 <20160723055524.GA28140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160723055524.GA28140@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

[Re: [PATCH 1/3] ARM: mach-omap2: remove bogus "or_module" from rx51-peripherals] On 22/07/2016 (Fri 22:55) Tony Lindgren wrote:

> * Paul Gortmaker <paul.gortmaker@windriver.com> [160722 07:02]:

[...]

> > Having the patch present, or having the file deleted both take care of
> > my concern -- which was was introducing build regressions when adding
> > the gpio header cleanup into for-4.9 content.  
> 
> OK. As I've already pushed out the board-*.c removal branch, I
> suggest we just drop the $subject patch to avoid a merge conflict.

Sounds like a plan.  I'll just keep it in my local queue so my tests
don't fail and drop it on the floor once I see your removal loop around
to me via linux-next or master.

Thanks,
Paul.
--

> 
> Regards,
> 
> Tony
