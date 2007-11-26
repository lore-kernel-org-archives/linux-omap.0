From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 3/4] ARM: OMAP: Remove MPU-timer based sched_clock()
Date: Mon, 26 Nov 2007 07:59:24 -0800
Message-ID: <1196092764.8693.10.camel@vence.hilman.org>
References: <20071112232401.723638265@mvista.com>
	<20071112232414.658134414@mvista.com>
	<20071123191815.GA559@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071123191815.GA559@atomide.com>
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


On Fri, 2007-11-23 at 11:18 -0800, Tony Lindgren wrote:
> * Kevin Hilman <khilman@mvista.com> [071112 15:25]:
> > Remove MPU-timer based sched_clock() in favor of the common one based
> > on 32k sync timer which works across all OMAP1/2/3 platforms.
> > 
> > Using 32k based one also gives a valid sched_clock() very early in the
> > boot process.
> 
> AFAIK there is no 32k sync timer for 15xx, or have I missed something?
> 

No there isn't.

But all this means is that 15xx has no higher resolution sched_clock().
The ARM default jiffies-based one will be used.

Kevin
