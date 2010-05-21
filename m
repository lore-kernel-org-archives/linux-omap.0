From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 21 May 2010 10:51:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005191320010.27473@utopia.booyaka.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org> <201005152152.15996.rjw@sisk.pl>
	<alpine.DEB.2.00.1005171932540.27473@utopia.booyaka.com>
	<20100518015519.GA6500@srcf.ucam.org>
	<alpine.DEB.2.00.1005191016110.27473@utopia.booyaka.com>
	<20100519162557.GA25719@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-548612109-1274460718=:19937"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100519162557.GA25719@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-548612109-1274460718=:19937
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Matthew,

On Wed, 19 May 2010, Matthew Garrett wrote:

> On Wed, May 19, 2010 at 10:17:01AM -0600, Paul Walmsley wrote:
>=20
> > Could you please elaborate, or provide a link to an E-mail in the archi=
ves=20
> > that would explain why?
>=20
> What would otherwise be a wakeup event may be delivered between you=20
> deciding to stop tasks and you actually stopping tasks. How do you know=
=20
> to restart tasks at that point?

The original message you sent[1] quoted this part[2] of the proposal:

----
       A. To prevent untrusted process timers from waking the system,
          the processes can be run in a cgroup that calls
          del_timer_sync() on all process timers upon receipt of some
          trigger.  When the system returns from the system low-power
          state and some trigger event happens, add_timer() can be
          called to add all the cgroup's timers back.
----

That isn't intended to address the task restarting problem.  The task=20
restarting problem is intended to be addressed by this part[3]:

----
      B. To prevent untrusted processes from hogging CPUs, the
         processes can be run in a cgroup that puts all threads in
         TASK_RUNNING processes into TASK_INTERRUPTIBLE state and
         calls schedule() [6], upon receipt of some trigger.  This
         should allow processes to be awakened by an external system
         event, e.g., network packet received.  When the system
         returns from the system low-power state and some trigger
         event happens, those process threads can be placed back into
         TASK_RUNNING state and rescheduled.
----

It sounds like Android doesn't even need to use full system suspend if=20
some proposal like (A) and (B) are implemented[4].  In that case, all the=
=20
code that deals with races in full system suspend (like suspend blockers)=
=20
can be dropped.


- Paul

1. Matthew Garrett E-mail to the linux-pm mailing list, dated Tue May 18
   02:55:19 +0100
   https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025664.ht=
ml

2. Paragraph B4A of Paul Walmsley E-mail to the linux-pm mailing list,=20
   dated Mon May 17 19:39:44 CDT 2010:
   https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025663.ht=
ml

3. Paragraph B4B of Paul Walmsley E-mail to the linux-pm mailing list,=20
   dated Mon May 17 19:39:44 CDT 2010:
   https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025663.ht=
ml

4. Arve Hj=F8nnev=E5g E-mail to the linux-pm mailing list, dated Mon, May 1=
7=20
   20:06:33 PDT 2010:
   https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025668.ht=
ml
--155748971-548612109-1274460718=:19937
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-548612109-1274460718=:19937--
