From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] pinctrl: Introduce TI IOdelay configuration driver
Date: Mon, 9 Jan 2017 19:46:23 +0100
Message-ID: <CACRpkdYCmrWyyKNkaqeUxtLV8HrmjgcXrULVvLbFhmt64wsVyQ@mail.gmail.com>
References: <20170105185414.27247-1-tony@atomide.com> <20170105185414.27247-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170105185414.27247-3-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Gary Bisson <gary.bisson@boundarydevices.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 5, 2017 at 7:54 PM, Tony Lindgren <tony@atomide.com> wrote:

> From: Nishanth Menon <nm@ti.com>
>
> SoC family such as DRA7 family of processors have, in addition
> to the regular muxing of pins (as done by pinctrl-single), a separate
> hardware module called IODelay which is also expected to be configured.
> The "IODelay" module has it's own register space that is independent
> of the control module and the padconf register area.
>
> With recent changes to the pinctrl framework, we can now support
> this hardware with a reasonably minimal driver by using #pinctrl-cells,
> GENERIC_PINCTRL_GROUPS and GENERIC_PINMUX_FUNCTIONS.
>
> It is advocated strongly in TI's official documentation considering
> the existing design of the DRA7 family of processors during mux or
> IODelay reconfiguration, there is a potential for a significant glitch
> which may cause functional impairment to certain hardware. It is
> hence recommended to do as little of muxing as absolutely necessary
> without I/O isolation (which can only be done in initial stages of
> bootloader).
>
> NOTE: with the system wide I/O isolation scheme present in DRA7 SoC
> family, it is not reasonable to do stop all I/O operations for every
> such pad configuration scheme. So, we will let it glitch when used in
> this mode.
>
> Even with the above limitation, certain functionality such as MMC has
> mandatory need for IODelay reconfiguration requirements, depending on
> speed of transfer. In these cases, with careful examination of usecase
> involved, the expected glitch can be controlled such that it does not
> impact functionality.
>
> In short, IODelay module support as a padconf driver being introduced
> here is not expected to do SoC wide I/O Isolation and is meant for
> a limited subset of IODelay configuration requirements that need to
> be dynamic and whose glitchy behavior will not cause functionality
> failure for that interface.
>
> IMPORTANT NOTE: we take the approach of keeping LOCK_BITs cleared
> to 0x0 at all times, even when configuring Manual IO Timing Modes.
> This is done by eliminating the LOCK_BIT=1 setting from Step
> of the Manual IO timing Mode configuration procedure. This option
> leaves the CFG_* registers unprotected from unintended writes to the
> CTRL_CORE_PAD_* registers while Manual IO Timing Modes are configured.
>
> This approach is taken to allow for a generic driver to exist in kernel
> world that has to be used carefully in required usecases.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> [tony@atomide.com: updated to use generic pinctrl functions, added
>  binding documentation, updated comments]
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Oh what a hardware mess. But very nicely isolated now.
Patch applied!

Yours,
Linus Walleij
