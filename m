From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 09/12] i2c: ocores: enable atomic xfers
Date: Fri, 5 Apr 2019 21:20:21 +0200
Message-ID: <20190405192021.GH23536@lunn.ch>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403124019.8947-10-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403124019.8947-10-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 03, 2019 at 02:40:16PM +0200, Wolfram Sang wrote:
> The driver already has the routine in place, tie it to the new callback.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Andrew Lunn <andrew@lunn.ch>

The polling function was not really designed with the intention to be
used in atomic context. But it does appear to be safe to use in that
context.

So

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
