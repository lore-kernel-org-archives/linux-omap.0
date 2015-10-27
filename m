From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 18/27] mtd: nand: omap2: Implement NAND ready using
 gpiolib
Date: Tue, 27 Oct 2015 10:43:40 +0200
Message-ID: <562F393C.1030701@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <1442588029-13769-19-git-send-email-rogerq@ti.com>
 <20151026204900.GI13239@google.com> <562F2FB6.7050806@ti.com>
 <20151027091235.03dba8c5@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151027091235.03dba8c5@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Smith <alex.smith-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Harvey Hunt <harvey.hunt-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Boris,

On 27/10/15 10:12, Boris Brezillon wrote:
> Hi Roger,
> 
> On Tue, 27 Oct 2015 10:03:02 +0200
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> 
>> On 26/10/15 22:49, Brian Norris wrote:
>>>
>>> Others have been looking at using GPIOs for the ready/busy pin too. At a
>>> minimum, we need an updated DT binding doc for this, since I see you're
>>> adding this via device tree in a later patch (I don't see any DT binding
>>> patch for this; but I could just be overlooking it). It'd also be great
>>> if this support was moved to nand_dt_init() so other platforms can
>>> benefit, but I won't require that.
>>>
>>> Also, previous [0] proposers had suggested 'rb-gpios', not 'ready-gpio'
>>> (the hardware docs typically call it 'rb' for ready/busy, FWIW). I don't
>>> really care, but the name should be going into a doc, so we can choose
>>> the same one everywhere.
>>>
>>> EDIT: looks like the discussion was partly here [1] and it seems we're
>>> landing on "rb-gpios" in the latest version [2]. Can we stick with that?
>>
>> Why should it be "rb-gpios" and not "rb-gpio"?
>> I don't think there are multiple gpios for r/b# function.
> 
> Because it's supposed to be a generic binding, and some NAND chips
> embed several dies, thus exposing several CS and RB pins, hence the
> rb-gpios name.
> Also, as described here [1], the convention is to name your property
> <name>-gpios even if you only need one gpio.

Makes sense now. Thanks for the explanation.
I'll update this patch to use rb-gpios and update the binding doc as well.

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
