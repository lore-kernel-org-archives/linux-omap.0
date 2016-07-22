From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: mach-omap2: remove bogus "or_module" from
 rx51-peripherals
Date: Thu, 21 Jul 2016 23:41:02 -0700
Message-ID: <20160722064101.GW28140@atomide.com>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
 <20160720041332.30789-2-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160720041332.30789-2-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Paul Gortmaker <paul.gortmaker@windriver.com> [160719 21:17]:
> During unrelated work, attempting to remove an include of the
> linux/module.h in favour of "struct module;" in order to reduce
> header entanglement, we found doing so caused a build failure in
> this file.

We're planning to drop this file after v4.8-rc1 after I've
verified that legacy booting still works at v4.8-rc1.

Are you OK if I pick this patch into my omap-for-v4.8/legacy
branch? Or if you have a minimal immutable branch against v4.7-rc1
with just this patch I can merge it in no problem.

Regards,

Tony
