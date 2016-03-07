From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 13/26] memory: omap-gpmc: Support general purpose
 input for WAITPINs
Date: Mon, 7 Mar 2016 11:31:00 +0100
Message-ID: <20160307113100.2fb12bf4@bbrezillon>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
	<1455916548-3441-14-git-send-email-rogerq@ti.com>
	<20160307103440.4b9d7a55@bbrezillon>
	<56DD519A.3070403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56DD519A.3070403-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Mar 2016 12:02:02 +0200
Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:

> Hi Boris,
> 
> On 07/03/16 11:34, Boris Brezillon wrote:
> > Hi Roger,
> > 
> > On Fri, 19 Feb 2016 23:15:35 +0200
> > Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> > 
> >> OMAPs can have 2 to 4 WAITPINs that can be used as general purpose
> >> input if not used for memory wait state insertion.
> >>
> >> The first user will be the OMAP NAND chip to get the NAND
> >> read/busy status using gpiolib.
> > 
> > Just a comment on this approach. Why do you need to exposed native R/B
> > pins as GPIOs? I mean, other NAND controllers are supporting R/B
> > detection using dedicated logic, and they do not exposed those pins a
> > plain GPIOs. Have you considered adding another property (rb-native ?)
> > to deal with this case instead of emulating a GPIO controller?
> > Side note: I added an rb-gpios property in my sunxi-nand DT binding
> > because in some cases, the board design forces us to use a plain GPIO.
> 
> OMAPs can have more than one WAITpins which can be used in multiple ways
> - wait state insertion
> - general purpose input
> - edge detect interrupt
> 
> It is not automatically tied to NAND read/busy# mechanism and needs software
> to get the read/busy# state.
> The register to get WAIT pin status is not situated in the NAND controller
> register space but in the parent GPMC controller space.
> 
> So we've modelled the WAIT pins as irqchip and gpiochip and users can
> use them as they want.

Okay. Thanks for the detailed explanation.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
