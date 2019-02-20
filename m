From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel
 driver
Date: Wed, 20 Feb 2019 12:41:55 -0800 (PST)
Message-ID: <20190220.124155.2226787912266109280.davem@davemloft.net>
References: <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
        <20190220.112244.1206973642383679896.davem@davemloft.net>
        <20190220203326.GT15711@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220203326.GT15711@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: grygorii.strashko@ti.com, kishon@ti.com, robh+dt@kernel.org, netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 20 Feb 2019 12:33:26 -0800

> * David Miller <davem@davemloft.net> [190220 19:23]:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>> Date: Wed, 20 Feb 2019 17:25:19 +0200
>> 
>> > Deprecate cpsw-phy-sel driver as it's been replaced with new
>> > TI phy-gmii-sel PHY driver.
>> > 
>> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> 
>> Acked-by: David S. Miller <davem@davemloft.net>
> 
> Thanks for the ack, but actually I'd prefer you to pick
> this patch at some future date. I suggest Grygorii just
> repost this one after v5.1-rc1.

It's so much easier if you group this with those DT changes, they
logically belong together as well and it helps someone reading
the changes in the tree also if they are side by side.

Why don't you want to integrate this with them?
