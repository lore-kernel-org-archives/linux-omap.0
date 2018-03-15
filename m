From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] net: ethernet: ti: cpsw: add check for in-band mode
 setting with RGMII PHY interface
Date: Thu, 15 Mar 2018 14:19:28 -0500
Message-ID: <cbc8a349-4954-1869-f47a-3467547bd232@ti.com>
References: <20180315165603.30471-1-sz.lin@moxa.com>
 <b866b57c-2e15-978b-e1e5-5b2c7aa0a06a@ti.com>
 <eddbe437-8a9f-c7df-4e68-8a45c6d89cdb@ti.com>
 <f2a255a8-945a-6248-0c28-5ed96fbfde0b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f2a255a8-945a-6248-0c28-5ed96fbfde0b@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?U1ogTGluICjmnpfkuIo=?= =?UTF-8?B?5pm6KQ==?= <sz.lin@moxa.com>, "David S. Miller" <davem@davemloft.net>
Cc: Schuyler Patton <spatton@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 03/15/2018 01:29 PM, Florian Fainelli wrote:
> On 03/15/2018 11:18 AM, Grygorii Strashko wrote:
>>
>>
>> On 03/15/2018 12:39 PM, Grygorii Strashko wrote:
>>>
>>>
>>> On 03/15/2018 11:56 AM, SZ Lin (林上智) wrote:
>>>> According to AM335x TRM[1] 14.3.6.2, AM437x TRM[2] 15.3.6.2 and
>>>> DRA7 TRM[3] 24.11.4.8.7.3.3, in-band mode in EXT_EN(bit18) register
>>>> is only
>>>> available when PHY is configured in RGMII mode with 10Mbps speed. It
>>>> will
>>>> cause some networking issues without RGMII mode, such as carrier sense
>>>> errors and low throughput. TI also mentioned this issue in their
>>>> forum[4].
>>>>
>>>> This patch adds the check mechanism for PHY interface with RGMII
>>>> interface
>>>> type, the in-band mode can only be set in RGMII mode with 10Mbps speed.
>>>>
>>>> References:
>>>> [1]: https://www.ti.com/lit/ug/spruh73p/spruh73p.pdf
>>>> [2]: http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf
>>>> [3]: http://www.ti.com/lit/ug/spruic2b/spruic2b.pdf
>>>> [4]: https://e2e.ti.com/support/arm/sitara_arm/f/791/p/640765/2392155
>>>>
>>>> Suggested-by: Holsety Chen (陳憲輝) <Holsety.Chen@moxa.com>
>>>> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
>>>> Signed-off-by: Schuyler Patton <spatton@ti.com>
>>>> ---
>>>> Changes from v1:
>>>> - Use phy_interface_is_rgmii helper function
>>>> - Remove blank line
>>>>
>>>
>>> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>
>>
>> Also could this be marked as stable material 4.9+?
> 
> This is not how it works for networking changes, just make sure you
> provide a "Fixes:" tag, and David would usually take care of queueing
> the change to -stable accordingly:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/netdev-FAQ.txt#n148
> 

Sry, I know that, but this patch fixes very old commit [1] and it can't be
applied to old Kernels without merge conflicts or build errors:(, 
so I've manually checked if it can be applied to most recent stable kernels
and noted kernel versions here.
Also there is dependency from phy_interface_is_rgmii() which was merged in v4.2.

[1] commit a81d8762d713 ("drivers: net cpsw: Enable In Band mode in cpsw for 10 mbps")
^ went in v3.13
-- 
regards,
-grygorii
