From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 10/12] i2c: stu300: use xfer_atomic callback to bail out early
Date: Thu, 4 Apr 2019 22:38:45 +0700
Message-ID: <CACRpkdanoV-cx8sy5=imdznud3Q_=6N+QnROoqWg9OtPqgbwmw@mail.gmail.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-11-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403124019.8947-11-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 3, 2019 at 7:40 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> Use the new callback to reject atomic transfers.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

OK that is a reasonable placeholder.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
