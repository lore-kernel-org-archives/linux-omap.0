From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: fix irq triggering in smart-idle wakeup mode
Date: Fri, 15 Apr 2016 10:32:23 +0200
Message-ID: <CACRpkdbGcO7i5B9e3dicAEaTTfG7u_owe3hS2u6Sd6tCNXNzBg@mail.gmail.com>
References: <1460458351-24187-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1460458351-24187-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 12, 2016 at 12:52 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Now GPIO IRQ loss is observed on dra7-evm after suspend/resume cycle
(...)
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Can I get some explicit ACK / Tested-by tags for this patch?

Is it a serious regression that will need to go in as a fix and
tagged for stable?

Yours,
Linus Walleij
