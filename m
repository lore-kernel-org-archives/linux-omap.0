From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] CPUidle: always return with interrupts
	enabled
Date: Tue, 6 Oct 2009 13:34:56 -0700
Message-ID: <20091006133456.5177a32a.akpm@linux-foundation.org>
References: <1254332153-23493-1-git-send-email-khilman@deeprootsystems.com>
	<200909302321.33088.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909302321.33088.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 30 Sep 2009 23:21:33 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Wednesday 30 September 2009, Kevin Hilman wrote:
> > In the case where cpuidle_idle_call() returns before changing state
> > due to a need_resched(), it was returning with IRQs disabled.
> > 
> > This patch ensures IRQs are (re)enabled before returning.
> 
> Venki, any comments on this?

Rigor mortis is setting in on this one.

Venki's most recent linux-acpi email was on July 31.

> > Reported-by: Hemanth V <hemanthv@ti.com>
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> >  drivers/cpuidle/cpuidle.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index ad41f19..12fdd39 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -76,8 +76,11 @@ static void cpuidle_idle_call(void)
> >  #endif
> >  	/* ask the governor for the next state */
> >  	next_state = cpuidle_curr_governor->select(dev);
> > -	if (need_resched())
> > +	if (need_resched()) {
> > +		local_irq_enable();
> >  		return;
> > +	}
> > +
> >  	target_state = &dev->states[next_state];
> >  
> >  	/* enter the state and update stats */

The patch seems correct to me.  The code is hopelessly poorly
documented as per usual, but other paths in that function, including
the call to target_state->enter() (which devolves to default_idle) also
enable interrupts.

Kevin, the changelog is not good.  It tells us what was wrong with the
code but does not describe the user-visible effects of the bug.

I'm unable to find any bug report from Hemanth so I'm all in the dark.

Your cc to linux-omap makes me suspect that <whatever the problem was>
was exhibited on a non-x86 platform, under some circumstances.  Perhaps
that explains (for unknown reasons) why <whatever the problem was> was
not observed on x86.  But I'm totally in the dark and grasping for
clues and have no way of determining (for example) whether we should
backport the fix to earlier kernels.


Please send along the additional information?
