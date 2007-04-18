From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH / RFC] Basic OMAP2430 High speed I2C & Speed handling
	(final)
Date: Wed, 18 Apr 2007 00:52:59 +0000
Message-ID: <20070418005258.GL26287@atomide.com>
References: <20070417231212.GK26287@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C47B66F12@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47B66F12@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070417 23:20]:
> >Well you could keep it only for omap1 in device.c.
> 
> OK, I will do the following, please correct me if I am wrong.
> 
> - I will keep the I2C data structure in plat-omap/device.c under a OMAP1 macro.
> 
> - Will remove I2C platform_data structure from mach-omap2/device.c
> 
> - Add a platform_data structure and i2c_set_clock() function (similar to n800-usb.c) in 
> 	board-2430sdp.c
> 	board-h4.c
> 	board-n800.c
> 	board-apollon.c
> 
> - In I2C driver call the set_clock function to set the clock and speed.

If it's only an issue with 2430, you could still do the I2C init in
devices.c for 2420.

Tony
