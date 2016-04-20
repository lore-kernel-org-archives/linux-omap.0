From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 00/17] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Wed, 20 Apr 2016 07:45:45 -0700
Message-ID: <20160420144545.GE5995@atomide.com>
References: <20160416105711.5310d2d0@bbrezillon>
 <5714D3A4.2050405@ti.com>
 <5714D8AA.9040304@ti.com>
 <20160418151305.17a42437@bbrezillon>
 <5714E5AA.5050200@ti.com>
 <20160418161001.2a1c0bed@bbrezillon>
 <5714F185.5080103@ti.com>
 <20160418165755.77d1d661@bbrezillon>
 <5716289B.4060302@ti.com>
 <20160419221129.59b559fb@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160419221129.59b559fb@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> [160419 13:13]:
> On Tue, 19 Apr 2016 15:46:19 +0300
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> 
> > 
> > After all the changes we discussed in [1] I was able to test nand/next-with-gpmc-rework
> > and it worked fine.
> > 
> > [1] - http://thread.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/22596/focus=22936
> > 
> > I'd be happy to test the branch again after you've incorporated all changes.
> 
> Just pushed what's supposed to be my new nand/next into
> nand/next-with-gpmc-rework, can you test it? I'll push it to nand/next
> once I have your confirmation that everything is good.

Looks good to me too, merges fine with my for-next and still
works for me.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
