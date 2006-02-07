From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP: STI/XTI support.
Date: Tue, 7 Feb 2006 15:23:14 -0800
Message-ID: <20060207232314.GK27148@atomide.com>
References: <20060206194658.GA20394@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060206194658.GA20394@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Mundt <paul.mundt@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Mundt <paul.mundt@nokia.com> [060206 13:58]:
> This implements a simple subsystem for the OMAP serial tracing interface,
> as found in omap16xx and omap24xx.
> 
> There's a few things implemented in this patch:
> 
> 	- STI console support
> 	- STI netlink support
> 	- STI RX FIFO support
> 
> In addition to this, we also provide a general tracing framework that can
> be used by both the kernel and userspace (and imask control for allowing
> DSP-side STI manipulation).
> 
> Since the IRQ is multiplexed, drivers register for the bits they're
> interested in (the RX FIFO is an example of this).
> 
> The netlink interface exists for streaming data bi-directionally. This is
> currently done using NETLINK_USERSOCK, which ends up being somewhat
> limiting.
> 
> All of these things have been tested on both OMAP1 and OMAP2, and it
> takes in to account some of the protocol differences.

Thanks, pushing today.

Tony
