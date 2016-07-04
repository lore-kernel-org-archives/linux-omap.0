From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: mtd: nand: omap2: check for elm_id removed
Date: Mon, 4 Jul 2016 15:01:59 +0200
Message-ID: <20160704150159.0af47ad5@bbrezillon>
References: <1467636717.4618.19.camel@lws-tremmet.phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467636717.4618.19.camel-wipSkzokR0f8DgGbXC/JcDlJRLeN4+xs@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 04 Jul 2016 14:51:57 +0200
Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org> wrote:

> Hello,
> 
> with commit c9711ec5250b22fd94e9b34c17c095e001a90e66
> ("mtd: nand: omap: Clean up device tree support")
> the old "elm_id" property check has been removed. So only "ti,elm-id" is
> valid now.
> I noticed that the old property is still used by 3 boards:
> 
> git grep elm_id arch/arm/boot/dts/*
> arch/arm/boot/dts/am335x-baltos.dtsi:           elm_id = <&elm>;
> arch/arm/boot/dts/am335x-igep0033.dtsi:         elm_id = <&elm>;
> arch/arm/boot/dts/am335x-phycore-som.dtsi:              elm_id = <&elm>;
> 
> I wonder if the right way would be to patch the device trees, or to add
> the check again and to keep backward compatibility?

We should probably do both, though backward compat is usually dependent
on the platform maintainer (some accept to break DT backward compat).

Anyway, all DTs should be patched to use the new binding, so you can at
least send a patch doing that.

> 
> I may provide a patch then.
> 
> Regards,
> Teresa
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
