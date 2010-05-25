From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 25 May 2010 16:08:00 -0700
Message-ID: <AANLkTilj79bWWIxg-g6OmLtk37zaAdjntoJAfZPBivAV@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl> <87sk68r1zh.fsf@deeprootsystems.com>
	<s2qd6200be21005031709r28420f0ezf3cf286517ee9114@mail.gmail.com>
	<alpine.DEB.2.00.1005141422110.3348@utopia.booyaka.com>
	<AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>
	<alpine.DEB.2.00.1005172018380.27473@utopia.booyaka.com>
	<AANLkTinOFSVHnufbVKIei0KMbfkVvDgLVDRHkCldagfY@mail.gmail.com>
	<alpine.DEB.2.00.1005250050060.13376@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1005250050060.13376@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@goo>
List-Id: linux-omap@vger.kernel.org

On Tue, May 25, 2010 at 2:41 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Arve,
>
> I regret the delay in responding.
>
> On Mon, 17 May 2010, Arve Hj=F8nnev=E5g wrote:
>
>> On Mon, May 17, 2010 at 7:26 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> > On Fri, 14 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> On Fri, May 14, 2010 at 1:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> >> > On Mon, 3 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> >
>> >> >> No, suspend blockers are mostly used to ensure wakeup events are n=
ot
>> >> >> ignored, and to ensure tasks triggered by these wakeup events
>> >> >> complete.
>> >> >
>> >> > Standard Linux systems don't need these,
>> >>
>> >> If you don't want to lose wakeup events they do. =A0Standard Linux sy=
stems
>> >> support suspend, but since they usually don't have a lot of wakeup
>> >> events you don't run into a lot of problems.
>> >
>> > Sorry, I don't follow. =A0What causes wakeup events to be lost? =A0Is =
it the
>> > current opportunistic suspend governor? =A0On OMAP Linux systems, as f=
ar as
>> > I know, we don't lose any wakeup events.
>> >
>> Have you used suspend?
>
> I see. =A0You are referring to wakeup event loss/delay caused by the full
> system suspend process (e.g., kernel/power/suspend.c:enter_state()
> onwards[1]), correct? =A0This message addresses this at the end of the ma=
il.
>
>> >> > because the scheduler just keeps the system running as long as there
>> >> > is work to be done.
>> >>
>> >> That is only true if you never use suspend.
>> >
>> > If, instead of the current Android opportunistic suspend governor, the
>> > system entered suspend from pm_idle(), wouldn't that keep the system
>> > running as long as there is work to done?
>> >
>> How do you know if the work being done while suspending is work that
>> is needed to suspend or work that should abort suspend?
>
> Consider a suspending system in which all "untrusted" processes have been
> placed into TASK_INTERRUPTIBLE state and have had their timers
> disabled.[2] The only remaining work to do on the system is work that
> needs to be done as part of the suspend process, or work that is part of a
> "trusted" process or the kernel. =A0If the suspend needs to be aborted due
> to the arrival of an event, this can be handled as part of the standard
> suspend process (described below).
>

That means modifying all kernel code that would use suspend blockers
to abort suspend by returning an error from suspend instead. How is
this better than using suspend blockers?

>> When should the system wake up?
>
> I suspect that I am misunderstanding your question, but the system should
> wake up the same way it does now: when a wakeup interrupt arrives (either
> from the next scheduled timer expiration, or from some external device).
>

That is not how the system wakes up from suspend now. The monotonic
clock stops, and timers are ignored.

>> > As far as I can see, it's the current Android opportunistic suspend
>> > governor design in patch 1 that causes the system to enter suspend even
>> > when there is work to be done, since it will try to suspend even when =
the
>> > system is out of the idle loop.
>>
>> It does not matter how you enter suspend. Without opportunistic suspend,
>> once you tell the kernel that you want to suspend, you cannot abort.
>
> Any driver should be able to abort suspend by returning an error from its
> struct device_driver/struct dev_pm_ops suspend function. =A0Consider this

Yes a driver can abort, but the user space code that initiated suspend cann=
ot.

> partial callgraph for full system suspend, from [3], [4]:
>
> =A0 kernel/power/suspend.c: =A0 enter_state() ->
> =A0 kernel/power/suspend.c: =A0 =A0suspend_devices_and_enter() ->
> drivers/base/power/main.c: =A0 =A0 dpm_suspend_start() ->
> drivers/base/power/main.c: =A0 =A0 =A0dpm_suspend() ->
> drivers/base/power/main.c: =A0 =A0 =A0 device_suspend() ->
> drivers/base/power/main.c: =A0 =A0 =A0 =A0__device_suspend() ->
> drivers/base/power/main.c: =A0 =A0 =A0 =A0 pm_op() ->
> drivers/base/power/main.c: =A0 =A0 =A0 =A0 =A0ops->suspend()
>
> If ops->suspend() returns an error, it's ultimately passed back to
> suspend_devices_and_enter(), which aborts the suspend[5].
>
> In this context, the main change that should be necessary is for
> driver/subsystem suspend functions to return an error when there are
> events pending. =A0For example, as an alternative to the Android series'
> evdev.c patch[6], the evdev.c suspend function could return an error such
> as -EBUSY if events are currently queued (example below).
>
> Aborting suspend in the event of driver activity seems like the right
> thing to do in a system that attempts to enter full system suspend while
> idle. =A0But it is not the current expected Linux behavior, which also se=
ems
> useful. =A0Any abort-suspend-if-busy behavior should be configurable. =A0=
One
> way would be to add a sysfs file for each driver/subsystem: perhaps
> something like 'abort_suspend_if_busy'. =A0The default value would be zero
> to preserve the current behavior. =A0Systems that wish to use opportunist=
ic
> suspend could write a one to some or all of those files.
>
> An untested, purely illustrative example, based on evdev.c, is at the end
> of this message. =A0It's not meant to be functional; it's just meant to
> demonstrate the basic idea in code form.
>

Do you think this is simpler than using a suspend blocker?

> ...
>
> Like suspend-blockers, adding abort_suspend_if_busy support would require
> changes throughout many drivers and subsystems. =A0However, unlike
> suspend-blockers, the above abort_suspend_if_busy approach would not
> introduce any new APIs[7], nor would it change the default suspend
> behavior of the system.
>

Opportunistic suspend does not change the default behaviour either.
Your proposal requires that all the drivers that would block suspend
using a suspend blocker, now block suspend without the help of the
suspend blocker api.

> As an aside, it seems that Android shouldn't currently need this if it's
> possible to pause "untrusted" processes and timers[8], since current

Your proposal to "pause"processes by putting them in
TASK_INTERRUPTIBLE state and stop their timers does not work. It is
effectivly the same ase freezing them, since if you "paused" it while
it was busy, a wakeup event cannot unpause it.

> shipping Android hardware can enter the same system low power state both
> with and without full system suspend[9]. =A0But this could be useful for
> non-Android systems that still wish to use an idle-loop based,
> opportunistic full system suspend.
>
>
> regards,
>
> - Paul
>
>
> 1. http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;f=3Dkernel/power/suspend.c;h=3D56e7dbb8b996db295b4fc7cdf1b5f11a0409=
cb0c;hb=3D7e125f7b9cbfce4101191b8076d606c517a73066#l258
>
> 2. Section B4 of Paul Walmsley E-mail to the linux-pm mailing list,
> =A0 dated Mon May 17 19:39:44 CDT 2010:
> =A0 https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025663=
.html
>
> 3. http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;f=3Dkernel/power/suspend.c;h=3D56e7dbb8b996db295b4fc7cdf1b5f11a0409=
cb0c;hb=3D7e125f7b9cbfce4101191b8076d606c517a73066#l258
>
> 4. http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;f=3Ddrivers/base/power/main.c;h=3D941fcb87e52a12765df2aaa2e2ab21267=
693af9f;hb=3D7e125f7b9cbfce4101191b8076d606c517a73066#l1062
>
> 5. http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;f=3Dkernel/power/suspend.c;h=3D56e7dbb8b996db295b4fc7cdf1b5f11a0409=
cb0c;hb=3D7e125f7b9cbfce4101191b8076d606c517a73066#l207
>
> 6. Arve Hj=F8nnev=E5g E-mail to the linux-pm mailing list, dated Fri May =
21
> =A0 15:46:54 PDT 2010:
> =A0 https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025747=
.html
>
> 7. Paul Walmsley E-mail to the linux-pm mailing list, dated Thu May 13
> =A0 23:13:50 PDT 2010:
> =A0 https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025524=
.html
>
> 8. Paul Walmsley E-mail to the linux-pm mailing list, dated Mon May 17
> =A0 18:39:44 PDT 2010:
> =A0 https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025663=
.html
>
> 9. Arve Hj=F8nnev=E5g E-mail to the linux-pm mailing list, dated Mon, May=
 17
> =A0 20:06:33 PDT 2010:
> =A0 https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025668=
.html
>
>
>
> -------------------------------------------------------------------------=
-------------
>
> evdev.c abort_suspend_if_idle experiment:
>
> ---
> =A0drivers/input/evdev.c | =A0 64 +++++++++++++++++++++++++++++++++++++++=
+++++++++-
> =A01 files changed, 63 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 2ee6c7a..23eaad1 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -20,8 +20,16 @@
> =A0#include <linux/input.h>
> =A0#include <linux/major.h>
> =A0#include <linux/device.h>
> +#include <linux/pm.h>
> =A0#include "input-compat.h"
>
> +/*
> + * abort_suspend_if_busy: set to 1 to prevent suspend as long as there
> + * is an event in the queue; set to 0 to allow suspend at any time.
> + * XXX Intended to be read from sysfs or the input subsystem.
> + */
> +static int abort_suspend_if_busy;
> +
> =A0struct evdev {
> =A0 =A0 =A0 =A0int exist;
> =A0 =A0 =A0 =A0int open;
> @@ -118,6 +126,36 @@ static int evdev_flush(struct file *file, fl_owner_t=
 id)
> =A0 =A0 =A0 =A0return retval;
> =A0}
>
> +static int evdev_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct evdev *evdev =3D container_of(dev, struct evdev, dev=
);
> + =A0 =A0 =A0 struct evdev_client *client;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!abort_suspend_if_busy)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 rcu_read_lock();
> +
> + =A0 =A0 =A0 client =3D rcu_dereference(evdev->grab);
> + =A0 =A0 =A0 if (client) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (client->head !=3D client->tail)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry_rcu(client, &evdev->cli=
ent_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (client->head !=3D clien=
t->tail) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EB=
USY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rcu_read_unlock();
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +
> =A0static void evdev_free(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct evdev *evdev =3D container_of(dev, struct evdev, de=
v);
> @@ -787,6 +825,21 @@ static void evdev_cleanup(struct evdev *evdev)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static const struct dev_pm_ops evdev_pm_ops =3D {
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D &evdev_suspend,
> +};
> +
> +static char *evdev_devnode(struct device *dev, mode_t *mode)
> +{
> + =A0 =A0 =A0 return kasprintf(GFP_KERNEL, "input/%s", dev_name(dev));
> +}
> +
> +static struct class evdev_class =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "evdev",
> + =A0 =A0 =A0 .devnode =A0 =A0 =A0 =A0=3D evdev_devnode,
> + =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &evdev_pm_ops,
> +};
> +
> =A0/*
> =A0* Create new evdev device. Note that input core serializes calls
> =A0* to connect and disconnect so we don't need to lock evdev_table here.
> @@ -826,7 +879,7 @@ static int evdev_connect(struct input_handler *handle=
r, struct input_dev *dev,
> =A0 =A0 =A0 =A0evdev->handle.private =3D evdev;
>
> =A0 =A0 =A0 =A0evdev->dev.devt =3D MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + =
minor);
> - =A0 =A0 =A0 evdev->dev.class =3D &input_class;
> + =A0 =A0 =A0 evdev->dev.class =3D &evdev_class;
> =A0 =A0 =A0 =A0evdev->dev.parent =3D &dev->dev;
> =A0 =A0 =A0 =A0evdev->dev.release =3D evdev_free;
> =A0 =A0 =A0 =A0device_initialize(&evdev->dev);
> @@ -883,12 +936,21 @@ static struct input_handler evdev_handler =3D {
>
> =A0static int __init evdev_init(void)
> =A0{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 err =3D class_register(&input_class);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "evdev: unable to register =
evdev class\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return input_register_handler(&evdev_handler);
> =A0}
>
> =A0static void __exit evdev_exit(void)
> =A0{
> =A0 =A0 =A0 =A0input_unregister_handler(&evdev_handler);
> + =A0 =A0 =A0 class_unregister(&evdev_class);
> =A0}
>
> =A0module_init(evdev_init);
> --
> 1.7.1.GIT



-- =

Arve Hj=F8nnev=E5g
