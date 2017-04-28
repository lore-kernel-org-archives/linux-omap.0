From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] gpio: omap: return error if requested debounce time is
 not possible
Date: Fri, 28 Apr 2017 09:51:05 +0200
Message-ID: <CACRpkdYNCk9SdK+H4rTqdchvTZ+xyzMVVhpJJyD95iboSwaxEg@mail.gmail.com>
References: <20170424225650.17566-1-drivshin@awxrd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170424225650.17566-1-drivshin@awxrd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rivshin <drivshin@awxrd.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, linux-arm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 25, 2017 at 12:56 AM, David Rivshin <drivshin@awxrd.com> wrote:

> From: David Rivshin <DRivshin@allworx.com>
>
> omap_gpio_debounce() does not validate that the requested debounce
> is within a range it can handle. Instead it lets the register value
> wrap silently, and always returns success.
>
> This can lead to all sorts of unexpected behavior, such as gpio_keys
> asking for a too-long debounce, but getting a very short debounce in
> practice.
>
> Fix this by returning -EINVAL if the requested value does not fit into
> the register field. If there is no debounce clock available at all,
> return -ENOTSUPP.
>
> Fixes: e85ec6c3047b ("gpio: omap: fix omap2_set_gpio_debounce")
> Cc: <stable@vger.kernel.org> # 4.3+
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> ---
> Changes since v1 (https://lkml.org/lkml/2017/3/16/1094):
> - Added dev_info() in omap_gpio_debounce() on error.

Patch applied with Grygorii's ACK.

Yours,
Linus Walleij
