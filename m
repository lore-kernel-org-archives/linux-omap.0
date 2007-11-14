From: Tony Lindgren <tony@atomide.com>
Subject: Re: Obsolete omap watchdog files
Date: Tue, 13 Nov 2007 17:42:43 -0800
Message-ID: <20071114014242.GD23830@atomide.com>
References: <5D8B5EC1EB6ED845B1EB216F00C71B65022ACD0B@dlee12.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5D8B5EC1EB6ED845B1EB216F00C71B65022ACD0B@dlee12.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Iqbal <iqbal@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Iqbal <iqbal@ti.com> [071112 01:17]:
> 
> Tony,
> 
> I still see the omap_wdt.c,omap_wdt.h under the obsolete drivers/char/watchdog dir.
> I hope you have this cleanup task part of your list of todo's.

Thanks for noticing it, will remove it.

> I think otherwise it will get fixed itself from the next mainline pull. 

I think it would have stayed after a pull as I had to manually merge it
after last pull.

Tony
