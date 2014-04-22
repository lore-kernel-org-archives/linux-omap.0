From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 0/5] add gpio_chip_ops to hold GPIO operations
Date: Tue, 22 Apr 2014 13:36:24 +0200
Message-ID: <CACRpkdYLaGXJ+O0rsL5+rjUsOvxCxK2b9QtH2j4FD0g21vx8_Q@mail.gmail.com>
References: <1396981215-24888-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1396981215-24888-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 8, 2014 at 8:20 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> So this is an RFC patch-set to add a virtual table to be used by
> GPIO chip controllers and consist of the following patches:

Overall I like this.

However I don't want to see any transitional phase. I prefer a BIG
fat patch converting everyone and its dog to the new vtable and
removing the old function pointers. This can be based on the HEAD
of my GPIO devel branch.

It may be a good idea to use coccinelle for this refactoring in order
not to miss any users.

Yours,
Linus Walleij
