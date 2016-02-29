From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v7 0/9] ARM: dts: omap2+: GPMC NAND node fixes
Date: Mon, 29 Feb 2016 09:17:20 -0800
Message-ID: <20160229171719.GL13417@atomide.com>
References: <1456245445-31824-1-git-send-email-rogerq@ti.com>
 <20160226184431.GB13417@atomide.com>
 <56D46E3C.5000908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56D46E3C.5000908-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [160229 08:14]:
> On 26/02/16 20:44, Tony Lindgren wrote:
> > And please let me know what additional patches I may need to
> > apply into omap-for-v4.6/dt for new files that are not in
> > omap-for-v4.6/dt-gpmc.
> 
> We need to fix the following
> gpmc node in dm814x.dtsi + nand node in dra62x-j5eco-evm.dts + nand node in dm8148-evm.

OK can you send that separately and I'll apply it?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
