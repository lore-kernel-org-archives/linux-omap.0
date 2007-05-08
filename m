From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP: Select GENERIC_CLOCKEVENTS patch
Date: Tue, 8 May 2007 14:07:48 -0700
Message-ID: <20070508210748.GJ32547@atomide.com>
References: <5d5443650705080007v3bb5a154p6883082280e8de47@mail.gmail.com>
	<1178658088.18074.25.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1178658088.18074.25.camel@vence.hilman.org>
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

* Kevin Hilman <khilman@mvista.com> [070508 14:02]:
> On Tue, 2007-05-08 at 12:37 +0530, Trilok Soni wrote:
> 
> > "select GENERIC_CLOCKEVENTS" patch makes H4 build with default MPU
> > timer selected to fail because timer_tick() is only available if
> > CLOCKEVENTS is not defined.
> > 
> > Do we really need to select GENERIC_CLOCKEVENTS by default? Other
> > solution is then to add !GENERIC_CLOCKEVENT as dependency in MPU_TIMER
> > KConfig.
> 
> GENERIC_CLOCKEVENTS is not quite ready for OMAP2.  I will have it ready
> in a week or so.  In the mean time, this patch will only enable
> GENERIC_CLOCKEVENTS for OMAP1.

OK, thanks, will push today.

Tony
