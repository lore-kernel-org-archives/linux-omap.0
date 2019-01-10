From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: Regression in v4.20 with net phy soft reset changes
Date: Thu, 10 Jan 2019 17:22:02 +0530
Message-ID: <79c57d19-837e-4468-f6b4-b3bfa9dde82a@ti.com>
References: <20190109190650.GT5544@atomide.com>
 <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
 <20190109213611.GU5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190109213611.GU5544@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Clemens Gruber <clemens.gruber@pqgruber.com>, Florian Fainelli <f.fainelli@gmail.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, WingMan Kwok <w-kwok2@ti.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Murali Karicheri <m-karicheri2@ti.com>, linux-arm-kernel@lists.infradead.org, Rex Chang <rchang@ti.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Chris Healy <cphealy@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 10/01/19 3:06 AM, Tony Lindgren wrote:
> Hi,
> 
> * Heiner Kallweit <hkallweit1@gmail.com> [190109 19:28]:
>> On 09.01.2019 20:06, Tony Lindgren wrote:
>>> Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
>>> a regression where suspend resume cycle fails to bring up Ethernet on at
>>> least cpsw on am437x-sk-evm.
>>>
>> What kind of PHY and which PHY driver is used with this board?
>> I found one schematics of am437x where a KSZ9031RN PHY is used.
>> Is it the same on your board?
> 
> Yes that's the phy.
> 
>> As described in the commit message of this commit you would have
>> the option to implement the soft_reset callback in the PHY driver.
>> Can you try to add .soft_reset = genphy_soft_reset to the
>> KSZ9031 driver config in drivers/net/phy/micrel.c and check whether
>> it fixes the issue?
> 
> Yes that seems to work based on a quick test of five suspend
> resume cycles.
> 
> I wonder what all hardware this issue affects though?
> 
> It's probably best that the network folks check what all
> hardare needs patching.
> 
> For TI hardware, Sekhar and TI network folks, can you guys
> please check the various TI SoCs for multiple suspend resume
> cycles with v5.0-rc1 and patch accordingly? See also below

Will do.

> for something else to check, 10 seconds to resume a phy
> seems very long to me :)

On the AM437x GP EVM which uses the same PHY, the link does not even
come up for me after a cable plug unplug. Link is up at boot (I use
NFS). This only happens with v4.20 and v5.0-rc1, not with v4.19.

Adding the genphy_soft_reset hook solves the issue and link comes back
up almost immediately. I checked this with v5.0-rc1.

I don't see the link problem if I shift to 100Mps prior to the
plug/unplug experiment using ethtool. So looks like the problem is
restricted to Gigabit link only. Are you using Gigabit link too?

I think we should patch drivers/net/phy/micrel.c to solve the
regression. Not sure of the root cause though. In the errata pointed to
by Heiner, there is "Module 6" which comes close to what we are seeing,
except it talks of a scenario where auto-negotiation is turned off 100M
link is used and we see the issue even with auto-neg on and in gigabit
mode. "Module 5" is also related to link failure, but is already worked
around in kernel with ksz9031_center_flp_timing().

> 
>>> Keerthy noticed this may not happen on the first resume, but usually
>>> happens after few suspend resume cycles. The most working suspend resume
>>> cycles I've seen with the commit above is three.
> ...
>>> Note that unrelated to the commit above, there may be other issues too
>>> as the cpsw phy LED seems to come on only after about five seconds with
>>> about total of 10 seconds before the Ethernet is up again.

I don't quite see this problem on the AM437x GP EVM. I have seen gigabit
link takes quite some time (sometimes more than 10 seconds) on x15 EVM.
Not sure if the problem you are facing is related to gigabit too. If you
are using gigabit link, can you downgrade to 100MBps to check? Either
using a 100M only switch or by using ethtool on the EVM.

$ ethtool -s eth0 speed 100 duplex full

Thanks,
Sekhar
