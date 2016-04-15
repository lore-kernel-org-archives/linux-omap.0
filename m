From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: fix irq triggering in smart-idle wakeup mode
Date: Fri, 15 Apr 2016 08:21:09 -0700
Message-ID: <20160415152109.GQ5995@atomide.com>
References: <1460458351-24187-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdbGcO7i5B9e3dicAEaTTfG7u_owe3hS2u6Sd6tCNXNzBg@mail.gmail.com>
 <5710B3B9.4090807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5710B3B9.4090807@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160415 02:27]:
> On 04/15/2016 11:32 AM, Linus Walleij wrote:
> > On Tue, Apr 12, 2016 at 12:52 PM, Grygorii Strashko
> > <grygorii.strashko@ti.com> wrote:
> > 
> >> Now GPIO IRQ loss is observed on dra7-evm after suspend/resume cycle
> > (...)
> >> Cc: Roger Quadros <rogerq@ti.com>
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > 
> > Can I get some explicit ACK / Tested-by tags for this patch?
> 
> Roger's promised to test it once suspend regression will be fixed
> for dra7-evm, probably next rc.
> 
> > 
> > Is it a serious regression that will need to go in as a fix and
> > tagged for stable?
> > 
> 
> This issue is here since 2012, so I think it's not very critical -
> It seems bits combination which causing the issue is rare.
> 
> Regarding stable:
> 4.4 - good to have, simple merge conflict
> 4.1 - some merge resolution is required
> older kernel - it will be hard to backport it due to significant
> changes in omap gpio driver
> 
> Santosh, Tony, do you want me to perform any additional actions regarding this patch?

Well maybe update the comments regarding non-interrupt GPIO
lines and wake-up events. Santosh may have other comments.

Regards,

Tony
