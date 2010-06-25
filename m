From: Sebastien Jan <s-jan@ti.com>
Subject: Re: [PATCH] smsc95xx: Add module parameter to override MAC address
Date: Fri, 25 Jun 2010 16:20:36 +0200
Message-ID: <4C24BB34.3010601@ti.com>
References: <1277367254-9345-1-git-send-email-s-jan@ti.com> <20100625012520.GA12650@verge.net.au> <4C2452ED.8020307@ti.com>  <OF60E8D688.255F8F16-ON8025774D.002E17AA-8025774D.002FEC33@smsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <OF60E8D688.255F8F16-ON8025774D.002E17AA-8025774D.002FEC33@smsc.com>
Sender: netdev-owner@vger.kernel.org
To: "Steve.Glendinning@smsc.com" <Steve.Glendinning@smsc.com>
Cc: Simon Horman <horms@verge.net.au>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "Ian.Saturley@smsc.com" <Ian.Saturley@smsc.com>
List-Id: linux-omap@vger.kernel.org

Hi Steve,

Thanks for your answer.

On 06/25/2010 10:43 AM, Steve.Glendinning@smsc.com wrote:
[...]
> I can see you have a different use case, but I don't think this specific
> driver is the place for this logic.  I'd rather see it added to either
> the usbnet framework or (preferably) the netdev framework so *all*
> ethernet drivers can do this the same way.  otherwise we could end up
> with slight variations of this code in every single driver!

I perfectly understand your concerns. Unfortunately, I will probably not be
able to implement these changes into the netdev framework. However, I'd be 
happy to make some tests if someone proposes such changes.

