From: Tony Lindgren <tony@atomide.com>
Subject: Re: TSC2101/2102
Date: Fri, 30 Mar 2007 14:49:34 -0400
Message-ID: <20070330184933.GB18375@atomide.com>
References: <00f201c769ca$a8e022c0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070319093721.bd0df13e.jarkko.nikula@nokia.com>
	<010f01c769fd$4ab24d30$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070319103711.36ffe999.jarkko.nikula@nokia.com>
	<006e01c76a91$8ee234e0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070320132757.GB19913@atomide.com>
	<20070320155455.c1a3219b.jarkko.nikula@nokia.com>
	<20070320153812.GI19913@atomide.com>
	<a0580c510703211224y60c9283bv822276225c3e2c08@mail.gmail.com>
	<20070322084830.1a91c99c.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070322084830.1a91c99c.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Kyungmin Park <kmpark@infradead.org>, Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [070322 02:50]:
> On Wed, 21 Mar 2007 15:24:21 -0400
> "ext Eduardo Valentin" <edubezval@gmail.com> wrote:
> 
> > This patch (patch-lcd-h2-spi-fix.diff) applies on top of Imre Deak's
> > patch (spi-tsc2101-patch.diff).
> > 
> Hi, my two cents. It seems that almost everyone forgot to update/remove
> path names in comment section when moving files to another directory :-)
> 
> spi-tsc2101-patch.diff:
> 
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-omap-2.6/drivers/spi/tsc2101.c	2007-03-21
> 15:12:49.000000000 -0400 @@ -0,0 +1,327 @@
> +/*
> + * linux/drivers/ssi/omap-tsc2101.c
> + *
> 
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-omap-2.6/include/linux/spi/tsc2101.h	2007-03-21
> 15:12:49.000000000 -0400 @@ -0,0 +1,43 @@
> +/*
> + * linux/drivers/ssi/omap-tsc2101.h
> + *
> 

Kyungmin, Eduardo & Jarkko, please sign your patches above so I can
apply them!

Tony
