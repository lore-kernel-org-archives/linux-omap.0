From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next] drivers: net: davinci_mdio: prevent sprious
 timeout
Date: Tue, 8 May 2018 14:48:56 +0200
Message-ID: <20180508124856.GA2888@lunn.ch>
References: <20180508082638.5707-1-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180508082638.5707-1-nsekhar@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 08, 2018 at 01:56:38PM +0530, Sekhar Nori wrote:
> A well timed kernel preemption in the time_after() loop
> in wait_for_idle() can result in a spurious timeout
> error to be returned.
> 
> Fix it by checking for status of hardware before returning
> timeout error.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

I've seen this with other drivers as well.

I suggest you make use of readx_poll_timeout(), or one of its
cousins. They get this right.

	 Andrew
