From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: omap: fix irq triggering in smart-idle wakeup mode
Date: Fri, 15 Apr 2016 12:26:17 +0300
Message-ID: <5710B3B9.4090807@ti.com>
References: <1460458351-24187-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdbGcO7i5B9e3dicAEaTTfG7u_owe3hS2u6Sd6tCNXNzBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbGcO7i5B9e3dicAEaTTfG7u_owe3hS2u6Sd6tCNXNzBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On 04/15/2016 11:32 AM, Linus Walleij wrote:
> On Tue, Apr 12, 2016 at 12:52 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> 
>> Now GPIO IRQ loss is observed on dra7-evm after suspend/resume cycle
> (...)
>> Cc: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Can I get some explicit ACK / Tested-by tags for this patch?

Roger's promised to test it once suspend regression will be fixed
for dra7-evm, probably next rc.

> 
> Is it a serious regression that will need to go in as a fix and
> tagged for stable?
> 

This issue is here since 2012, so I think it's not very critical -
It seems bits combination which causing the issue is rare.

Regarding stable:
4.4 - good to have, simple merge conflict
4.1 - some merge resolution is required
older kernel - it will be hard to backport it due to significant
changes in omap gpio driver

Santosh, Tony, do you want me to perform any additional actions regarding this patch?
-- 
regards,
-grygorii
