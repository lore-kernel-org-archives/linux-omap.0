From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 25 May 2010 03:41:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005250050060.13376@utopia.booyaka.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl>
	<87sk68r1zh.fsf@deeprootsystems.com>
	<s2qd6200be21005031709r28420f0ezf3cf286517ee9114@mail.gmail.com>
	<alpine.DEB.2.00.1005141422110.3348@utopia.booyaka.com>
	<AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>
	<alpine.DEB.2.00.1005172018380.27473@utopia.booyaka.com>
	<AANLkTinOFSVHnufbVKIei0KMbfkVvDgLVDRHkCldagfY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-683627329-1274773748=:13376"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinOFSVHnufbVKIei0KMbfkVvDgLVDRHkCldagfY@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1005250149170.13376@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?ISO-8859-15?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@go>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-683627329-1274773748=:13376
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1005250149171.13376@utopia.booyaka.com>

Hello Arve,

I regret the delay in responding.

On Mon, 17 May 2010, Arve Hj=F8nnev=E5g wrote:

> On Mon, May 17, 2010 at 7:26 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Fri, 14 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> On Fri, May 14, 2010 at 1:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >> > On Mon, 3 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >
> >> >> No, suspend blockers are mostly used to ensure wakeup events are no=
t
> >> >> ignored, and to ensure tasks triggered by these wakeup events
> >> >> complete.
> >> >
> >> > Standard Linux systems don't need these,
> >>
> >> If you don't want to lose wakeup events they do. =A0Standard Linux sys=
tems
> >> support suspend, but since they usually don't have a lot of wakeup
> >> events you don't run into a lot of problems.
> >
> > Sorry, I don't follow. =A0What causes wakeup events to be lost? =A0Is i=
t the
> > current opportunistic suspend governor? =A0On OMAP Linux systems, as fa=
r as
> > I know, we don't lose any wakeup events.
> >
> Have you used suspend?

I see.  You are referring to wakeup event loss/delay caused by the full=20
system suspend process (e.g., kernel/power/suspend.c:enter_state()=20
onwards[1]), correct?  This message addresses this at the end of the mail.

> >> > because the scheduler just keeps the system running as long as there
> >> > is work to be done.
> >>
> >> That is only true if you never use suspend.
> >
> > If, instead of the current Android opportunistic suspend governor, the
> > system entered suspend from pm_idle(), wouldn't that keep the system
> > running as long as there is work to done?
> >
> How do you know if the work being done while suspending is work that
> is needed to suspend or work that should abort suspend?

Consider a suspending system in which all "untrusted" processes have been=
=20
placed into TASK_INTERRUPTIBLE state and have had their timers=20
disabled.[2] The only remaining work to do on the system is work that=20
needs to be done as part of the suspend process, or work that is part of a=
=20
"trusted" process or the kernel.  If the suspend needs to be aborted due=20
to the arrival of an event, this can be handled as part of the standard=20
suspend process (described below).

> When should the system wake up?

I suspect that I am misunderstanding your question, but the system should=
=20
wake up the same way it does now: when a wakeup interrupt arrives (either=
=20
from the next scheduled timer expiration, or from some external device).

> > As far as I can see, it's the current Android opportunistic suspend
> > governor design in patch 1 that causes the system to enter suspend even
> > when there is work to be done, since it will try to suspend even when t=
he
> > system is out of the idle loop.
>=20
> It does not matter how you enter suspend. Without opportunistic suspend,=
=20
> once you tell the kernel that you want to suspend, you cannot abort.

Any driver should be able to abort suspend by returning an error from its=
=20
struct device_driver/struct dev_pm_ops suspend function.  Consider this=20
partial callgraph for full system suspend, from [3], [4]:

   kernel/power/suspend.c:   enter_state() ->
   kernel/power/suspend.c:    suspend_devices_and_enter() ->
drivers/base/power/main.c:     dpm_suspend_start() ->
drivers/base/power/main.c:      dpm_suspend() ->
drivers/base/power/main.c:       device_suspend() ->
drivers/base/power/main.c:        __device_suspend() ->
drivers/base/power/main.c:         pm_op() ->
drivers/base/power/main.c:          ops->suspend()

If ops->suspend() returns an error, it's ultimately passed back to=20
suspend_devices_and_enter(), which aborts the suspend[5].

In this context, the main change that should be necessary is for=20
driver/subsystem suspend functions to return an error when there are=20
events pending.  For example, as an alternative to the Android series'=20
evdev.c patch[6], the evdev.c suspend function could return an error such=
=20
as -EBUSY if events are currently queued (example below).

Aborting suspend in the event of driver activity seems like the right=20
thing to do in a system that attempts to enter full system suspend while=20
idle.  But it is not the current expected Linux behavior, which also seems=
=20
useful.  Any abort-suspend-if-busy behavior should be configurable.  One=20
way would be to add a sysfs file for each driver/subsystem: perhaps=20
something like 'abort_suspend_if_busy'.  The default value would be zero=20
to preserve the current behavior.  Systems that wish to use opportunistic=
=20
suspend could write a one to some or all of those files.

An untested, purely illustrative example, based on evdev.c, is at the end=
=20
of this message.  It's not meant to be functional; it's just meant to=20
demonstrate the basic idea in code form.

=2E..

Like suspend-blockers, adding abort_suspend_if_busy support would require=
=20
changes throughout many drivers and subsystems.  However, unlike=20
suspend-blockers, the above abort_suspend_if_busy approach would not=20
introduce any new APIs[7], nor would it change the default suspend=20
behavior of the system.

As an aside, it seems that Android shouldn't currently need this if it's=20
possible to pause "untrusted" processes and timers[8], since current=20
shipping Android hardware can enter the same system low power state both=20
with and without full system suspend[9].  But this could be useful for=20
non-Android systems that still wish to use an idle-loop based,=20
opportunistic full system suspend.


regards,

- Paul


1. http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Db=
lob;f=3Dkernel/power/suspend.c;h=3D56e7dbb8b996db295b4fc7cdf1b5f11a0409cb0c=
;hb=3D7e125f7b9cbfce4101191b8076d606c517a73066#l258

2. Section B4 of Paul Walmsley E-mail to the linux-pm mailing list,=20
   dated Mon May 17 19:39:44 CDT 2010:
   https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025663.ht=
ml

3. http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Db=
lob;f=3Dkernel/power/suspend.c;h=3D56e7dbb8b996db295b4fc7cdf1b5f11a0409cb0c=
;hb=3D7e125f7b9cbfce4101191b8076d606c517a73066#l258

4. http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Db=
lob;f=3Ddrivers/base/power/main.c;h=3D941fcb87e52a12765df2aaa2e2ab21267693a=
f9f;hb=3D7e125f7b9cbfce4101191b8076d606c517a73066#l1062

5. http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Db=
lob;f=3Dkernel/power/suspend.c;h=3D56e7dbb8b996db295b4fc7cdf1b5f11a0409cb0c=
;hb=3D7e125f7b9cbfce4101191b8076d606c517a73066#l207

6. Arve Hj=F8nnev=E5g E-mail to the linux-pm mailing list, dated Fri May 21=
=20
   15:46:54 PDT 2010:
   https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025747.ht=
ml

7. Paul Walmsley E-mail to the linux-pm mailing list, dated Thu May 13=20
   23:13:50 PDT 2010:
   https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025524.ht=
ml

8. Paul Walmsley E-mail to the linux-pm mailing list, dated Mon May 17=20
   18:39:44 PDT 2010:
   https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025663.ht=
ml =20

9. Arve Hj=F8nnev=E5g E-mail to the linux-pm mailing list, dated Mon, May 1=
7=20
   20:06:33 PDT 2010:  =20
   https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025668.ht=
ml



---------------------------------------------------------------------------=
-----------

evdev.c abort_suspend_if_idle experiment:

---
 drivers/input/evdev.c |   64 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 2ee6c7a..23eaad1 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -20,8 +20,16 @@
 #include <linux/input.h>
 #include <linux/major.h>
 #include <linux/device.h>
+#include <linux/pm.h>
 #include "input-compat.h"
=20
+/*
+ * abort_suspend_if_busy: set to 1 to prevent suspend as long as there
+ * is an event in the queue; set to 0 to allow suspend at any time.
+ * XXX Intended to be read from sysfs or the input subsystem.
+ */
+static int abort_suspend_if_busy;
+
 struct evdev {
 =09int exist;
 =09int open;
@@ -118,6 +126,36 @@ static int evdev_flush(struct file *file, fl_owner_t i=
d)
 =09return retval;
 }
=20
+static int evdev_suspend(struct device *dev)
+{
+=09struct evdev *evdev =3D container_of(dev, struct evdev, dev);
+=09struct evdev_client *client;
+=09int ret =3D 0;
+
+=09if (!abort_suspend_if_busy)
+=09=09return 0;
+
+=09rcu_read_lock();
+
+=09client =3D rcu_dereference(evdev->grab);
+=09if (client) {
+=09=09if (client->head !=3D client->tail)
+=09=09=09ret =3D -EBUSY;
+=09} else {
+=09=09list_for_each_entry_rcu(client, &evdev->client_list, node) {
+=09=09=09if (client->head !=3D client->tail) {
+=09=09=09=09ret =3D -EBUSY;
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+=09}
+
+=09rcu_read_unlock();
+
+=09return ret;
+}
+
+
 static void evdev_free(struct device *dev)
 {
 =09struct evdev *evdev =3D container_of(dev, struct evdev, dev);
@@ -787,6 +825,21 @@ static void evdev_cleanup(struct evdev *evdev)
 =09}
 }
=20
+static const struct dev_pm_ops evdev_pm_ops =3D {
+=09.suspend=09=3D &evdev_suspend,
+};
+
+static char *evdev_devnode(struct device *dev, mode_t *mode)
+{
+=09return kasprintf(GFP_KERNEL, "input/%s", dev_name(dev));
+}
+
+static struct class evdev_class =3D {
+=09.name=09=09=3D "evdev",
+=09.devnode=09=3D evdev_devnode,
+=09.pm=09=09=3D &evdev_pm_ops,
+};
+
 /*
  * Create new evdev device. Note that input core serializes calls
  * to connect and disconnect so we don't need to lock evdev_table here.
@@ -826,7 +879,7 @@ static int evdev_connect(struct input_handler *handler,=
 struct input_dev *dev,
 =09evdev->handle.private =3D evdev;
=20
 =09evdev->dev.devt =3D MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor);
-=09evdev->dev.class =3D &input_class;
+=09evdev->dev.class =3D &evdev_class;
 =09evdev->dev.parent =3D &dev->dev;
 =09evdev->dev.release =3D evdev_free;
 =09device_initialize(&evdev->dev);
@@ -883,12 +936,21 @@ static struct input_handler evdev_handler =3D {
=20
 static int __init evdev_init(void)
 {
+=09int err;
+
+=09err =3D class_register(&input_class);
+=09if (err) {
+=09=09printk(KERN_ERR "evdev: unable to register evdev class\n");
+=09=09return err;
+=09}
+
 =09return input_register_handler(&evdev_handler);
 }
=20
 static void __exit evdev_exit(void)
 {
 =09input_unregister_handler(&evdev_handler);
+=09class_unregister(&evdev_class);
 }
=20
 module_init(evdev_init);
--=20
1.7.1.GIT
--155748971-683627329-1274773748=:13376
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-683627329-1274773748=:13376--
