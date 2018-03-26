From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
Date: Mon, 26 Mar 2018 10:49:28 +0200
Message-ID: <CACRpkdYNN9zSVTxMQQd=GhH44FtdR476bQdMagS6Y3it5j1FiA@mail.gmail.com>
References: <1519077427-30165-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519077427-30165-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 19, 2018 at 10:57 PM, David Lechner <david@lechnology.com> wrote:

> This fixes pcs_request_gpio() in the pinctrl-single driver when
> bits_per_mux != 0. It appears this was overlooked when the multiple
> pins per register feature was added.
>
> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
> Signed-off-by: David Lechner <david@lechnology.com>

Patch applied for v4.17 with Tony's ACK.

Yours,
Linus Walleij
