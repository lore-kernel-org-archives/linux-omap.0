From: tony@atomide.com
Subject: Re: [PATCH 1/3] Add backlight support for Amstrad Delta
Date: Fri, 28 Apr 2006 03:26:38 -0700
Message-ID: <20060428102637.GH31797@atomide.com>
References: <20060402163614.GC26949@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060402163614.GC26949@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jonathan McDowell <noodles@earth.li> [060402 09:38]:
> This patch adds support for the Amstrad Delta LCD backlight. It's the
> first patch in a series of 3 enabling full LCD support for the Delta and
> is the least intrusive, allowing control of the backlight through the
> existing backlight class infrastructure.

Looks good. Can you please separate arch/arm/mach-omap1/board-ams-delta.c
changes and other core omap changes into separate patch in this series?

See new http://www.muru.com/linux/omap/README_OMAP_PATCHES

Thanks,

Tony
