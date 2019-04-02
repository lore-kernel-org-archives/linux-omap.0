From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 29/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
Date: Tue, 2 Apr 2019 17:10:38 +0800
Message-ID: <CAMz4ku+L_iAGB4HrBuS8w5AQus1AZgKpbWbABbHwzDPWj9-rqg@mail.gmail.com>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-29-git-send-email-info@metux.net> <CACRpkdYa+oaw-P9aYL6KApvetVBZLt7USVV3kx7xZ4R7U=Hfew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYa+oaw-P9aYL6KApvetVBZLt7USVV3kx7xZ4R7U=Hfew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andrew Jeffery <andrew@aj.id.au>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Hoan Tran <hoan@os.amperecomputing.com>, Orson Zhai <orsonzhai@gmail.com>, Lyra Zhang <zhang.lyra@gmail.com>, Keguang Zhang <keguang.zhang@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert
List-Id: linux-omap@vger.kernel.org

Hi Linus,

On Tue, 2 Apr 2019 at 17:04, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Mar 12, 2019 at 1:57 AM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>
> > Use the new helper that wraps the calls to platform_get_resource()
> > and devm_ioremap_resource() together.
> >
> > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
>
> Patch applied with Baolin's ACK.

This patch had some problems which I've pointed out and I did not ack
this patch. Please do not apply it now until fixing the problem.

-- 
Baolin Wang
Best Regards
