From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_parse_bits_in_pinctrl_entry
 to use __ffs than ffs
Date: Fri, 15 Apr 2016 11:27:51 +0200
Message-ID: <CACRpkdZxY3FNti37HfuwS7KT9K+pA=REr_G=hEQRi-D3=CHUpQ@mail.gmail.com>
References: <1460609956-26539-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460609956-26539-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 14, 2016 at 6:59 AM, Keerthy <j-keerthy@ti.com> wrote:

> pcs_parse_bits_in_pinctrl_entry uses ffs which gives bit indices
> ranging from 1 to MAX. This leads to a corner case where we try to request
> the pin number = MAX and fails.
>
> bit_pos value is being calculted using ffs. pin_num_from_lsb uses
> bit_pos value. pins array is populated with:
>
> pin + pin_num_from_lsb.
>
> The above is 1 more than usual bit indices as bit_pos uses ffs to compute
> first set bit. Hence the last of the pins array is populated with the MAX
> value and not MAX - 1 which causes error when we call pin_request.
>
> mask_pos is rightly calculated as ((pcs->fmask) << (bit_pos - 1))
> Consequently val_pos and submask are correct.
>
> Hence use __ffs which gives (ffs(x) - 1) as the first bit set.
>
> fixes: 4e7e8017a8 ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>
> Changes in v2:
>
>   * Changed pcs->fshift to use __ffs instead of ffs to be consistent.
>
> Boot tesed on da850-evm and checked the pinctrl sysfs nodes.

Patch applied for fixes with Tony's ACK.

Should it also be tagged for stable?

Yours,
Linus Walleij
