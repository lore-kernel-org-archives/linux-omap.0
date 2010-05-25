From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 25 May 2010 09:51:37 -0700
Message-ID: <20100525165137.GB2730@core.coreip.homeip.net>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl>
	<87sk68r1zh.fsf@deeprootsystems.com>
	<s2qd6200be21005031709r28420f0ezf3cf286517ee9114@mail.gmail.com>
	<alpine.DEB.2.00.1005141422110.3348@utopia.booyaka.com>
	<AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?iso-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Andres
List-Id: linux-omap@vger.kernel.org

On Fri, May 14, 2010 at 03:18:13PM -0700, Arve Hj=F8nnev=E5g wrote:
> On Fri, May 14, 2010 at 1:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > Hello,
> >
> > On Mon, 3 May 2010, Arve Hj=F8nnev=E5g wrote:
> >
> >> No, suspend blockers are mostly used to ensure wakeup events are not
> >> ignored, and to ensure tasks triggered by these wakeup events
> >> complete.
> >
> > Standard Linux systems don't need these,
> =

> If you don't want to lose wakeup events they do. Standard Linux
> systems support suspend, but since they usually don't have a lot of
> wakeup events you don't run into a lot of problems.
> =


What I do not quite understand is how exactly suspend blocks save us
from missing wakeup events. Consider case when all events have been
processed and system starts entering the sleep: we are in a half-sleep,
half awake state, with some devices already put to sleep and some just
now being processed. If user presses a key while physical input device
is being suspended, what will happen? Do you expect interrupt routine
abort suspend process? Initiate resume if suspend of the device has
completed?

Also, let's say device is suspended and is configured as a wakeup source
while the rest of the system is still awake... If I press a key I do not
think that it will necessarily abort suspend process. Or will it?

BTW, If you are concerned about events that already "left" physical
device but has not reached userspace yet - maybe instead of suspend
blockers we should make sure that all drivers throughout the chain
implement suspend/resume and refuse suspending if their queues are not
empty.  In input land that would mean extending suspend routine in
input_dev and adding one to evdev.

Thanks.

-- =

Dmitry
