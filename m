From: Timo Teras <timo.teras@solidboot.com>
Subject: Re: [patch 2.6.18-omap] omap2/gpmc updates
Date: Thu, 19 Oct 2006 10:15:03 +0300
Message-ID: <20061019071503.GA25971@mail.solidboot.com>
References: <200610181342.14796.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610181342.14796.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 18, 2006 at 01:42:14PM -0700, David Brownell wrote:
> Note that this API is glitchy; likely the best fix would be to add
> a member to "struct gpmc_timings" to hold GPMC_CONFIG1, since that
> holds one key aspect of the GPMC timings (the gpmc_fclk divisor,
> and sync vs. async == whether that divisor matters).

Something like that would be useful. Also currently you can only calculate
the timings in nanosecond precision. This is not enough in some cases
e.g. when calculating sync. timings and the tick length is not multiple of
nanosecond. We need picosecond precision or the possiblity to configure
ticks directly.

Cheers,
  Timo
