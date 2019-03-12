From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 16/42] drivers: gpio: janz-ttl: drop unneccessary temp
 variable dev
Date: Tue, 12 Mar 2019 10:33:44 +0100
Message-ID: <93ae13c0-da78-0e6a-358f-97e358c11f16@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-16-git-send-email-info@metux.net>
 <539b3cd4-8af3-d6d8-f5a9-2c426a1f0faa@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <539b3cd4-8af3-d6d8-f5a9-2c426a1f0faa@codethink.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>, "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, thierry.reding@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12.03.19 10:17, Ben Dooks wrote:
> On 11/03/2019 18:54, Enrico Weigelt, metux IT consult wrote:
>> don't need the temporary variable "dev", directly use &pdev->dev
>>
>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> 
> This is quite usual to do, and I like it as it saves typing.
> Personally I would say don't bother with this change.

hmm, both approaches have their valid arguments.

I'm not particularily biased to one or another ay, but I'd prefer
having it consistent  everywhere.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
