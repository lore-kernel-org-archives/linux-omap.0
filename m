From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: TSC2101/2102
Date: Thu, 22 Mar 2007 08:48:30 +0200
Message-ID: <20070322084830.1a91c99c.jarkko.nikula@nokia.com>
References: <20070316074157.GA1133@bitbox.mine.nu>
	<20070316094926.GA4519@bitbox.mine.nu>
	<00f201c769ca$a8e022c0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070319093721.bd0df13e.jarkko.nikula@nokia.com>
	<010f01c769fd$4ab24d30$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070319103711.36ffe999.jarkko.nikula@nokia.com>
	<006e01c76a91$8ee234e0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070320132757.GB19913@atomide.com>
	<20070320155455.c1a3219b.jarkko.nikula@nokia.com>
	<20070320153812.GI19913@atomide.com>
	<a0580c510703211224y60c9283bv822276225c3e2c08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <a0580c510703211224y60c9283bv822276225c3e2c08@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Eduardo Valentin <edubezval@gmail.com>
Cc: Kyungmin Park <kmpark@infradead.org>, Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 21 Mar 2007 15:24:21 -0400
"ext Eduardo Valentin" <edubezval@gmail.com> wrote:

> This patch (patch-lcd-h2-spi-fix.diff) applies on top of Imre Deak's
> patch (spi-tsc2101-patch.diff).
> 
Hi, my two cents. It seems that almost everyone forgot to update/remove
path names in comment section when moving files to another directory :-)

spi-tsc2101-patch.diff:

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/drivers/spi/tsc2101.c	2007-03-21
15:12:49.000000000 -0400 @@ -0,0 +1,327 @@
+/*
+ * linux/drivers/ssi/omap-tsc2101.c
+ *

===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/include/linux/spi/tsc2101.h	2007-03-21
15:12:49.000000000 -0400 @@ -0,0 +1,43 @@
+/*
+ * linux/drivers/ssi/omap-tsc2101.h
+ *

-- 
Jarkko
