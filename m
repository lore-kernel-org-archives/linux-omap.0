From: Maciej Purski <m.purski@samsung.com>
Subject: Re: [PATCH v2] regulator: core: Enable voltage balancing
Date: Mon, 18 Jun 2018 15:17:31 +0200
Message-ID: <20180618131733eucas1p1351a8d5eecdfde1008e1b753eb9ade21~5Q5SUWbnP3050130501eucas1p1H@eucas1p1.samsung.com>
References: <20180605044554.GC5738@atomide.com>
        <CGME20180613103622eucas1p1778ba2c2e5dd85ccb4c488bd0a38386d@eucas1p1.samsung.com>
        <1528886026-9457-1-git-send-email-m.purski@samsung.com>
        <20180615112916.GK112168@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615112916.GK112168@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org



On 06/15/2018 01:29 PM, Tony Lindgren wrote:
> Hi,
> 
> * Maciej Purski <m.purski@samsung.com> [180613 10:39]:
>> Call regulator_balance_voltage() instead of set_voltage_rdev()
>> in set_voltage_unlocked() and in enabling and disabling functions,
>> but only if the regulator is coupled.
>>
>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>>
>> ---
>> Changes in v2:
>> - fix compile errors
>> - make debug messages more informative
> 
> Thanks for updating it. This series still hangs after loading
> modules on beagleboard-x15:
> 
> [   26.679749] smps12: regulator_set_voltage: 3381
> [   26.684529] smps12: regulator_set_voltage_unlocked:  3045
> [   26.695616] smps12: _regulator_do_set_voltage: 2912
> [   26.701275] smps12: regulator_set_voltage: 3381
> [   26.706002] smps12: regulator_set_voltage_unlocked:  3045
> [   26.712349] smps12: _regulator_do_set_voltage: 2912
> [   26.719329] abb_mpu: regulator_set_voltage: 3381
> [   26.724105] abb_mpu: regulator_set_voltage_unlocked:  3045
> 
> So it seems to be the abb_mpu where it hangs?
> 
> Regards,
> 
> Tony
> 

Hi,

thanks for testing. Yes, it seems that it fails on abb_mpu. I don't know
yet, what is so special about that regulator.

We know at least, that it fails on voltage setting somewhere
between set_voltage_unlocked() and do_set_voltage()
and it does not look like any locking issue.
The most suspicious part in voltage balancing code is of course the
infinite loop. Soon I'll send a next patch on top of my latest compiling
path:
2ff49a6 regulator: core: Enable voltage balancing.
It should reveal, if it is indeed the loop.

As usual, I'd be grateful, if you gave it a try.

Best regards,

Maciej Purski
