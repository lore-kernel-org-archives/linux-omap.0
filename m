From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
Date: Mon, 22 Jan 2018 16:49:51 +0200
Message-ID: <CAHp75VdkShHhxL+3PyaPEC2Dyr8aWoEH8CQk+bEJ2WD4i6ojHg@mail.gmail.com>
References: <1516575793-30526-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1516575793-30526-1-git-send-email-david@lechnology.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Lechner <david@lechnology.com>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 22, 2018 at 1:03 AM, David Lechner <david@lechnology.com> wrote:
> This fixes pcs_request_gpio() in the pinctrl-single driver when
> bits_per_mux != 0. It appears this was overlooked when the multiple
> pins per register feature was added.
>
> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure
> multiple pins of different modules")

One line?

> +                       byte_num = (pcs->bits_per_pin * pin) / BITS_PER_BYTE;
> +                       offset = (byte_num / mux_bytes) * mux_bytes;
> +                       pin_shift = pin % (pcs->width / pcs->bits_per_pin) *
> +                                   pcs->bits_per_pin;

Sounds like playing around pretty well defined macro and functions,
e.g. DIV_ROUND_UP(), round_up().

-- 
With Best Regards,
Andy Shevchenko
