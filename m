From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.21-rc4-omap1] restore CONFIG_GENERIC_TIME
Date: Thu, 29 Mar 2007 16:29:35 -0400
Message-ID: <20070329202933.GN3638@atomide.com>
References: <200703281321.20517.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200703281321.20517.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070328 17:20]:
> Somehow this got lost in a merge ...
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> --- osk2.orig/arch/arm/Kconfig	2007-03-17 21:00:14.000000000 -0700
> +++ osk2/arch/arm/Kconfig	2007-03-17 21:41:09.000000000 -0700
> @@ -363,6 +363,7 @@ config ARCH_LH7A40X
>  config ARCH_OMAP
>  	bool "TI OMAP"
>  	select GENERIC_GPIO
> +	select GENERIC_TIME
>  	help
>  	  Support for TI's OMAP platform (OMAP1 and OMAP2).

Pushing today.

Tony
