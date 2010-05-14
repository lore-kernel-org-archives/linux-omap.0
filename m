From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 14 May 2010 00:13:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005140001360.3348@utopia.booyaka.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<1273810273-3039-2-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-315612775-1273817099=:3348"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1273810273-3039-2-git-send-email-arve@android.com>
Content-ID: <alpine.DEB.2.00.1005140006370.3348@utopia.booyaka.com>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?ISO-8859-15?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@google.com>, Mark Brown <brooni>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-315612775-1273817099=:3348
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1005140006371.3348@utopia.booyaka.com>


Hello,

some comments on the kernel-level suspend blocker API.

On Thu, 13 May 2010, Arve Hj=F8nnev=E5g wrote:

> Adds /sys/power/policy that selects the behaviour of /sys/power/state.
> After setting the policy to opportunistic, writes to /sys/power/state
> become non-blocking requests that specify which suspend state to enter
> when no suspend blockers are active. A special state, "on", stops the
> process by activating the "main" suspend blocker.
>=20
> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>

Another problem with the suspend-block kernel API is that its primary=20
use-case[1] is to work around the brokenness of patch 1's opportunistic=20
suspend governor.  The governor is broken because it intentionally ignores=
=20
timers and the scheduler.  To work around problems caused by this=20
decision, suspend-blocks must be spread throughout the kernel (and=20
userspace) to restore the previous behavior of the system.  But if patch=20
1's opportunistic suspend governor were fixed, most of the need for a=20
suspend blockers would disappear.

[ This E-mail expands on some earlier comments[2] and is also related
  to other opportunistic suspend comments[3]. ]

The suspend-block patches require already-working code to be patched to=20
keep it working.  This is a backwards approach.  Instead, broken code=20
should be patched to fix the brokenness.  But the former approach is=20
exactly what the suspend block API is intended to do.  Patches 7 and 8 in=
=20
this series are two clear cases.  Patch 7 adds an ioctl to the input=20
subsystem that will cause the system to stay running as long as there is=20
an event in the event queue.  Patch 8 adds a suspend-block call to the=20
power_supply code that causes the system to stay running as long as=20
power_supply's changed_work workqueue has work to do.  Neither of these=20
patches should be needed, since the default expectation of the mainline=20
Linux kernel is that the system should run when there is work to be done.

This longstanding expectation should be preserved, not broken and then=20
patched around.  But since patch 1 violates that expectation, there is no=
=20
choice but to add patches 7 and 8 -- and ultimately many more patches --=20
to get a working system.  Once the opportunistic suspend governor in patch=
=20
1 is introduced and enabled, the kernel will suspend the system=20
immediately, even if the system has work to do.  The only way to prevent=20
that is to add suspend-blocks.

Many suspend blocks will be needed throughout the kernel to keep things=20
working.  One might think that patches 7 and 8 are the only changes needed=
=20
to get a working Android-style opportunistic suspend system.  It turns out=
=20
that many more changes are needed.  This can be seen by looking at=20
currently shipping Android kernels, such as the current current Android=20
'msm' kernel tree[4]. Suspend-blocker usage is spread through many drivers=
=20
and subsystems:

[paul@twilight msm]$ fgrep -r wake_lock . | egrep '(^./drivers|^./arch)' |=
=20
cut -f1 -d: | sort -u
=2E/arch/arm/mach-msm/htc_battery.c
=2E/arch/arm/mach-msm/pm.c
=2E/arch/arm/mach-msm/qdsp5/adsp.c
=2E/arch/arm/mach-msm/qdsp5/audio_out.c
=2E/arch/arm/mach-msm/smd_qmi.c
=2E/arch/arm/mach-msm/smd_rpcrouter.c
=2E/arch/arm/mach-msm/smd_rpcrouter.h
=2E/arch/arm/mach-msm/smd_rpcrouter_servers.c
=2E/arch/arm/mach-msm/smd_tty.c
=2E/drivers/i2c/chips/mt9t013.c
=2E/drivers/input/evdev.c
=2E/drivers/input/misc/gpio_input.c
=2E/drivers/input/misc/gpio_matrix.c
=2E/drivers/mmc/core/core.c
=2E/drivers/net/msm_rmnet.c
=2E/drivers/rtc/alarm.c
=2E/drivers/serial/msm_serial_hs.c
=2E/drivers/usb/function/mass_storage.c
=2E/drivers/usb/gadget/f_mass_storage.c
=2E/drivers/video/msm/mddi.c
=2E/drivers/video/msm/msm_fb.c

I guess this is something like what kernel developers should eventually=20
expect to see if suspend blockers are merged.

There is a better way to make the system work as expected: these patch 1=20
shouldn't break general timer and scheduler assumptions.  If patch 1's=20
governor is fixed, most of these calls will be unnecessary.  The apparent=
=20
motivation is to prevent "untrusted" userspace processes from preventing=20
the system from entering a low-power state.  I agree that this is a=20
problem.  But it should be fixed by modifying the specific Linux code that=
=20
determines when the idle loop is entered and when the next timer wakeup=20
should occur, on a per-process basis.  Such targeted changes would ensure=
=20
that the rest of the kernel would continue to execute as expected.

regards,

- Paul


1. Arve Hj=F8nnev=E5g E-mail to the linux-pm mailing list, dated Mon, 3
   May 2010 17:09:22 -0700:
   http://www.spinics.net/lists/linux-pm/msg18432.html

2. Paul Walmsley E-mail to the linux-pm mailing list, dated Wed, 12
   May 2010 21:35:30 -0600: http://lkml.org/lkml/2010/5/12/528

3. Paul Walmsley E-mail to the linux-pm mailing list, dated Thu, 13
   May 2010 13:01:33 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18592

4. git://android.git.kernel.org/kernel/msm.git - as of commit
   c7f8bcecb06b937c45dd0e342450a3218b286b8d, "[ARM] msm: defconfig:
   Set mmap_min_addr to 32k"

5. http://android.git.kernel.org/?p=3Dkernel/msm.git;a=3Dblob;f=3Ddrivers/m=
mc/core/core.c;h=3D22f6ddad85c92f34c55035982049bb03b5abfc74;hb=3Dc7f8bcecb0=
6b937c45dd0e342450a3218b286b8d#l721
--155748971-315612775-1273817099=:3348
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-315612775-1273817099=:3348--
