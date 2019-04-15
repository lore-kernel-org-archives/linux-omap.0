From: Stefan Lengfeld <contact@stefanchrist.eu>
Subject: Re: [PATCH 03/12] i2c: core: introduce callbacks for atomic transfers
Date: Mon, 15 Apr 2019 23:57:48 +0200
Message-ID: <20190415215748.e6jrii25nqliy7me@porty>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403124019.8947-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403124019.8947-4-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi Wolfram,

On Wed, Apr 03, 2019 at 02:40:10PM +0200, Wolfram Sang wrote:
> We had the request to access devices very late when interrupts are not
> available anymore multiple times now. Mostly to prepare shutdown or
> reboot. Allow adapters to specify a specific callback for this case.
> Note that we fall back to the generic {master|smbus}_xfer callback if
> this new atomic one is not present. This is intentional to preserve the
> previous behaviour and avoid regressions. Because there are drivers not
> using interrupts or because it might have worked "accidently" before.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested-by: Stefan Lengfeld <contact@stefanchrist.eu>

Kind regards,
Stefan
