From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition
 table
Date: Fri, 6 Jan 2017 18:39:44 +0100
Message-ID: <20170106173944.t3jq7amga3j5ahe6@lenoch>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
 <1483627851-17996-2-git-send-email-t.remmet@phytec.de>
 <20170105153637.GA4310@atomide.com>
 <20170105171845.GK4310@atomide.com>
 <20170105175619.GA56877@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170105175619.GA56877-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 05, 2017 at 09:56:20AM -0800, Brian Norris wrote:
[snip]
> The best solution would be to try to migrate away from static device
> tree representations of partition info entirely. UBI volumes are best
> where possible. If not, then some other kind of on-flash data structures
> (along the lines of a GPT) with a corresponding MTD partition parser is
> an OK alternative. Unfortunately, there isn't any good standard format
> for this on MTD, so it's typically all custom -- and so people use the
> easiest approach: device tree. And it's even more difficult with NAND,
> which has reliability problems, especially with static data (e.g., read
> disturb).

Just as a side note, there is some work in this area:
https://www.mail-archive.com/u-boot-0aAXYlwwYIKGBzrmiIFOJg@public.gmane.org/msg232759.html

> Anyway, the parser solution is helpful only if one can properly fix the
> "flag day" first. And it requires a little bit more work to be generally
> useful; I posted some work for this over a year ago, but bikeshedding
> brought it down.

Best regards,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
