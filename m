From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated
Date: Tue, 8 May 2007 10:58:57 -0700
Message-ID: <20070508175857.GE32547@atomide.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429F12539@dlee13.ent.ti.com>
	<9C23CDD79DA20A479D4615857B2E2C47DCC783@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47DCC783@dlee13.ent.ti.com>
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

* Syed Mohammed, Khasim <x0khasim@ti.com> [070508 10:52]:
> Yeah, I was also getting an error for the "if(i2c_del_driver" in twl4030 driver. The i2c_del_driver is a void function and we were testing the return condition.
> 
> static void __exit twl4030_exit(void)
> {
>         if (i2c_del_driver(&twl4030_driver))
>                 printk(KERN_ERR
>                         "TWL4030: Driver remove failed, module not removed\n");
> 
> Temporarily I disabled MMC and corrected io.c and T2. 2430 SDP hangs while booting, I think this is what Tony was debugging yesterday.

Yeah, I thought Trilok's patch fixed this, but it seems it not the
case, 24xx still does not boot.

Tony
