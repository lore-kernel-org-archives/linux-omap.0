From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx
 packet size
Date: Wed, 28 Nov 2018 17:22:12 -0800 (PST)
Message-ID: <20181128.172212.1033397162837638079.davem@davemloft.net>
References: <20181128220211.GA5037@lunn.ch>
        <0b70091e-3747-ee8f-15d6-4532e210278e@ti.com>
        <20181129002835.GB5037@lunn.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129002835.GB5037@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: andrew@lunn.ch
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 29 Nov 2018 01:28:35 +0100

> On Wed, Nov 28, 2018 at 04:43:40PM -0600, Grygorii Strashko wrote:
>> Hi Andrew,
>> 
>> On 11/28/18 4:02 PM, Andrew Lunn wrote:
>> >> This is dynamic configuration related to ALE VLAN entries and
>> >> I do not see the way to support its auto-detection with current driver,
>> >> unfortunately.
>> > 
>> > I think you can subscribe to switchdev events which will tell you.
>> 
>> Thanks a lot for your review and comments.
>> 
>> Unfortunately, we still do not have switchdev in place, but i need to resolve
>> existing issue somehow. This patch is small, local to CPSW fix which can be
>> backported to stable. So, if possible, and no strong objection, could we proceed with it?
> 
> Hi Grygorii
> 
> David is the person who generally says no to kernel module
> parameters. You should ask him.

No module options.

You'll be stuck with it forever.

Sorry.
