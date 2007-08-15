From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.23-rc2-omap1] menelaus minor cleanups
Date: Wed, 15 Aug 2007 03:56:17 -0700
Message-ID: <20070815105616.GL19754@atomide.com>
References: <200708132251.05709.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200708132251.05709.david-b@pacbell.net>
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

* David Brownell <david-b@pacbell.net> [070813 23:12]:
> Remove duplicate Menelaus Kconfig entry (omap tree only).
> 
> Fix Menelaus build error, and remove needless "#define DEBUG" (goes upstream).

Pushing today, left out the -#define DEBUG part below.

Tony

> --- h4.orig/drivers/i2c/chips/menelaus.c	2007-08-10 11:26:41.000000000 -0700
> +++ h4/drivers/i2c/chips/menelaus.c	2007-08-13 15:37:15.000000000 -0700
> @@ -1,4 +1,3 @@
> -#define DEBUG
>  /*
>   * Copyright (C) 2004 Texas Instruments, Inc.
>   *
