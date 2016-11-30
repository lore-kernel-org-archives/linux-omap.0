From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] Documentation: pinctrl: palmas: Add
 ti,palmas-powerhold-override property definition
Date: Wed, 30 Nov 2016 13:55:22 +0100
Message-ID: <CACRpkdb36Au+QSM4mnGHunKVz-0qJ2n2dCwTV4tq5H7nxQEo1w@mail.gmail.com>
References: <1480305718-5127-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1480305718-5127-1-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, ext Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 28, 2016 at 5:01 AM, Keerthy <j-keerthy@ti.com> wrote:
> GPIO7 is configured in POWERHOLD mode which has higher priority
> over DEV_ON bit and keeps the PMIC supplies on even after the DEV_ON
> bit is turned off. This property enables driver to over ride the
> POWERHOLD value to GPIO7 so as to turn off the PMIC in power off
> scenarios.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>
> Remaining patches of the series are already queued.
>
> Changes in v3: Added Rob's Ack.

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
