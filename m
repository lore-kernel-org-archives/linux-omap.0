From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 23/42] drivers: gpio: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 12:01:17 -0700
Message-ID: <ff274306-df7e-4715-46f6-fecb09714f66@gmail.com>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-23-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-23-git-send-email-info@metux.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, thierry.reding@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 3/11/19 11:55 AM, Enrico Weigelt, metux IT consult wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

The subject is missing an "octeon: " part here to indicate which driver
this applies to.

Maybe you should convert all drivers in one go though?
-- 
Florian
