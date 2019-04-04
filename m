From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 12/12] i2c: gpio: flag atomic capability if possible
Date: Thu, 4 Apr 2019 22:40:23 +0700
Message-ID: <CACRpkdZFg_F95zm68vUtU51j0MzYPfFB2YFhCAnvHJqUEO8_GQ@mail.gmail.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-13-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403124019.8947-13-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 3, 2019 at 7:40 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> If switching GPIOs does not sleep, then we can support atomic transfers.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Neat and intuitive.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
