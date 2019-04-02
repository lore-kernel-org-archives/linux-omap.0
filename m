From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 29/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
Date: Tue, 2 Apr 2019 16:18:53 +0700
Message-ID: <CACRpkdZMpZMHR22USj_m+_j6=nKCsZbJ6FumSO0EtYvw0OsH3A@mail.gmail.com>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-29-git-send-email-info@metux.net> <CACRpkdYa+oaw-P9aYL6KApvetVBZLt7USVV3kx7xZ4R7U=Hfew@mail.gmail.com>
 <CAMz4ku+L_iAGB4HrBuS8w5AQus1AZgKpbWbABbHwzDPWj9-rqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4ku+L_iAGB4HrBuS8w5AQus1AZgKpbWbABbHwzDPWj9-rqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andrew Jeffery <andrew@aj.id.au>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Hoan Tran <hoan@os.amperecomputing.com>, Orson Zhai <orsonzhai@gmail.com>, Lyra Zhang <zhang.lyra@gmail.com>, Keguang Zhang <keguang.zhang@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 2, 2019 at 4:10 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Tue, 2 Apr 2019 at 17:04, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Tue, Mar 12, 2019 at 1:57 AM Enrico Weigelt, metux IT consult
> > <info@metux.net> wrote:
> >
> > > Use the new helper that wraps the calls to platform_get_resource()
> > > and devm_ioremap_resource() together.
> > >
> > > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> >
> > Patch applied with Baolin's ACK.
>
> This patch had some problems which I've pointed out and I did not ack
> this patch. Please do not apply it now until fixing the problem.

Sorry, it's the gmail threading that confuse the different patches.

The patch I actually applied is for gpio-sprd.c and looks like this:

commit 851f66daeab961328507dcce0980cd7e4ff5f9ae (HEAD -> devel)
Author: Enrico Weigelt, metux IT consult <info@metux.net>
Date:   Mon Mar 11 19:55:08 2019 +0100

    drivers: gpio: sprd: use devm_platform_ioremap_resource()

    Use the new helper that wraps the calls to platform_get_resource()
    and devm_ioremap_resource() together.

    Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
    Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index 55072d2b367f..f5c8b3a351d5 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -219,7 +219,6 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 {
        struct gpio_irq_chip *irq;
        struct sprd_gpio *sprd_gpio;
-       struct resource *res;
        int ret;

        sprd_gpio = devm_kzalloc(&pdev->dev, sizeof(*sprd_gpio), GFP_KERNEL);
@@ -232,8 +231,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
                return sprd_gpio->irq;
        }

-       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-       sprd_gpio->base = devm_ioremap_resource(&pdev->dev, res);
+       sprd_gpio->base = devm_platform_ioremap_resource(pdev, 0);
        if (IS_ERR(sprd_gpio->base))
                return PTR_ERR(sprd_gpio->base);

Yours,
Linus Walleij
