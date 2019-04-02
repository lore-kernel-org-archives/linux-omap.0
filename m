From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [BUG/PATCH 0/4] gpiolib: fix issues with legacy spi-cs-high handling
Date: Tue, 2 Apr 2019 10:19:19 +0700
Message-ID: <CACRpkdaM4t6c5gkLxv6CS559o_X=r14oP4=VoEhzyH4Du9socg@mail.gmail.com>
References: <cover.1554026842.git.hns@goldelico.com> <2D0BC383-A57A-4C36-AC48-539B4E8811C0@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2D0BC383-A57A-4C36-AC48-539B4E8811C0@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 1, 2019 at 11:59 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> I learned just some minutes ago that a new patch for gpiolib
> came through 5.1-rc3 which does fix this in almost the same way
> as I proposed.

I am sorry for not being very attentive, I have been travelling.
I collected the most urgent fixes and this was fixed as part of
that quick patchup.

> Except that it seems to check for "cs-gpios" and then disable the
> legacy handling.

Yups.

> So we do not need to add a config option for this legacy
> handling (although I'd prefer to have it anyways to remove
> some dead code).
>
> Summary: this series can now be ignored.

OK please verify that we are doing things right now, the big
worry I have is some interrim DTBs that use the GPIO flag
GPIO_ACTIVE_HIGH, which is zero and therefore often the
default, and expect it to actually work, while the SPI bindings
by definition will ignore that and make the line active low.

I'm not very happy about this but it is a result of how we quickly
implemented some bindings in the past while the GPIO flags
were not yet standardized.

Yours,
Linus Walleij
