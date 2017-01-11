From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: gpio: pcf857x: lockdep warning on v4.10-rc3
Date: Wed, 11 Jan 2017 16:38:30 +0100
Message-ID: <CACRpkdb0KUZabcgAqS1CzWnXt6fyA=CzE9ged1_Ed=+fZB+mqA@mail.gmail.com>
References: <48bef841-5267-fcdb-2398-095f6f7ae51e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <48bef841-5267-fcdb-2398-095f6f7ae51e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 10, 2017 at 1:18 PM, Roger Quadros <rogerq@ti.com> wrote:

> Hi Linus,
>
> I see the following lockdep warning on v4.10-rc3 on TI's dra7-evm.
>
> reverting (d245b3f9bd3 "gpio: simplify adding threaded interrupts") seems to fix it.

I sent out a patch today:
"gpio: provide lockdep keys for nested/unnested irqchips"

could you test and see if it solves your problem?

Yours,
Linus Walleij
