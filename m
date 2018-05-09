From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 next-next] drivers: net: davinci_mdio: prevent spurious
 timeout
Date: Wed, 9 May 2018 15:36:48 -0500
Message-ID: <2ca3a71d-7363-db6f-8887-889836accbe0@ti.com>
References: <20180509154515.5968-1-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180509154515.5968-1-nsekhar@ti.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, "David S . Miller" <davem@davemloft.net>
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-omap@vger.kernel.org



On 05/09/2018 10:45 AM, Sekhar Nori wrote:
> A well timed kernel preemption in the time_after() loop
> in wait_for_idle() can result in a spurious timeout
> error to be returned.
> 
> Fix it by using readl_poll_timeout() which takes care of
> this issue.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> v3: simplify return path based on comment from Andrew
> 
> The issue has not been personally observed by me, but has
> been reported by users. Sending for next-next given the
> non-critical nature. There is seems to be no easy way to
> reproduce this.
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>



-- 
regards,
-grygorii
