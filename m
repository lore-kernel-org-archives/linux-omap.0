From: Keerthy <j-keerthy@ti.com>
Subject: Re: Regression in v4.20 with net phy soft reset changes
Date: Thu, 10 Jan 2019 11:20:10 +0530
Message-ID: <63ffba1c-47c1-a32b-68d6-0c3c31b74dd8@ti.com>
References: <20190109190650.GT5544@atomide.com>
 <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
 <20190109213611.GU5544@atomide.com>
 <5bdce91b-cd56-75eb-c6d2-5542869b716e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5bdce91b-cd56-75eb-c6d2-5542869b716e@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Heiner Kallweit <hkallweit1@gmail.com>, Sekhar Nori <nsekhar@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Clemens Gruber <clemens.gruber@pqgruber.com>, Florian Fainelli <f.fainelli@gmail.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, WingMan Kwok <w-kwok2@ti.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Murali Karicheri <m-karicheri2@ti.com>, linux-arm-kernel@lists.infradead.org, Rex Chang <rchang@ti.com>, linux-omap@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Chris Healy <cphealy@gmail.com>
List-Id: linux-omap@vger.kernel.org



On Thursday 10 January 2019 10:36 AM, Keerthy wrote:
> 
> 
> On Thursday 10 January 2019 03:06 AM, Tony Lindgren wrote:
>> Hi,
>>
>> * Heiner Kallweit <hkallweit1@gmail.com> [190109 19:28]:
>>> On 09.01.2019 20:06, Tony Lindgren wrote:
>>>> Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
>>>> a regression where suspend resume cycle fails to bring up Ethernet on at
>>>> least cpsw on am437x-sk-evm.
>>>>
>>> What kind of PHY and which PHY driver is used with this board?
>>> I found one schematics of am437x where a KSZ9031RN PHY is used.
>>> Is it the same on your board?
>>
>> Yes that's the phy.
>>
>>> As described in the commit message of this commit you would have
>>> the option to implement the soft_reset callback in the PHY driver.
>>> Can you try to add .soft_reset = genphy_soft_reset to the
>>> KSZ9031 driver config in drivers/net/phy/micrel.c and check whether
>>> it fixes the issue?
>>
>> Yes that seems to work based on a quick test of five suspend
>> resume cycles.
> 

Removing Grygorii as the e-mail no longer exists

To add to Tony's observations. I ran a 100 time suspend/resume adding the
soft_reset hook to the phy_driver structs in drivers/net/phy/micrel.c and
suspend/resume (DS0) works nicely.

> 
>>
>> I wonder what all hardware this issue affects though?
>>
>> It's probably best that the network folks check what all
>> hardare needs patching.
>>
>> For TI hardware, Sekhar and TI network folks, can you guys
>> please check the various TI SoCs for multiple suspend resume
>> cycles with v5.0-rc1 and patch accordingly? See also below
>> for something else to check, 10 seconds to resume a phy
>> seems very long to me :)
>>
>>>> Keerthy noticed this may not happen on the first resume, but usually
>>>> happens after few suspend resume cycles. The most working suspend resume
>>>> cycles I've seen with the commit above is three.
>> ...
>>>> Note that unrelated to the commit above, there may be other issues too
>>>> as the cpsw phy LED seems to come on only after about five seconds with
>>>> about total of 10 seconds before the Ethernet is up again.
>>
>> Regards,
>>
>> Tony
>>
