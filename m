From: Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] Palm TE Touchscreen and fixes
Date: Sun, 15 Jan 2006 18:04:59 +0200
Message-ID: <1137341099.7384.16.camel@two.research.nokia.com>
References: <20060115091040.80061.qmail@web32906.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060115091040.80061.qmail@web32906.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sun, 2006-01-15 at 01:10 -0800, ext Komal Shah wrote:

> TSC2301 support is really good, there was no community known driver
> available yet. Even this chip has audio + 2 gpios + keyboard controller
> which you may want to experiment with now.

We have a TSC2301 driver that's in a pretty good shape now.  At the
moment keypad and touchscreen are supported.  The audio mixer driver is
work-in-progress.

We'll merge it whenever Dave's SPI stuff finds its way into linux-omap.

BTW, we also have a McSPI controller driver for OMAP2.  It uses PIO at
the moment, but DMA support is on its way.

Cheers,
Juha
