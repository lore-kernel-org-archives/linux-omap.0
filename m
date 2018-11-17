From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux definitions
Date: Sat, 17 Nov 2018 13:27:05 +0100
Message-ID: <CACRpkdYtvD+unm9sCRxJ1DYWM1viC8Pc6ge2TpRHYko4u0Ah3g@mail.gmail.com>
References: <20181113060111.16374-1-vigneshr@ti.com> <20181113060111.16374-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113060111.16374-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, ext Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 13, 2018 at 7:00 AM Vignesh R <vigneshr@ti.com> wrote:

> The dt-bindings header for TI K3 AM6 SoCs define a set of macros for
> defining pinmux configs in human readable form, instead of raw-coded
> hex values.
>
> Signed-off-by: Vignesh R <vigneshr@ti.com>

I guess you want to merge this through ARM SoC along witg the other
patches so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
