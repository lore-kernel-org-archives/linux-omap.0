From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] pinctrl: single: Drop pointless macro
Date: Fri, 28 Oct 2016 13:54:29 +0200
Message-ID: <CACRpkdbpoVZ7Ln44tGyZEVP_zp9A9KVn=BZpjr8UuXCRhhMWAw@mail.gmail.com>
References: <20161025160900.2724-1-tony@atomide.com> <20161025160900.2724-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161025160900.2724-3-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 25, 2016 at 6:09 PM, Tony Lindgren <tony@atomide.com> wrote:

> This is left over from initial experiments with more properties.
> It's only used in one place, so let's just get rid of it to make
> the code more readable.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied.

Yours,
Linus Walleij
