From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] TWLGPIO driver after review comments - corrected
	trailing spaces
Date: Tue, 8 May 2007 16:35:56 -0700
Message-ID: <20070508233556.GU32547@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47DCCA48@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47DCCA48@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070508 15:50]:
> 
> Sorry, Corrected few trailing spaces - Retrying.

Thanks.

> This adds TWL4030 GPIO driver support. Required for TWL4030 Keypad and other
> TWL4030 GPIO dependent modules.
> @@ -891,9 +891,7 @@ static int __init twl4030_init(void)
>  
>  static void __exit twl4030_exit(void)
>  {
> -	if (i2c_del_driver(&twl4030_driver))
> -		printk(KERN_ERR
> -			"TWL4030: Driver remove failed, module not removed\n");
> +	i2c_del_driver(&twl4030_driver);
>  	twl_irq_used = FREE;
>  }
>  

Pushing today & leaving out this hunk as it's been already fixed in
the tree.

Tony
