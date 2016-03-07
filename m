From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 13/26] memory: omap-gpmc: Support general purpose
 input for WAITPINs
Date: Mon, 7 Mar 2016 10:38:55 +0100
Message-ID: <20160307103855.57720146@bbrezillon>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
	<1455916548-3441-14-git-send-email-rogerq@ti.com>
	<20160307103440.4b9d7a55@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160307103440.4b9d7a55@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Mar 2016 10:34:40 +0100
Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi Roger,
> 
> On Fri, 19 Feb 2016 23:15:35 +0200
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> 
> > OMAPs can have 2 to 4 WAITPINs that can be used as general purpose
> > input if not used for memory wait state insertion.
> > 
> > The first user will be the OMAP NAND chip to get the NAND
> > read/busy status using gpiolib.
> 
> Just a comment on this approach. Why do you need to exposed native R/B
> pins as GPIOs? I mean, other NAND controllers are supporting R/B
> detection using dedicated logic, and they do not exposed those pins a
> plain GPIOs. Have you considered adding another property (rb-native ?)

Just had a look at the sunxi-nand binding, and we chose "allwinner,rb"
for this native RB logic. So "ti,rb" would be the equivalent for the
gpmc driver.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
