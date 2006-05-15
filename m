From: Tony Lindgren <tony@atomide.com>
Subject: Re: is dynamic tick working?
Date: Mon, 15 May 2006 02:26:01 -0700
Message-ID: <20060515092601.GE8368@atomide.com>
References: <200605121905.13405.david-b@pacbell.net>
	<20060514104911.GB4715@atomide.com>
	<200605140919.09540.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200605140919.09540.david-b@pacbell.net>
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

* David Brownell <david-b@pacbell.net> [060514 09:19]:
> On Sunday 14 May 2006 3:49 am, Tony Lindgren wrote:
> 
> > In general dyntick should work, and you should see about 4-6HZ idle
> > tick rate.
> 
> Depending on drivers, it seems ... ;)
> 
> I have a patch to get rid of the OHCI root hub polling, which will
> get rid of one 4Hz timer.

Cool. Last time I played with sub 4Hz idle tick, some timers stopped
working properly... Might be different now though as the timer system
has seen some changes since last fall.

Tony
