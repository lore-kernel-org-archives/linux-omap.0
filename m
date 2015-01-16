From: David Miller <davem@davemloft.net>
Subject: Re: [patch-net-next v2 3/3] net: ethernet: cpsw: don't requests
 IRQs we don't use
Date: Thu, 15 Jan 2015 23:36:42 -0500 (EST)
Message-ID: <20150115.233642.1752634915667200562.davem@davemloft.net>
References: <20150115152053.GA16409@saruman>
	<20150115.181615.498992970722065060.davem@davemloft.net>
	<20150116012852.GA3115@saruman>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20150116012852.GA3115@saruman>
Sender: netdev-owner@vger.kernel.org
To: balbi@ti.com
Cc: mugunthanvnm@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>
Date: Thu, 15 Jan 2015 19:28:52 -0600

> On Thu, Jan 15, 2015 at 06:16:15PM -0500, David Miller wrote:
>> Indeed, I agree that adding something as a placeholder that just gets
>> immediately removed should be avoided unless it is extremely difficult
>> to do so.
> 
> what does this mean ? you prefer both patches to be combined ?

Yes, something like that.
