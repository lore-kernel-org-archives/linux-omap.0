From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 19:39:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005171932540.27473@utopia.booyaka.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org> <201005152152.15996.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005152152.15996.rjw@sisk.pl>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Hello Rafael,

On Sat, 15 May 2010, Rafael J. Wysocki wrote:

> And really, the only semi-technical argument against the opportunistic suspend
> feature I've seen so far in this thread is that it _may_ _be_ possible to
> achieve the same goal in a different way.  If I don't see anything more serious
> than that, I will take the patchset and push it to Linus (patches [1-6/8] from
> version 7 to be precise, as soon as the changelogs are improved as
> requested).

The Android opportunistic suspend series still has problems, even if 
opportunistic suspend mode is not enabled.  These problems can be fixed, 
but it's too late to fix them for this merge window.  There shouldn't be a 
rush to merge these patches, given the current amount of discussion.

Details:

A. The series still has problems, even if the opportunistic suspend
   mode is not enabled:

   1. Many suspend_block() calls will need to be added throughout the
      kernel and drivers[1], beyond just those in the current patch 
      series.  Android systems will not work without  these calls.  
      The primary stated goal of adding suspend-block calls is not to
      add a new feature, but to restore an approximation of the
      original, expected behavior of the kernel timer and scheduler
      subsystems: to keep running as long as there is work to be done.
      This approach -- requiring patching of the kernel to restore
      expected behavior -- is inferior to an approach that preserves
      the timer and scheduler subsystems' behavior and only patches
      areas where the kernel doesn't have enough information to make
      the right decision[2].

   2. suspend_block() calls will be difficult for driver and subsystem
      maintainers to test.  This is because the calls contain hidden
      dependencies to specific Android userspace setups and unrelated
      kernel code[3].

B. These problems can be fixed:

   1. Patch 1's opportunistic suspend governor can be converted into
      an "opportunistic system low power governor."  In other words,
      when the governor decides to put the system into a low-power
      state, the way to do it should be up to the architecture, system
      integrator, or user -- not only "queue_work(pm_wq,
      &suspend_work);"
   
   2. The opportunistic system low power governor can then be extended
      to handle multiple system low-power states ("S-states" in ACPI
      terms)[4], rather than just one low-power state; similar to the
      way that CPUIdle selects C-states.
   
   3. The system low power governor can then be entered before the
      last active CPU in the system enters WFI/HLT (i.e., immediately
      before CPUIdle calls state->enter() [5]).  At this point, the
      governor would respect timers and the scheduler, and most
      suspend-block calls can be removed from the kernel.

   4. The process-freezing behavior of the opportunistic suspend
      patches can be implemented by improving the Linux timer and
      scheduler subsystems.  If freezer cgroups won't do, then based
      on a quick glance last week, here might be some reasonable
      approaches for emulating the Android behavior:

      A. To prevent untrusted process timers from waking the system,
         the processes can be run in a cgroup that calls
         del_timer_sync() on all process timers upon receipt of some
         trigger.  When the system returns from the system low-power
         state and some trigger event happens, add_timer() can be
         called to add all the cgroup's timers back.

      B. To prevent untrusted processes from hogging CPUs, the
         processes can be run in a cgroup that puts all threads in
         TASK_RUNNING processes into TASK_INTERRUPTIBLE state and
         calls schedule() [6], upon receipt of some trigger.  This
         should allow processes to be awakened by an external system
         event, e.g., network packet received.  When the system
         returns from the system low-power state and some trigger
         event happens, those process threads can be placed back into
         TASK_RUNNING state and rescheduled.

      The trigger events could be as simple as writing '1' or '0' into
      some cgroup or sysfs control file.

   5. At this point there would likely be a few remaining
      suspend-block users that use suspend_block() as an ersatz PM
      constraint API.  These should be replaced by a declarative PM
      constraint API a la [7] or [8].  Architectures and system
      integrators must be allowed to control how these PM constraints
      are implemented, because different chipsets, boards, and
      use-cases may have different power management feature
      implementations.

   Fixing the above issues should remove any need to add a
   suspend-block API.  It should handle the process-freezing use case.
   Android can still enter full system suspend in their system idle
   governor, but it should no longer need to.  Since this approach
   will honor "trusted" timers and processes, it won't break code that
   relies on longstanding kernel scheduling assumptions.

C. There shouldn't be a rush to merge the existing Android series:

   1. The lack of suspend-block support should not prevent existing
      drivers from being upstreamed without suspend-block calls.
      Non-Android users will be using the drivers without
      suspend-blocks, so the drivers will need to work without
      suspend-blocks anyway.  Until a fixed version of the series is
      submitted, Android can just carry the suspend-block patches in
      their own tree: the suspend-block patch rebase load from one
      Linux kernel release to the next should be light.  Many of the
      code sites where suspend-block calls are currently present in
      Android's MSM kernel[9] are unlikely to change, so git should be
      able to merge those automatically.

   2. Once these patches are merged, it will be difficult to remove
      the suspend-block approach from the kernel[10].  It touches a lot of
      kernel code.  And the power management constraint that it
      specifies is so general ("block system suspend"), that, for the
      subset of suspend_block() use-cases that actually implement a
      driver PM constraint, it will be difficult to figure out what
      these constraints were originally intended to be.

   3. There is no imminent danger if these patches are not merged.
      These are not security patches, or patches that fix some
      existing code that could damage hardware.  There is no liability
      motivation to fast-track these patches, particularly given the
      current high level of discussion.

Some of the features that these opportunistic suspend patches implement 
are desirable, such as process freezing and a system low power governor 
independent from CPUIdle.  However, there are significant problems with 
the way that these opportunistic suspend patches are designed, since they 
break existing kernel semantics and then touch lots of other code to work 
around the breakage.

The right approach should be to implement these features in a way that 
does not require patching all over the kernel, does not break existing 
timer and scheduler behavior, and will not impact bottom-up power 
management approaches.


regards,

- Paul
     

1. Paul Walmsley E-mail to the linux-pm mailing list, dated Fri, 14
   May 2010 00:27:56 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18658

2. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/include/plat/omap-pm.h;h=3ee41d7114929d771cadbb9f02191fd16c5b5abe;hb=ba2e1c5f25a99dec3873745031ad23ce3fd79bff

3. Paul Walmsley E-mail to the linux-pm mailing list, dated Fri, 14
   May 2010 00:27:56 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18658

4. Paul Walmsley E-mail to the linux-pm mailing list, dated Thu, 13
   May 2010 13:01:33 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18592

5. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/cpuidle/cpuidle.c;h=12fdd3987a36c2b09ab65b9d598f276e51fbf5b7;hb=ba2e1c5f25a99dec3873745031ad23ce3fd79bff#l88

6. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=kernel/signal.c;h=dbd7fe073c558dbc57080e7d0d9344b2cf47b2dd;hb=ba2e1c5f25a99dec3873745031ad23ce3fd79bff#l2696

7. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/include/plat/omap-pm.h;h=3ee41d7114929d771cadbb9f02191fd16c5b5abe;hb=ba2e1c5f25a99dec3873745031ad23ce3fd79bff

8. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=kernel/pm_qos_params.c;h=3db49b9ca374ded32bf224f266e904a8006e61a8;hb=ba2e1c5f25a99dec3873745031ad23ce3fd79bff

9. Paul Walmsley E-mail to the linux-pm mailing list, dated Fri, 14
   May 2010 00:13:50 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18657

10. Paul Walmsley E-mail to the linux-pm mailing list, dated Wed, 12
    May 2010 21:35:30 -0600: http://lkml.org/lkml/2010/5/12/528
