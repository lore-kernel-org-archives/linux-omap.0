From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next 02/19] net: ethernet: ti: cpsw: drop
 TI_DAVINCI_CPDMA config option
Date: Wed, 24 Apr 2019 12:31:01 +0300
Message-ID: <32d4f384-cf74-f34e-137f-58333c7d9073@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-3-git-send-email-grygorii.strashko@ti.com>
 <20190423172709.693f4784@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423172709.693f4784@cakuba.netronome.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org



On 24.04.19 03:27, Jakub Kicinski wrote:
> On Tue, 23 Apr 2019 16:08:53 +0300, Grygorii Strashko wrote:
>> Both drivers CPSW and EMAC can't work without CPDMA, hence simplify build
>> of those drivers by always linking davinci_cpdma and drop TI_DAVINCI_CPDMA
>> config option.
>> Note. the davinci_emac driver module was changed to "ti_davinci_emac" to
>> make build work.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Last time I tried including the same object file in two different
> modules it backfired pretty badly.  Would you mind sparing some 
> details as to why you need to do this?

I've tried it as modules and inbuid and see no issues.
Issue with build happens if EXPORT_SYMBOL_GPL() not removed.

It's not expected and not supported to load more then one TI Net
driver at same hw, so modules also are just be loaded fine.

Why? It's to get rid of CONFIG options which were historically added,
but are not required now (and even can't be disabled of if disabled will
cause build failures) - result simplified build/Kconfig and code.


-- 
Best regards,
grygorii
