From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/2 2.6.24-rc1-git] OMAP and gpiolib
Date: Thu, 15 Nov 2007 13:29:10 -0800
Message-ID: <200711151329.11262.david-b@pacbell.net>
References: <200710300854.58334.david-b@pacbell.net>
	<20071115203529.GC20686@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071115203529.GC20686@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thursday 15 November 2007, Tony Lindgren wrote:
> I guess we'll apply these once the raw_spinlock/performance issues
> with gpio_chip are solved. For anybody interested, see LKML. [1]

[1] http://lkml.org/lkml/2007/11/15/155

is the relevant fix, I think.

There may be some other updates, to support more dense
packing of GPIO numbers through a gpio_desc structure
that would be used much like an irq_desc.

- Dave
