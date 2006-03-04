From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] OMAP: MMC: Move set_power to platform data
Date: Sat, 4 Mar 2006 12:36:06 +0200
Message-ID: <20060304103606.GA16761@two.research.nokia.com>
References: <20060303132421.46104.qmail@web32909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060303132421.46104.qmail@web32909.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 03, 2006 at 05:24:21AM -0800, ext Komal Shah wrote:

>  #include "omap.h"
> @@ -102,6 +100,7 @@ struct mmc_omap_host {
>  	struct work_struct	switch_work;
>  	struct timer_list	switch_timer;
>  	int			switch_last_state;
> +	void (*set_power)(void __iomem *base, int on);
>  };

Note that just "on" is not enough; some power supplies have support for
setting the voltage to several different values.

> diff --git a/include/asm-arm/arch-omap/board.h b/include/asm-arm/arch-omap/board.h
> index 6d6240a..168662f 100644
> --- a/include/asm-arm/arch-omap/board.h
> +++ b/include/asm-arm/arch-omap/board.h
> @@ -46,6 +46,7 @@ struct omap_mmc_conf {
>  	s16 power_pin;
>  	s16 switch_pin;
>  	s16 wp_pin;
> +	void (*set_power)(void __iomem *base, int on);
>  };

You shouldn't use the struct in board.h for this.  It is meant for passing
data from the bootloader, and passing a kernel function pointer from the
bootloader is problematic, to say the least. =)

The proper way to solve this is to introde the concept of a voltage framework,
so that we can reference voltages by name instead of a function.

Cheers,
Juha
