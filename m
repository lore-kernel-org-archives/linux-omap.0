From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.18-omap] /sys/kernel/debug/omap_gpio
Date: Wed, 18 Oct 2006 22:41:51 +0300
Message-ID: <20061018194149.GG4669@atomide.com>
References: <200610171410.16631.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610171410.16631.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061018 00:24]:
> Add some GPIO debug support:  /sys/kernel/debug/omap_gpio dumps the state
> of all GPIOs that have been claimed, including basic IRQ info if relevant.
> Tested on 24xx, 16xx.
> 
> Includes minor bugfixes:  recording IRQ trigger mode (this should probably
> be a genirq patch), adding missing space to non-wakeup warning

Cool, this is handy. Pushing today.

Tony
