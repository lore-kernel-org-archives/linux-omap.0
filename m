From: Imre Deak <imre.deak@nokia.com>
Subject: Re: is dynamic tick working?
Date: Tue, 16 May 2006 16:32:43 +0300
Message-ID: <1147786363.27886.14.camel@mammoth.research.nokia.com>
References: <200605121905.13405.david-b@pacbell.net>
	<20060514104911.GB4715@atomide.com>
	<200605140919.09540.david-b@pacbell.net>
	<20060515092601.GE8368@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060515092601.GE8368@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, 2006-05-15 at 02:26 -0700, ext Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [060514 09:19]:
> > On Sunday 14 May 2006 3:49 am, Tony Lindgren wrote:
> > 
> > > In general dyntick should work, and you should see about 4-6HZ idle
> > > tick rate.
> > 
> > Depending on drivers, it seems ... ;)
> > 
> > I have a patch to get rid of the OHCI root hub polling, which will
> > get rid of one 4Hz timer.
> 
> Cool. Last time I played with sub 4Hz idle tick, some timers stopped
> working properly... Might be different now though as the timer system
> has seen some changes since last fall.

On N770 I've found that the omap_udc is pushing up the tick-rate as well
by HZ/3. It is a workaround to account for lost RX interrupts.

--Imre

> 
> Tony
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
