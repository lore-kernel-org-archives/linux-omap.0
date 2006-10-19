From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.18-omap] omap2/gpmc updates
Date: Thu, 19 Oct 2006 11:44:04 -0700
Message-ID: <200610191144.04642.david-b@pacbell.net>
References: <200610181342.14796.david-b@pacbell.net>
	<20061019071503.GA25971@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061019071503.GA25971@mail.solidboot.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Timo Teras <timo.teras@solidboot.com>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 19 October 2006 12:15 am, Timo Teras wrote:
> On Wed, Oct 18, 2006 at 01:42:14PM -0700, David Brownell wrote:
> > Note that this API is glitchy; likely the best fix would be to add
> > a member to "struct gpmc_timings" to hold GPMC_CONFIG1, since that
> > holds one key aspect of the GPMC timings (the gpmc_fclk divisor,
> > and sync vs. async == whether that divisor matters).
> 
> Something like that would be useful. 

More of a cleanup IMO.  But one of several that seems needed.  :)


> Also currently you can only calculate 
> the timings in nanosecond precision. This is not enough in some cases
> e.g. when calculating sync. timings and the tick length is not multiple of
> nanosecond. We need picosecond precision or the possiblity to configure
> ticks directly.

Right now I'm working with an H4 board where those timings come out
neatly ... multiples of 10 nsec.  Agreed that there are situations
where the numbers aren't so neat.  Of course there aren't _yet_ any
examples of code needing/using those GPMC calls in the tree ...

- Dave
