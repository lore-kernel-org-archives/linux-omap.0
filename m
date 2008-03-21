From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 12/14] ARM: OMAP1: Timer32K: Fix timer32K for clockevents
	and clean it up
Date: Fri, 21 Mar 2008 12:04:26 +0000
Message-ID: <20080321120425.GA3732@flint.arm.linux.org.uk>
References: <1205746958-11242-6-git-send-email-tony@atomide.com>
	<1205746958-11242-7-git-send-email-tony@atomide.com>
	<1205746958-11242-8-git-send-email-tony@atomide.com>
	<1205746958-11242-9-git-send-email-tony@atomide.com>
	<1205746958-11242-10-git-send-email-tony@atomide.com>
	<1205746958-11242-11-git-send-email-tony@atomide.com>
	<1205746958-11242-12-git-send-email-tony@atomide.com>
	<1205746958-11242-13-git-send-email-tony@atomide.com>
	<20080320165243.GD16166@flint.arm.linux.org.uk>
	<87y78dntfz.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <87y78dntfz.fsf@paris.hilman.org>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Kevin Hilman <khilman@mvista.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 20, 2008 at 11:25:52AM -0700, Kevin Hilman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Mon, Mar 17, 2008 at 11:42:36AM +0200, Tony Lindgren wrote:
> >> This patch fixes timer32k for clockevents and syncs it with
> >> linux-omap tree.
> >> 
> >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> ---
> >>  arch/arm/mach-omap1/timer32k.c |   20 ++++++++++++++------
> >>  1 files changed, 14 insertions(+), 6 deletions(-)
> >> 
> >>...
> >> @@ -126,9 +131,9 @@ static void omap_32k_timer_set_mode(enum clock_event_mode mode,
> >>  
> >>  	switch (mode) {
> >>  	case CLOCK_EVT_MODE_PERIODIC:
> >> +	case CLOCK_EVT_MODE_ONESHOT:
> >>  		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
> >>  		break;
> >> -	case CLOCK_EVT_MODE_ONESHOT:
> >
> > I didn't think an event was supposed to be programmed to fire when one
> > shot mode is selected - from the other implementations, it appears that
> > the timer should be disabled until set_next_event() has been called.
> 
> That is correct.  The 'start' should only be happening for the
> periodic mode.  This following change should be done.

Or just omit the bogus change from the original patch.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
