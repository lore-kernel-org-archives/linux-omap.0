From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: omap: Remove Unused Code
Date: Mon, 17 Jul 2017 09:09:18 +0200
Message-ID: <CAPDyKFqk1fnL_CFSfgg2P44-KD9H=6mvK6ppXoDe=Xy38ujiFA@mail.gmail.com>
References: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com> <20170717060101.GB10026@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717060101.GB10026@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Faiz Abbas <faiz_abbas@ti.com>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kishon <kishon@ti.com>, Ravikumar Kattekola <rk@ti.com>, Sekhar Nori <nsekhar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 17 July 2017 at 08:01, Tony Lindgren <tony@atomide.com> wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [170714 05:48]:
>> This patch series removes some code in omap_hsmmc.c
>> and hsmmc.c and members from hsmmc.h and
>> hsmmc-omap.h which are not used anymore post
>> conversion to device-tree.
>
> Hey that's nice! That gets us a bit closer removing the
> old platform data for that driver.

Tony,

As it seems Kishon is working on some more omap_hsmmc changes, I
wondering whether it's fine if I pick this series via my mmc tree. To
avoid merge conflicts later on?

Kind regards
Uffe
