From: David Brownell <david-b@pacbell.net>
Subject: Re: [Question] Always got STALL in MUSB Host driver
Date: Thu, 15 Nov 2007 10:43:45 -0800
Message-ID: <200711151043.46220.david-b@pacbell.net>
References: <1195123737.3698.24.camel@roc-desktop>
	<20071115180134.GB20686@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071115180134.GB20686@atomide.com>
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
> Hmm, I never got double buffering to reliably work on tusb as far as I
> remember. I guess Dave got it working on DaVinci, so maybe he has some
> pointers.

It's been some time since I tried that.  What I vaguely recall
is that it worked on the peripheral side, but on the host side
there was a issue if for example both sides (tx, rx) of a given
FIFO tried to do things at the same time.

The driver code has improved a lot since I saw those failures,
so I wouldn't trust those memories to indicate anything specific
about current behavior.

- Dave
