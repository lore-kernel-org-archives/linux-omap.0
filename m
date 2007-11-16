From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH] ARM: OMAP: implement CPUfreq frequency table based on
	PRCM table
Date: Fri, 16 Nov 2007 15:29:51 -0800
Message-ID: <1195255791.24857.13.camel@vence.hilman.org>
References: <20071115233817.668467680@mvista.com>
	<20071116195402.GD32675@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071116195402.GD32675@atomide.com>
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


On Fri, 2007-11-16 at 11:54 -0800, Tony Lindgren wrote:

> * Kevin Hilman <khilman@mvista.com> [071115 15:43]:
> > This patch adds a CPUfreq frequency-table implementation for OMAP2 by
> > walking the PRCM rate-table for available entries and adding them to a
> > CPUfreq table.
> 
> I updated the patch a bit to use the cpufreq table if initialized, and
> to allow omap1 and omap3 to implement it later on easily. Can you please
> check? 

I like it.  Thanks.

> I've only compile tested on osk, and on n800 noticed there are
> currently no frequencies for 19.2 source clock.

I tested cpufreq on 2430 and it looks good.

I'll be adding the 3430 support shortly as well, so your updates are
cleaner for that.  

Kevin
