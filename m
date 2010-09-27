From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v4 1/4] omap4 hsmmc: Adding card detect support for MMC1
Date: Mon, 27 Sep 2010 13:22:47 +0530
Message-ID: <AANLkTikr4mG_oFngkFvH7TWEvm0P2M2M8-dZV4Xtm5B-@mail.gmail.com>
References: <9408.10.24.255.18.1285348400.squirrel@dbdmail.itg.ti.com>
	<20100925003859.GR4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20100925003859.GR4211@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, madhu.cr@ti.com, adrian.hunter@nokia.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Sat, Sep 25, 2010 at 6:08 AM, Tony Lindgren <tony@atomide.com> wrote:
> * kishore kadiyala <kishore.kadiyala@ti.com> [100924 10:05]:
>> Adding card detect callback function and card detect configuration
>> function for MMC1 Controller on OMAP4.
>>
>> Card detect configuration function does initial configuration of the
>> MMC Control & PullUp-PullDown registers of Phoenix.
>>
>> For MMC1 Controller, card detect interrupt source is
>> twl6030 which is non-gpio. The card detect call back function provides
>> card present/absent status by reading MMC Control register present
>> on twl6030.
>>
>> Since OMAP4 doesn't use any GPIO line as used in OMAP3 for card detect,
>> the suspend/resume initialization which was done in omap_hsmmc_gpio_init
>> previously is moved to the probe thus making it generic for both OMAP3 & OMAP4.
>
>> --- a/drivers/mfd/twl6030-irq.c
>> +++ b/drivers/mfd/twl6030-irq.c
>
> Looks like this patch should be sent to Samuel Ortiz as it's mostly
> mfd related.

Thanks , I will send this patch to Samuel.

<snip>

Regards,
Kishore
