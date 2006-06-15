From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: RE: Power domain addition.
Date: Thu, 15 Jun 2006 12:12:41 +0300
Message-ID: <1150362761.14712.11.camel@localhost>
References: <EA12F909C0431D458B9D18A176BEE4A5062FD931@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5062FD931@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, 2006-06-14 at 14:52 -0500, ext Woodruff, Richard wrote:

> -- In the example code I use the full auto method, I don't see auto
> state settings being done here (CM_CLKSTCTRL_CORE for instance)...

Setting the AUTOSTAT_x bits in the CM_CLKSTCTRL_y registers to 1 is
_not_ setting it to full auto?

>From arch/arm/mach-omap2/pm-domain.c:

pmdomain_set_clock_autocontrol(AUTOSTAT_DSS | AUTOSTAT_L4 | AUTOSTAT_L3,
PM_CORE_OFFSET);

is supposed to to set it to full auto. If this is required to be 0
instead, then we have seriously misread that section of the TRM. :)

-- 
Amit Kucheria <amit.kucheria@nokia.com>
Nokia
