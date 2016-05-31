From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RESEND PATCH] gpio: pcf857x: restore the initial line state of
 all pcf lines
Date: Tue, 31 May 2016 10:40:34 +0200
Message-ID: <CACRpkdYLzZ3PeQDoje+_9GE9a_FaVWeRNhPP5fu+q2ixXj7Sew@mail.gmail.com>
References: <1464330929-10910-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464330929-10910-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, May 27, 2016 at 8:35 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:

> The reset values for all the PCF lines are high and hence on
> shutdown we should drive all the lines high in order to
> bring it to the reset state.
>
> This is actually required since PCF doesn't have a reset
> line and even after warm reset (by invoking "reboot" in
> prompt) the PCF lines maintains it's previous programmed
> state. This becomes a problem if the boards are designed to
> work with the default initial state.
>
> DRA7XX_evm uses PCF8575 and one of the PCF output lines
> feeds to MMC/SD VDD and this line should be driven high in order
> for the MMC/SD to be detected.  This line is modelled as
> regulator and the hsmmc driver takes care of enabling and
> disabling it. In the case of 'reboot', during shutdown path
> as part of it's cleanup process the hsmmc driver disables
> this regulator. This makes MMC *boot* not functional.
>
> Fix it by driving all the pcf lines high.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Patch applied.

Yours,
Linus Walleij
