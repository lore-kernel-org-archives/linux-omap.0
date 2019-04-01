From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [BUG/PATCH 0/4] gpiolib: fix issues with legacy spi-cs-high handling
Date: Mon, 1 Apr 2019 18:59:22 +0200
Message-ID: <2D0BC383-A57A-4C36-AC48-539B4E8811C0@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1554026842.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

Hi all,

> Am 31.03.2019 um 12:07 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> 2018-07-25 07:55:28: 
> 
> H. Nikolaus Schaller (4):
>  DTS: GTA04: SPI / gpiolib: work around a regression that unhides a
>    broken legacy handler, which makes the gta04 display inoperable
>  REVERT: DTS: GTA04: SPI / gpiolib: no no no, we do not want to "fix"
>    our device tree file
>  gpiolib: make legacy handling for spi-cs-high optional
>  gpiolib: spi-cs-high is checking the wrong node (the controller and
>    not the SPI slave device)
> 
> drivers/gpio/Kconfig      | 8 ++++++++
> drivers/gpio/gpiolib-of.c | 8 +++++---
> 2 files changed, 13 insertions(+), 3 deletions(-)
> 
> -- 
> 2.19.1
> 

I learned just some minutes ago that a new patch for gpiolib
came through 5.1-rc3 which does fix this in almost the same way
as I proposed.

Except that it seems to check for "cs-gpios" and then disable the
legacy handling.

So we do not need to add a config option for this legacy
handling (although I'd prefer to have it anyways to remove
some dead code).

Summary: this series can now be ignored.

BR and thanks,
Nikolaus
