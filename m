From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: OMAP: Remove MPU-timer based sched_clock()
Date: Fri, 23 Nov 2007 11:18:16 -0800
Message-ID: <20071123191815.GA559@atomide.com>
References: <20071112232401.723638265@mvista.com>
	<20071112232414.658134414@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071112232414.658134414@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [071112 15:25]:
> Remove MPU-timer based sched_clock() in favor of the common one based
> on 32k sync timer which works across all OMAP1/2/3 platforms.
> 
> Using 32k based one also gives a valid sched_clock() very early in the
> boot process.

AFAIK there is no 32k sync timer for 15xx, or have I missed something?

Tony
