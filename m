From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Fri, 8 Feb 2019 14:51:20 +0100
Message-ID: <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com> <1549290167-876-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549290167-876-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Suman Anna <s-anna@ti.com>, David Lechner <david@lechnology.com>, "Nori, Sekhar" <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, nsaulnier@ti.com, jreeder@ti.com, Murali Karicheri <m-karicheri2@ti.com>, woods.technical@gmail.com, Linux-OMAP <linux-omap@vger.kernel.org>, linux-remoteproc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 4, 2019 at 3:24 PM Roger Quadros <rogerq@ti.com> wrote:

> From: Suman Anna <s-anna@ti.com>
>
> This patch adds the bindings for the Programmable Real-Time Unit
> and Industrial Communication Subsystem (PRU-ICSS) present on various
> SoCs such as AM33xx, AM437x, AM57xx, Keystone 66AK2G SoC, etc. It is
> present on the Davinci based OMAPL138 SoCs and K3 architecture
> based AM65x SoCs as well (not covered for now).
>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

(...)
> +               pruss_intc: intc@20000 {
> +                       compatible = "ti,am3356-pruss-intc";
> +                       reg = <0x20000 0x2000>;
> +                       reg-names = "intc";
> +                       interrupt-controller;
> +                       #interrupt-cells = <1>;
> +                       interrupts = <20 21 22 23 24 25 26 27>;
> +                       interrupt-names = "host2", "host3", "host4",
> +                                         "host5", "host6", "host7",
> +                                         "host8", "host9";

If thsese interrupts are mapped 1-to-1 to a parent interrupt controller
then this is a hierarchical interrupt domain and then these should
be handled locally in the driver as offset from child to parent
statically encoded in the driver.

Several old drivers and old device tree bindings make this kind
of maps, but it is not how we do it anymore, if we can avoid it.

To be able to use hierarchical interrupt domain in the kernel, the top
interrupt controller must use the hierarchical (v2) irqdomain, so
if this is anything else than the ARM GIC it will be an interesting
undertaking to handle this.

The more I understand of hierarchical irqdomains, the more of
workarounds where we should be using it I see, we really need
to spread this knowledge. Using it requires a lot of upfront work
sometimes, sorry about that but the end result is so much better.

Yours,
Linus Walleij
