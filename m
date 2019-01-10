From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in v4.20 with net phy soft reset changes
Date: Thu, 10 Jan 2019 08:09:17 -0800
Message-ID: <20190110160917.GY5544@atomide.com>
References: <20190109190650.GT5544@atomide.com>
 <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
 <20190109213611.GU5544@atomide.com>
 <79c57d19-837e-4468-f6b4-b3bfa9dde82a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <79c57d19-837e-4468-f6b4-b3bfa9dde82a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chris Healy <cphealy@gmail.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Keerthy <j-keerthy@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Rex Chang <rchang@ti.com>, Tero Kristo <t-kristo@ti.com>, WingMan Kwok <w-kwok2@ti.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sekhar Nori <nsekhar@ti.com> [190110 11:52]:
> On 10/01/19 3:06 AM, Tony Lindgren wrote:
> > For TI hardware, Sekhar and TI network folks, can you guys
> > please check the various TI SoCs for multiple suspend resume
> > cycles with v5.0-rc1 and patch accordingly? See also below
> 
> Will do.

OK thanks!

> I don't see the link problem if I shift to 100Mps prior to the
> plug/unplug experiment using ethtool. So looks like the problem is
> restricted to Gigabit link only. Are you using Gigabit link too?

Yes this is a Gigabit link.

> I think we should patch drivers/net/phy/micrel.c to solve the
> regression. Not sure of the root cause though. In the errata pointed to
> by Heiner, there is "Module 6" which comes close to what we are seeing,
> except it talks of a scenario where auto-negotiation is turned off 100M
> link is used and we see the issue even with auto-neg on and in gigabit
> mode. "Module 5" is also related to link failure, but is already worked
> around in kernel with ksz9031_center_flp_timing().
>
> >>> Keerthy noticed this may not happen on the first resume, but usually
> >>> happens after few suspend resume cycles. The most working suspend resume
> >>> cycles I've seen with the commit above is three.
> > ...
> >>> Note that unrelated to the commit above, there may be other issues too
> >>> as the cpsw phy LED seems to come on only after about five seconds with
> >>> about total of 10 seconds before the Ethernet is up again.
> 
> I don't quite see this problem on the AM437x GP EVM. I have seen gigabit
> link takes quite some time (sometimes more than 10 seconds) on x15 EVM.
> Not sure if the problem you are facing is related to gigabit too. If you
> are using gigabit link, can you downgrade to 100MBps to check? Either
> using a 100M only switch or by using ethtool on the EVM.
> 
> $ ethtool -s eth0 speed 100 duplex full

Yes this makes the 10 second resume latency go away on am437x-sk-evm
here.

Regards,

Tony
