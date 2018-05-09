From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH net-next] drivers: net: davinci_mdio: prevent sprious
 timeout
Date: Wed, 9 May 2018 16:14:42 +0530
Message-ID: <a0ede4ae-a489-4eb6-83d3-0e22541de2b3@ti.com>
References: <20180508082638.5707-1-nsekhar@ti.com>
 <20180508124856.GA2888@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180508124856.GA2888@lunn.ch>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 08 May 2018 06:18 PM, Andrew Lunn wrote:
> On Tue, May 08, 2018 at 01:56:38PM +0530, Sekhar Nori wrote:
>> A well timed kernel preemption in the time_after() loop
>> in wait_for_idle() can result in a spurious timeout
>> error to be returned.
>>
>> Fix it by checking for status of hardware before returning
>> timeout error.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> I've seen this with other drivers as well.
> 
> I suggest you make use of readx_poll_timeout(), or one of its
> cousins. They get this right.

Thanks for pointing me to these. I somehow thought these helpers are
only available with regmap.

Sending a version using readl_poll_timeout(). I know __raw_readl() is
used elsewhere in the driver, but I think that should be cleaned up
sometime to use readl_relaxed() at least. So not sure if there is
benefit in persisting with existing accessor.

Thanks,
Sekhar
