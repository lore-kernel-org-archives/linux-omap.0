From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: fix irq triggering in smart-idle wakeup mode
Date: Fri, 15 Apr 2016 11:54:30 -0700
Message-ID: <20160415185429.GU5995@atomide.com>
References: <1460458351-24187-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdbGcO7i5B9e3dicAEaTTfG7u_owe3hS2u6Sd6tCNXNzBg@mail.gmail.com>
 <5710B3B9.4090807@ti.com>
 <571106F3.9070805@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <571106F3.9070805@oracle.com>
Sender: linux-gpio-owner@vger.kernel.org
To: santosh shilimkar <santosh.shilimkar@oracle.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* santosh shilimkar <santosh.shilimkar@oracle.com> [160415 08:22]:
> On 4/15/2016 2:26 AM, Grygorii Strashko wrote:
> >
> >Santosh, Tony, do you want me to perform any additional actions regarding this patch?
> >
> This patch should be run across family of SOCs to make
> sure wakeup works on all of those if not done already

Also, I'm not sure if we can just drop this code in question.

After this patch, what function updates the GPIO wkup_en registers
depending on enable_irq_wake()/disable_irq_wake()?

Regards,

Tony
