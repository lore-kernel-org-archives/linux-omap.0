From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH] gpio: omap: Fix lost edge interrupts
Date: Wed, 4 Oct 2017 08:48:38 -0700
Message-ID: <20171004154838.GT4394@atomide.com>
References: <20171003161705.23398-1-grygorii.strashko@ti.com>
 <7b8f3c6a-0f4b-98ed-3887-91a01ed6cdbb@oracle.com>
 <81906eda-58ac-38e3-bc0a-8ead2b6aa8df@ti.com>
 <20171003172228.2p5ebam7cpqrhmsa@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171003172228.2p5ebam7cpqrhmsa@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [171003 10:23]:
> But there's another missing piece to make edge irqs work on OMAPs:
> https://marc.info/?l=linux-omap&m=149037823114641&w=2
> Tony, what is the status of your patch? Perhaps we should spin-off
> separate thread for it...

Oh so did that fix things for you? It never went anywhere as I was waiting
for you to test it.. Yeah let's start a separate thread on that one.

Regards,

Tony
