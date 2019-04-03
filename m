From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 38/42] drivers: gpio: vr41xx: use devm_platform_ioremap_resource()
Date: Wed, 3 Apr 2019 10:51:53 +0700
Message-ID: <CACRpkdYEAZPS9t2JiMuRF6ojYiz+=WEe=hvrPw853TwSVc1kog@mail.gmail.com>
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-38-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-38-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andrew Jeffery <andrew@aj.id.au>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Hoan Tran <hoan@os.amperecomputing.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Lyra Zhang <zhang.lyra@gmail.com>, Keguang Zhang <keguang.zhang@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.j>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 12, 2019 at 1:56 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> this driver deserves a bit more cleanup, to get rid of the global
> variable giu_base, which makes it single-instance-only.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Holding this back until we have more consensus and some ACKs.

Yours,
Linus Walleij
