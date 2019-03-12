From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 38/42] drivers: gpio: vr41xx: use
 devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 09:02:32 -0700
Message-ID: <18445a6d-09b2-f2d1-fd7b-4dfbbaf99981@gmail.com>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-38-git-send-email-info@metux.net>
 <20190312113732.GG31026@ulmo>
 <e224f52a-a92b-63cd-a9ed-67672a2c7337@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e224f52a-a92b-63cd-a9ed-67672a2c7337@metux.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>, Thierry Reding <thierry.reding@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 3/12/2019 8:42 AM, Enrico Weigelt, metux IT consult wrote:
> On 12.03.19 12:37, Thierry Reding wrote:
> 
>> The driver currently doesn't request the memory described in the
>> resource, so technically you're changing behaviour here and with your
>> change the driver could now fail if somebody else has already claimed
>> the memory.
> 
> hmm, using w/o requesting/claiming - isn't that a bug ?

Not necessarily, before regmap existed, you could have very well
delegated a subset of a larger resource to a specific driver while a
driver requesting that larger resource would be responsible for doing
the request_mem_region(). As long as both drivers don't stomp on each
other, this is a perfectly valid way to delegate, yet keep things
modular/separate.
-- 
Florian
