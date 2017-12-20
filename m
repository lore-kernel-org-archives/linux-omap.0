From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: single: Remove invalid message
Date: Wed, 20 Dec 2017 12:39:14 +0100
Message-ID: <CACRpkdaiPgxyqreyYyetNapFsXOaOB496pW2HmGb8Dyj5T90SQ@mail.gmail.com>
References: <20171214165115.27150-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171214165115.27150-1-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 14, 2017 at 5:51 PM, Tony Lindgren <tony@atomide.com> wrote:

> Pinctrl single should just show how many pins were found, the physical
> address is already in the dev information. So let's remove the wrong
> information that claims to show the physical address but really prints
> a virtual address that is now hashed.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied.

Yours,
Linus Walleij
