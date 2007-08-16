From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 5/5] MMC/SD Controller driver for OMAP2430
Date: Wed, 15 Aug 2007 19:24:28 -0700
Message-ID: <200708151924.28442.david-b@pacbell.net>
References: <9C23CDD79DA20A479D4615857B2E2C47016A3485@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47016A3485@dlee13.ent.ti.com>
Content-Disposition: inline
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

On Wednesday 25 July 2007, Syed Mohammed, Khasim wrote:
> +void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)

This should already have been merged into the tree, right?

The N800 board support needs it.  And it's impossible to
configure e.g. an H4/2420 with complete MMC support without
extensions like those in "struct omap_mmc_platform_data" ...
although even then, that struct doesn't seem to directly
accomodate things like card detect IRQs through menelaus.

- Dave
