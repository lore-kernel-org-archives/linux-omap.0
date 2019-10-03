From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-sancloud-bbe: Fix PHY mode for ethernet
Date: Thu, 3 Oct 2019 12:31:49 +0300
Message-ID: <d85cd860-22a3-6142-7f2d-736a428d7a31@ti.com>
References: <20191002095416.19603-1-jhofstee@victronenergy.com>
 <d027ef07-807d-6a7b-2939-b67be4542469@ti.com>
 <436f1712-7dec-db40-d08f-1a3032af3596@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <436f1712-7dec-db40-d08f-1a3032af3596@victronenergy.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeroen Hofstee <jhofstee@victronenergy.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Koen Kooi <koen@dominion.thruhere.net>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 03/10/2019 11:16, Jeroen Hofstee wrote:
> Hello Grygorri,
> 
> On 10/2/19 4:48 PM, Grygorii Strashko wrote:
>>
>>
>> On 02/10/2019 12:54, Jeroen Hofstee wrote:
>>> cd28d1d6e52e: ("net: phy: at803x: Disable phy delay for RGMII mode")
>>> broke
>>> the ethernet networking on the beaglebone enhanced.
>>
>> Above commit is incorrect (by itself) and there are few more commits
>> on top of
>> it, so pls. update reference to commit(s)
>>
>> bb0ce4c1517d net: phy: at803x: stop switching phy delay config needlessly
>> 6d4cd041f0af net: phy: at803x: disable delay only for RGMII mode
>>
>>
> I don't see why that is relevant. The mention patch introduces a
> backwards incompatibility for the device tree. 

Pls read https://patchwork.kernel.org/patch/10773389/
The patch you've mentioned here is buggy by itself and not related to your
fix, but final at803x behavior actually defined by above two commits.

I've posted this commit because I was confused when i've checked commit you referenced.

The patches you
> mention don't fix that and hence are unrelated to this patch.

No. but they define new at803x behavior which is:
After commits (see above) at803x driver disable RX RGMII delay
if phy-mode = "rgmii-txid"
or will disable TX RGMII delay
if phy-mode = "rgmii-rxid"

Before above commits, the at803x driver was keeping RX or TX RGMII delay setting
untouched as per bootloader or bootstraping configuration for "rgmii-txid"/"rgmii-rxid".

> 
> Furthermore 4.19 is fine, so there is no need to include it in stable
> and have a note to make sure also other patches are required etc.

Hence all above patches went in 5.1 it would be correct to mention only
6d4cd041f0af net: phy: at803x: disable delay only for RGMII mode

-- 
Best regards,
grygorii
