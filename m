From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 10/26] mtd: nand: omap: Update DT binding documentation
Date: Mon, 7 Mar 2016 10:58:05 -0800
Message-ID: <20160307185805.GV55664@google.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
 <1455916548-3441-11-git-send-email-rogerq@ti.com>
 <20160305020430.GL55664@google.com>
 <56DD4DF0.4020500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56DD4DF0.4020500-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 07, 2016 at 11:46:24AM +0200, Roger Quadros wrote:
> On 05/03/16 04:04, Brian Norris wrote:
> > Is it normal to mix types of addressing in a single 'reg' property? Is
> > your code working for anything besides CS==0?
> 
> Yes we're using non zero CS on different omap platforms.
> I haven't changed the behaviour of the reg property in this series. Just updated the documentation.
> 
> I didn't understand what you meant by mixing type of addressing.
> 
> This usage is exactly as mentioned here
> http://devicetree.org/Device_Tree_Usage#Ranges_.28Address_Translation.29

I think I was just misunderstanding the use of the reg, *-cells, and
ranges properties here. Thanks for the pointer.

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
