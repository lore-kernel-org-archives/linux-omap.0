From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c-omap.c modified for 2430 I2C controller
Date: Mon, 11 Dec 2006 13:45:24 -0800
Message-ID: <20061211214523.GI6693@atomide.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE13@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE13@DLEE09.ent.ti.com>
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

* Syed Mohammed, Khasim <x0khasim@ti.com> [061203 12:34]:
> Hi,
> 
>  
> 
> In OMAP 2430 the DATA register is only 8 bits. In existing bus driver
> (i2c-omap.c) we were writing 16 bits (if len>1). 
> 
>  
> 
> In order to do a multi byte read / write we need to update the I2C FIFO
> threshold values and do a continuous write/read from DATA register. I
> will take up this task later some time along with I2C HS. For now, the
> attached patch makes I2C functional for 2430.

Pushing today.

Tony
