From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/5] pinctrl: single: Use generic pinctrl helpers for
 managing groups
Date: Fri, 30 Dec 2016 15:32:23 +0100
Message-ID: <CACRpkdb29OrNgoZ46Fi0KT_y1ZiYmwBfDcsoz0LvXLJ79pCEMQ@mail.gmail.com>
References: <20161227172003.6517-1-tony@atomide.com> <20161227172003.6517-5-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161227172003.6517-5-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 27, 2016 at 6:20 PM, Tony Lindgren <tony@atomide.com> wrote:

> We can now drop the driver specific code for managing groups.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied!

> +       select GENERIC_PINCTRL

Replaced this with GENERIC_PINCTRL_GROUPS

Yours,
Linus Walleij
