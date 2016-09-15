From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/7] mfd: Fix all W=1 warnings
Date: Thu, 15 Sep 2016 14:44:35 +0200
Message-ID: <CACRpkdYGW4bkWXZp6JWMLCxne0a7cp9rNkipA_tZmzL=9CRjfw@mail.gmail.com>
References: <20160915104521.14286-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915104521.14286-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 15, 2016 at 12:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It really is as simple as it sounds!
>
> Lee Jones (7):
>   mfd: max8997-irq: 'inline' should be at the beginning of the
>     declaration
>   mfd: ab8500-debugfs: Prevent initialised field from being over-written
>   mfd: db8500-prcmu: Remove unused *prcmu_set_ddr_opp() calls
>   mfd: ab8500-debugfs: Remove ab8500_dump_all_banks_to_mem()
>   mfd: ab8500-debugfs: Remove 'weak' function
>     suspend_test_wake_cause_interrupt_is_mine()
>   mfd: omap-usb-host: Return value is not 'const int'
>   mfd: cros_ec_spi: Remove unused variable 'request'

Acked-by: Linus Walleij <linus.walleij@linaro.org>

For all the ab8500 and db8500 stuff.

Yours,
Linus Walleij
