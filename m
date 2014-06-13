From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 18/36] ARM: OMAP2+: gpmc-onenand: Move Synchronous setting
 code to drivers/
Date: Fri, 13 Jun 2014 11:30:04 +0300
Message-ID: <539AB68C.5090001@ti.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com> <1402477001-31132-19-git-send-email-rogerq@ti.com> <20140613075527.GP17845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140613075527.GP17845-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pekon-l0cyMroinI0@public.gmane.org, ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/13/2014 10:55 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140611 01:59]:
>> Move the code that puts the onenand in synchronous mode
>> into the appropriate place i.e. drivers/mtd/onenand/omap2.c.
>>
>> Make use of omap_gpmc_get_clk_period() and omap_gpmc_retime()
>> to calculate the necessary timings and configure the GPMC
>> parent's timings.
> 
> Ideally we would just use the drivers/mtd/onenand/generic.c
> and get rid of drivers/mtd/onenand/omap2.c. We still need
> the bus glue, which should probably be in drivers/memory?
> 

But what about the runtime synchronous timing calculations onenand/omap2.c?
There is also OMAP2 and OMAP3 specific dma handling done there, which should probably be done generically using dmaengine.

cheers,
-roger


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
