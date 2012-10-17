From: Felipe Balbi <balbi@ti.com>
Subject: Re: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap:
 revert "i2c: omap: switch to threaded IRQ support")
Date: Wed, 17 Oct 2012 17:35:34 +0300
Message-ID: <20121017143534.GJ11394@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
 <87ipaanljt.fsf_-_@deeprootsystems.com>
 <20121017140002.GI11394@arwen.pp.htv.fi>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2051650222036589256=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121017140002.GI11394@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Wolfram Sang <w.sang@pengutronix.de>, Peter Zijlstra <peterz@infradead.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============2051650222036589256==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline

--AYsPlKobQGgtCvjI
Content-Type: multipart/mixed; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 17, 2012 at 05:00:02PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Tue, Oct 16, 2012 at 02:39:50PM -0700, Kevin Hilman wrote:
> > + peterz, tglx
> >=20
> > Felipe Balbi <balbi@ti.com> writes:
> >=20
> > [...]
> >=20
> > > The problem I see is that even though we properly return IRQ_WAKE_THR=
EAD
> > > and wake_up_process() manages to wakeup the IRQ thread (it returns 1),
> > > the thread is never scheduled. To make things even worse, ouw irq thr=
ead
> > > runs once, but doesn't run on a consecutive call. Here's some (rather
> > > nasty) debug prints showing the problem:
> >=20
> > [...]
> >=20
> > >> [   88.721923] try_to_wake_up 1411
> > >> [   88.725189] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proces=
s 0
> > >> [   88.731292] [sched_delayed] sched: RT throttling activated
> >=20
> > This throttling message is the key one.
> >=20
> > With RT throttling activated, the IRQ thread will not be run (it
> > eventually will be allowed much later on, but by then, the I2C xfers
> > have timed out.)
> >=20
> > As a quick hack, the throttling can be disabled by seeting the
> > sched_rt_runtime to RUNTIME_INF:
> >=20
> >         # sysctl -w kernel.sched_rt_runtime_us=3D-1
> >=20
> > and a quick test shows that things go back to working as expected.  But
> > we still need to figure out why the throttling is hapenning...
> >=20
> > So I started digging into why the RT runtime was so high, and noticed
> > that time spent in suspend was being counted as RT runtime!
> >=20
> > So spending time in suspend anywhere near sched_rt_runtime (0.95s) will
> > cause the RT throttling to always be triggered, and thus prevent IRQ
> > threads from running in the resume path.  Ouch.
> >=20
> > I think I'm already in over my head in the RT runtime stuff, but
> > counting the time spent in suspend as RT runtime smells like a bug to
> > me. no?
> >=20
> > Peter? Thomas?
>=20
> it looks like removing console output completely (echo 0 >
> /proc/sysrq-trigger) I don't see the issue anymore. Let me just run for
> a few more iterations to make sure what I'm saying is correct.

Yeah, really looks like removing console output makes the problem go
away. Ran a few iterations and it always worked fine. Full logs attached

BTW, In the meantime I think I might have found some problems with
omap_device's PM implementation. I'll test the patchset a little longer
and send an RFC.

--=20
balbi

--x+WOirvrtTKur1pg
Content-Type: application/vnd.tcpdump.pcap
Content-Disposition: attachment; filename="minicom.cap"
Content-Transfer-Encoding: quoted-printable

echo mem > /sys/power/state =0A[   48.741271] PM: Syncing filesystems ... d=
one.=0A[   50.842834] Freezing user space processes ... (elapsed 0.01 secon=
ds) done.=0A[   50.867797] Freezing remaining freezable tasks ... (elapsed =
0.02 seconds) done.=0A[   50.903656] vc vcsa63: __device_suspend 1059=0A[  =
 50.908325] vc vcs63: __device_suspend 1059=0A[   50.912780] vc vcsa6: __de=
vice_suspend 1059=0A[   50.917205] vc vcs6: __device_suspend 1059=0A[   50.=
921600] vc vcsa4: __device_suspend 1059=0A[   50.925994] vc vcs4: __device_=
suspend 1059=0A[   50.930358] vc vcsa5: __device_suspend 1059=0A[   50.9348=
14] vc vcs5: __device_suspend 1059=0A[   50.939117] vc vcsa2: __device_susp=
end 1059=0A[   50.943572] vc vcs2: __device_suspend 1059=0A[   50.947875] v=
c vcsa3: __device_suspend 1059=0A[   50.952301] vc vcs3: __device_suspend 1=
059=0A[   50.956634] block mmcblk0p2: __device_suspend 1059=0A[   50.961700=
] block mmcblk0p1: __device_suspend 1059=0A[   50.966796] block mmcblk0: __=
device_suspend 1059=0A[   50.971649] bdi 179:0: __device_suspend 1059=0A[  =
 50.976165] mmcblk mmc0:0002: __device_suspend 1059=0A[   50.981414] input =
event1: __device_suspend 1059=0A[   50.986236] input input1: __device_suspe=
nd 1059=0A[   50.991119] misc ubi_ctrl: __device_suspend 1059=0A[   50.9959=
71] misc network_throughput: __device_suspend 1059=0A[   51.001770] misc ne=
twork_latency: __device_suspend 1059=0A[   51.007324] misc cpu_dma_latency:=
 __device_suspend 1059=0A[   51.012817] oprofile-perf oprofile-perf.0: __de=
vice_suspend 1059=0A[   51.019531] mmc_host mmc0: __device_suspend 1059=0A[=
   51.024475] misc watchdog: __device_suspend 1059=0A[   51.029388] i2c-dev=
 i2c-3: __device_suspend 1059=0A[   51.034240] i2c-dev i2c-1: __device_susp=
end 1059=0A[   51.039123] rtc rtc0: __device_suspend 1059=0A[   51.043670] =
omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   51.048858] omap_i2c omap_i2c.1=
: omap_i2c_runtime_resume 1372=0A[   51.054931] omap_i2c omap_i2c.1: omap_i=
2c_low_level_resume 1282=0A[   51.061218] [<c001c118>] (unwind_backtrace+0x=
0/0xf0) from [<c040c260>] (omap_i2c_low_level_resume+0x14c/0x17c)=0A[   51.=
071746] [<c040c260>] (omap_i2c_low_level_resume+0x14c/0x17c) from [<c034a9e=
0>] (pm_generic_runtime_resume+0x2c/0x40)=0A[   51.083160] [<c034a9e0>] (pm=
_generic_runtime_resume+0x2c/0x40) from [<c034e434>] (__rpm_callback+0x34/0=
x70)=0A[   51.093383] [<c034e434>] (__rpm_callback+0x34/0x70) from [<c034f4=
1c>] (rpm_resume+0x3c8/0x650)=0A[   51.102447] [<c034f41c>] (rpm_resume+0x3=
c8/0x650) from [<c034f920>] (__pm_runtime_resume+0x48/0x60)=0A[   51.111938=
] [<c034f920>] (__pm_runtime_resume+0x48/0x60) from [<c040d384>] (omap_i2c_=
xfer+0x3c/0x1b4)=0A[   51.121643] [<c040d384>] (omap_i2c_xfer+0x3c/0x1b4) f=
rom [<c040891c>] (__i2c_transfer+0x40/0x80)=0A[   51.130859] [<c040891c>] (=
__i2c_transfer+0x40/0x80) from [<c0409e78>] (i2c_transfer+0x1f8/0x26c)=0A[ =
  51.140106] [<c0409e78>] (i2c_transfer+0x1f8/0x26c) from [<c035db54>] (twl=
_i2c_read+0xc4/0x15c)=0A[   51.149261] [<c035db54>] (twl_i2c_read+0xc4/0x15=
c) from [<c0408188>] (twl_rtc_read_u8+0x20/0x4c)=0A[   51.158477] [<c040818=
8>] (twl_rtc_read_u8+0x20/0x4c) from [<c04082cc>] (twl_rtc_read_time+0x1c/0=
x1c4)=0A[   51.168182] [<c04082cc>] (twl_rtc_read_time+0x1c/0x1c4) from [<c=
0405e9c>] (__rtc_read_time+0x48/0x54)=0A[   51.177856] [<c0405e9c>] (__rtc_=
read_time+0x48/0x54) from [<c04067dc>] (rtc_read_time+0x30/0x44)=0A[   51.1=
87103] [<c04067dc>] (rtc_read_time+0x30/0x44) from [<c0405c0c>] (rtc_suspen=
d.part.2+0x14/0xd0)=0A[   51.196594] [<c0405c0c>] (rtc_suspend.part.2+0x14/=
0xd0) from [<c0405cf4>] (rtc_suspend+0x2c/0x38)=0A[   51.205932] [<c0405cf4=
>] (rtc_suspend+0x2c/0x38) from [<c0520c18>] (legacy_suspend+0x30/0x68)=0A[=
   51.214904] [<c0520c18>] (legacy_suspend+0x30/0x68) from [<c034c944>] (__=
device_suspend+0x240/0x25c)=0A[   51.224487] [<c034c944>] (__device_suspend=
+0x240/0x25c) from [<c034d194>] (dpm_suspend+0x58/0x218)=0A[   51.233917] [=
<c034d194>] (dpm_suspend+0x58/0x218) from [<c0087aa8>] (suspend_devices_and=
_enter+0x8c/0x1b0)=0A[   51.244079] [<c0087aa8>] (suspend_devices_and_enter=
+0x8c/0x1b0) from [<c0087c68>] (enter_state+0x9c/0xdc)=0A[   51.254119] [<c=
0087c68>] (enter_state+0x9c/0xdc) from [<c0087cbc>] (pm_suspend+0x14/0x70)=
=0A[   51.262725] [<c0087cbc>] (pm_suspend+0x14/0x70) from [<c0086d24>] (st=
ate_store+0x30/0x3c)=0A[   51.271301] [<c0086d24>] (state_store+0x30/0x3c) =
=66rom [<c02d3a18>] (kobj_attr_store+0x14/0x20)=0A[   51.280364] [<c02d3a18=
>] (kobj_attr_store+0x14/0x20) from [<c017bd2c>] (sysfs_write_file+0x80/0xb=
4)=0A[   51.289886] [<c017bd2c>] (sysfs_write_file+0x80/0xb4) from [<c01175=
20>] (vfs_write+0xa8/0x138)=0A[   51.298919] [<c0117520>] (vfs_write+0xa8/0=
x138) from [<c011778c>] (sys_write+0x40/0x68)=0A[   51.307342] [<c011778c>]=
 (sys_write+0x40/0x68) from [<c0013f40>] (ret_fast_syscall+0x0/0x3c)=0A[   =
51.316284] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=
=0A[   51.323516] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   51.32894=
8] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   51.333862] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 886: mask 601f stat 1510=0A[   51.340698] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[   51.345611] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[   51.350555] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[   51.356811] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   51.3=
62365] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   51.368072] omap_=
i2c omap_i2c.1: omap_i2c_isr 880=0A[   51.372985] omap_i2c omap_i2c.1: omap=
_i2c_isr 886: mask 601f stat 1104=0A[   51.379821] omap_i2c omap_i2c.1: oma=
p_i2c_isr 889=0A[   51.384735] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   =
51.389648] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   5=
1.395782] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   51.401367] oma=
p_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   51.407196] omap_i2c omap_i=
2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[   51.414428] omap_i2c o=
map_i2c.1: omap_i2c_xfer_msg 537=0A[   51.419891] omap_i2c omap_i2c.1: omap=
_i2c_isr 880=0A[   51.424804] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 6=
01f stat 0108=0A[   51.431610] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   =
51.436523] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   51.441436] =3D=3D=3D=
> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   51.447601] omap_i2c o=
map_i2c.1: omap_i2c_isr_thread 908=0A[   51.453247] omap_i2c omap_i2c.1: om=
ap_i2c_isr_thread 1033=0A[   51.458984] omap_i2c omap_i2c.1: omap_i2c_xfer =
663=0A[   51.464050] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   51.469116=
] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[   51.4=
76348] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   51.481781] omap_i2c=
 omap_i2c.1: omap_i2c_isr 880=0A[   51.486694] omap_i2c omap_i2c.1: omap_i2=
c_isr 886: mask 601f stat 1510=0A[   51.493499] omap_i2c omap_i2c.1: omap_i=
2c_isr 889=0A[   51.498413] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   51.=
503326] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   51.5=
09490] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   51.515106] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   51.520812] omap_i2c omap_i2c.=
1: omap_i2c_isr 880=0A[   51.525726] omap_i2c omap_i2c.1: omap_i2c_isr 886:=
 mask 601f stat 0104=0A[   51.532562] omap_i2c omap_i2c.1: omap_i2c_isr 889=
=0A[   51.537475] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   51.542388] =
=3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   51.548522] o=
map_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   51.554138] omap_i2c omap_=
i2c.1: omap_i2c_isr_thread 1033=0A[   51.559875] omap_i2c omap_i2c.1: omap_=
i2c_xfer 663=0A[   51.564941] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   =
51.570007] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=
=0A[   51.577239] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   51.58264=
1] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   51.587554] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 886: mask 601f stat 1510=0A[   51.594360] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[   51.599273] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[   51.604187] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[   51.610351] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   51.6=
15997] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   51.621643] omap_=
i2c omap_i2c.1: omap_i2c_isr 880=0A[   51.626586] omap_i2c omap_i2c.1: omap=
_i2c_isr 886: mask 601f stat 1104=0A[   51.633392] omap_i2c omap_i2c.1: oma=
p_i2c_isr 889=0A[   51.638305] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   =
51.643218] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   5=
1.649353] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   51.654968] oma=
p_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   51.660675] omap_i2c omap_i=
2c.1: addr: 0x004b, len: 6, flags: 0x1, stop: 1=0A[   51.667907] omap_i2c o=
map_i2c.1: omap_i2c_xfer_msg 537=0A[   51.673461] omap_i2c omap_i2c.1: omap=
_i2c_isr 880=0A[   51.678375] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 6=
01f stat 0108=0A[   51.685180] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   =
51.690093] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   51.695037] =3D=3D=3D=
> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   51.701171] omap_i2c o=
map_i2c.1: omap_i2c_isr_thread 908=0A[   51.706848] omap_i2c omap_i2c.1: om=
ap_i2c_isr_thread 1033=0A[   51.712554] omap_i2c omap_i2c.1: omap_i2c_isr 8=
80=0A[   51.717468] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0=
104=0A[   51.724273] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   51.729187]=
 omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   51.734100] =3D=3D=3D> irq_wake=
_thread 139: IRQ 72 wake_up_process 0=0A[   51.740234] omap_i2c omap_i2c.1:=
 omap_i2c_isr_thread 908=0A[   51.745819] omap_i2c omap_i2c.1: omap_i2c_isr=
_thread 1033=0A[   51.751586] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[   =
51.756683] input event0: __device_suspend 1059=0A[   51.761444] input input=
0: __device_suspend 1059=0A[   51.766265] misc psaux: __device_suspend 1059=
=0A[   51.770904] input mice: __device_suspend 1059=0A[   51.775482] usbmon=
 usbmon0: __device_suspend 1059=0A[   51.780456] spi_master spi4: __device_=
suspend 1059=0A[   51.785491] spi_master spi3: __device_suspend 1059=0A[   =
51.790557] spi_master spi2: __device_suspend 1059=0A[   51.795654] spi_mast=
er spi1: __device_suspend 1059=0A[   51.800689] bdi mtd-rwmap: __device_sus=
pend 1059=0A[   51.805572] bdi mtd-romap: __device_suspend 1059=0A[   51.81=
0485] bdi mtd-unmap: __device_suspend 1059=0A[   51.815338] platform twl403=
0-codec: __device_suspend 1059=0A[   51.821044] block loop7: __device_suspe=
nd 1059=0A[   51.825744] bdi 7:7: __device_suspend 1059=0A[   51.830047] bl=
ock loop6: __device_suspend 1059=0A[   51.834777] bdi 7:6: __device_suspend=
 1059=0A[   51.839080] block loop5: __device_suspend 1059=0A[   51.843780] =
bdi 7:5: __device_suspend 1059=0A[   51.848083] block loop4: __device_suspe=
nd 1059=0A[   51.852813] bdi 7:4: __device_suspend 1059=0A[   51.857177] bl=
ock loop3: __device_suspend 1059=0A[   51.861846] bdi 7:3: __device_suspend=
 1059=0A[   51.866180] block loop2: __device_suspend 1059=0A[   51.870849] =
bdi 7:2: __device_suspend 1059=0A[   51.875213] block loop1: __device_suspe=
nd 1059=0A[   51.879913] bdi 7:1: __device_suspend 1059=0A[   51.884246] bl=
ock loop0: __device_suspend 1059=0A[   51.888977] bdi 7:0: __device_suspend=
 1059=0A[   51.893280] misc loop-control: __device_suspend 1059=0A[   51.89=
8529] block ram15: __device_suspend 1059=0A[   51.903228] bdi 1:15: __devic=
e_suspend 1059=0A[   51.907653] block ram14: __device_suspend 1059=0A[   51=
=2E912384] bdi 1:14: __device_suspend 1059=0A[   51.916778] block ram13: __=
device_suspend 1059=0A[   51.921539] bdi 1:13: __device_suspend 1059=0A[   =
51.925933] block ram12: __device_suspend 1059=0A[   51.930664] bdi 1:12: __=
device_suspend 1059=0A[   51.935119] block ram11: __device_suspend 1059=0A[=
   51.939758] bdi 1:11: __device_suspend 1059=0A[   51.944213] block ram10:=
 __device_suspend 1059=0A[   51.948883] bdi 1:10: __device_suspend 1059=0A[=
   51.953399] SysRq : Changing Loglevel=0A[   51.957244] Loglevel set to 0=
=0A=0A-bash: echo: write error: Operation not permitted=0Aroot@arwen:~# =0A=
root@arwen:~# ls=0Aprepare  spidev_test=0Aroot@arwen:~# ls=0Aprepare  spide=
v_test=0Aroot@arwen:~# dmesg=0A[   54.242370] dma dma0chan22: device_resume=
 577=0A[   54.242401] dma dma0chan23: device_resume 577=0A[   54.242431] dm=
a dma0chan24: device_resume 577=0A[   54.242462] dma dma0chan25: device_res=
ume 577=0A[   54.242492] dma dma0chan26: device_resume 577=0A[   54.242523]=
 dma dma0chan27: device_resume 577=0A[   54.242584] dma dma0chan28: device_=
resume 577=0A[   54.242614] dma dma0chan29: device_resume 577=0A[   54.2426=
45] dma dma0chan30: device_resume 577=0A[   54.242675] dma dma0chan31: devi=
ce_resume 577=0A[   54.242706] dma dma0chan32: device_resume 577=0A[   54.2=
42736] dma dma0chan33: device_resume 577=0A[   54.242767] dma dma0chan34: d=
evice_resume 577=0A[   54.242797] dma dma0chan35: device_resume 577=0A[   5=
4.242828] dma dma0chan36: device_resume 577=0A[   54.242858] dma dma0chan37=
: device_resume 577=0A[   54.242919] dma dma0chan38: device_resume 577=0A[ =
  54.242950] dma dma0chan39: device_resume 577=0A[   54.242980] dma dma0cha=
n40: device_resume 577=0A[   54.243011] dma dma0chan41: device_resume 577=
=0A[   54.243041] dma dma0chan42: device_resume 577=0A[   54.243072] dma dm=
a0chan43: device_resume 577=0A[   54.243103] dma dma0chan44: device_resume =
577=0A[   54.243133] dma dma0chan45: device_resume 577=0A[   54.243164] dma=
 dma0chan46: device_resume 577=0A[   54.243194] dma dma0chan47: device_resu=
me 577=0A[   54.243255] dma dma0chan48: device_resume 577=0A[   54.243286] =
dma dma0chan49: device_resume 577=0A[   54.243316] dma dma0chan50: device_r=
esume 577=0A[   54.243347] dma dma0chan51: device_resume 577=0A[   54.24337=
7] dma dma0chan52: device_resume 577=0A[   54.243408] dma dma0chan53: devic=
e_resume 577=0A[   54.243438] dma dma0chan54: device_resume 577=0A[   54.24=
3469] dma dma0chan55: device_resume 577=0A[   54.243499] dma dma0chan56: de=
vice_resume 577=0A[   54.243530] dma dma0chan57: device_resume 577=0A[   54=
=2E243560] dma dma0chan58: device_resume 577=0A[   54.243621] dma dma0chan5=
9: device_resume 577=0A[   54.243652] dma dma0chan60: device_resume 577=0A[=
   54.243682] dma dma0chan61: device_resume 577=0A[   54.243713] dma dma0ch=
an62: device_resume 577=0A[   54.243743] dma dma0chan63: device_resume 577=
=0A[   54.243774] dma dma0chan64: device_resume 577=0A[   54.243804] dma dm=
a0chan65: device_resume 577=0A[   54.243835] dma dma0chan66: device_resume =
577=0A[   54.243865] dma dma0chan67: device_resume 577=0A[   54.243896] dma=
 dma0chan68: device_resume 577=0A[   54.243957] dma dma0chan69: device_resu=
me 577=0A[   54.243988] dma dma0chan70: device_resume 577=0A[   54.244018] =
dma dma0chan71: device_resume 577=0A[   54.244049] dma dma0chan72: device_r=
esume 577=0A[   54.244079] dma dma0chan73: device_resume 577=0A[   54.24411=
0] dma dma0chan74: device_resume 577=0A[   54.244140] dma dma0chan75: devic=
e_resume 577=0A[   54.244171] dma dma0chan76: device_resume 577=0A[   54.24=
4201] dma dma0chan77: device_resume 577=0A[   54.244232] dma dma0chan78: de=
vice_resume 577=0A[   54.244293] dma dma0chan79: device_resume 577=0A[   54=
=2E244323] dma dma0chan80: device_resume 577=0A[   54.244354] dma dma0chan8=
1: device_resume 577=0A[   54.244384] dma dma0chan82: device_resume 577=0A[=
   54.244415] dma dma0chan83: device_resume 577=0A[   54.244445] dma dma0ch=
an84: device_resume 577=0A[   54.244476] dma dma0chan85: device_resume 577=
=0A[   54.244506] dma dma0chan86: device_resume 577=0A[   54.244537] dma dm=
a0chan87: device_resume 577=0A[   54.244567] dma dma0chan88: device_resume =
577=0A[   54.244598] dma dma0chan89: device_resume 577=0A[   54.244659] dma=
 dma0chan90: device_resume 577=0A[   54.244689] dma dma0chan91: device_resu=
me 577=0A[   54.244720] dma dma0chan92: device_resume 577=0A[   54.244750] =
dma dma0chan93: device_resume 577=0A[   54.244781] dma dma0chan94: device_r=
esume 577=0A[   54.244812] dma dma0chan95: device_resume 577=0A[   54.24484=
2] dma dma0chan96: device_resume 577=0A[   54.244873] dma dma0chan97: devic=
e_resume 577=0A[   54.244903] dma dma0chan98: device_resume 577=0A[   54.24=
4934] dma dma0chan99: device_resume 577=0A[   54.244995] dma dma0chan100: d=
evice_resume 577=0A[   54.245025] dma dma0chan101: device_resume 577=0A[   =
54.245056] dma dma0chan102: device_resume 577=0A[   54.245086] dma dma0chan=
103: device_resume 577=0A[   54.245117] dma dma0chan104: device_resume 577=
=0A[   54.245147] dma dma0chan105: device_resume 577=0A[   54.245178] dma d=
ma0chan106: device_resume 577=0A[   54.245208] dma dma0chan107: device_resu=
me 577=0A[   54.245239] dma dma0chan108: device_resume 577=0A[   54.245269]=
 dma dma0chan109: device_resume 577=0A[   54.245330] dma dma0chan110: devic=
e_resume 577=0A[   54.245361] dma dma0chan111: device_resume 577=0A[   54.2=
45391] dma dma0chan112: device_resume 577=0A[   54.245422] dma dma0chan113:=
 device_resume 577=0A[   54.245452] dma dma0chan114: device_resume 577=0A[ =
  54.245483] dma dma0chan115: device_resume 577=0A[   54.245513] dma dma0ch=
an116: device_resume 577=0A[   54.245544] dma dma0chan117: device_resume 57=
7=0A[   54.245574] dma dma0chan118: device_resume 577=0A[   54.245605] dma =
dma0chan119: device_resume 577=0A[   54.245666] dma dma0chan120: device_res=
ume 577=0A[   54.245697] dma dma0chan121: device_resume 577=0A[   54.245727=
] dma dma0chan122: device_resume 577=0A[   54.245758] dma dma0chan123: devi=
ce_resume 577=0A[   54.245788] dma dma0chan124: device_resume 577=0A[   54.=
245819] dma dma0chan125: device_resume 577=0A[   54.245849] dma dma0chan126=
: device_resume 577=0A[   54.245880] i2c i2c-1: device_resume 577=0A[   54.=
245910] twl 1-0048: device_resume 577=0A[   54.245971] platform twl: device=
_resume 577=0A[   54.246002] dummy 1-0049: device_resume 577=0A[   54.24603=
2] dummy 1-004a: device_resume 577=0A[   54.246063] dummy 1-004b: device_re=
sume 577=0A[   54.246093] twl4030_gpio twl4030_gpio: device_resume 577=0A[ =
  54.246124] gpio gpiochip492: device_resume 577=0A[   54.246154] omap_hsmm=
c omap_hsmmc.0: device_resume 577=0A[   54.246185] omap_hsmmc omap_hsmmc.0:=
 _od_resume 884=0A[   54.246490] i2c i2c-1: master_xfer[0] W, addr=3D0x49, =
len=3D4=0A[   54.246520] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   54.24=
6612] omap_i2c omap_i2c.1: addr: 0x0049, len: 4, flags: 0x0, stop: 1=0A[   =
54.246612] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   54.246643] omap=
_i2c omap_i2c.1: omap_i2c_isr 880=0A[   54.246673] omap_i2c omap_i2c.1: oma=
p_i2c_isr 886: mask 601f stat 1510=0A[   54.246704] omap_i2c omap_i2c.1: om=
ap_i2c_isr 889=0A[   54.246704] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  =
 54.246765] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   =
54.246887] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   54.246917] om=
ap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   54.246948] omap_i2c omap_i2c.=
1: omap_i2c_isr_thread 1033=0A[   54.246978] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[   54.247009] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 0104=0A[   54.247009] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   54.24=
7039] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   54.247039] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 0=0A[   54.247070] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[   54.247100] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0004)=0A[   54.247131] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[   54.247619] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[   54.247680] =
i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[   54.247711] i2c i2c-=
1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[   54.247741] omap_i2c omap_i2=
c.1: omap_i2c_xfer 626=0A[   54.247772] omap_i2c omap_i2c.1: addr: 0x004b, =
len: 1, flags: 0x0, stop: 0=0A[   54.247772] omap_i2c omap_i2c.1: omap_i2c_=
xfer_msg 537=0A[   54.247802] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   5=
4.247833] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[   =
54.247833] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   54.247863] omap_i2c =
omap_i2c.1: omap_i2c_isr 894=0A[   54.247894] =3D=3D=3D> irq_wake_thread 13=
9: IRQ 72 wake_up_process 1=0A[   54.247955] omap_i2c omap_i2c.1: omap_i2c_=
isr_thread 908=0A[   54.247985] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=
=0A[   54.248016] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.24=
8046] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   54.248046] omap_i2c omap_=
i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[   54.248077] omap_i2c omap=
_i2c.1: omap_i2c_isr 889=0A[   54.248077] omap_i2c omap_i2c.1: omap_i2c_isr=
 894=0A[   54.248107] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proces=
s 0=0A[   54.248199] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   54.=
248229] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   54.248260] omap_i2c=
 omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.248321] omap_i2c omap_i2c.1:=
 addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[   54.248352] omap_i2c omap_i=
2c.1: omap_i2c_xfer_msg 537=0A[   54.248413] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[   54.248413] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 0108=0A[   54.248443] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   54.24=
8443] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   54.248474] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[   54.248504] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[   54.248535] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0008)=0A[   54.248565] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A=
[   54.248565] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.24862=
6] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[   54.248687] i2c i2c-1: maste=
r_xfer[0] W, addr=3D0x4b, len=3D1=0A[   54.248718] i2c i2c-1: master_xfer[1=
] R, addr=3D0x4b, len=3D1=0A[   54.248718] omap_i2c omap_i2c.1: omap_i2c_xf=
er 626=0A[   54.248748] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0=
x0, stop: 0=0A[   54.248779] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[=
   54.248809] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   54.248809] omap_i=
2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[   54.248840] omap_=
i2c omap_i2c.1: omap_i2c_isr 889=0A[   54.248840] omap_i2c omap_i2c.1: omap=
_i2c_isr 894=0A[   54.248870] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_u=
p_process 1=0A[   54.248931] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=
=0A[   54.248931] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   54.248962=
] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.248992] omap_i2c o=
map_i2c.1: omap_i2c_isr 880=0A[   54.248992] omap_i2c omap_i2c.1: omap_i2c_=
isr 886: mask 601f stat 1104=0A[   54.249023] omap_i2c omap_i2c.1: omap_i2c=
_isr 889=0A[   54.249053] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   54.24=
9053] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   54.249=
084] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   54.249084] omap_i2c=
 omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   54.249114] omap_i2c omap_i2c.1: oma=
p_i2c_isr_thread 1033=0A[   54.249176] omap_i2c omap_i2c.1: addr: 0x004b, l=
en: 1, flags: 0x1, stop: 1=0A[   54.249206] omap_i2c omap_i2c.1: omap_i2c_x=
fer_msg 537=0A[   54.249237] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   54=
=2E249267] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  =
 54.249267] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   54.249298] omap_i2c=
 omap_i2c.1: omap_i2c_isr 894=0A[   54.249328] =3D=3D=3D> irq_wake_thread 1=
39: IRQ 72 wake_up_process 1=0A[   54.249359] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 908=0A[   54.249359] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=
=0A[   54.249389] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   54.249420=
] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.249481] omap_i2c o=
map_i2c.1: omap_i2c_xfer 663=0A[   54.249511] i2c i2c-1: master_xfer[0] W, =
addr=3D0x4b, len=3D1=0A[   54.249542] i2c i2c-1: master_xfer[1] R, addr=3D0=
x4b, len=3D1=0A[   54.249542] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   =
54.249572] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=
=0A[   54.249603] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   54.24963=
3] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   54.249633] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 886: mask 601f stat 1110=0A[   54.249664] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[   54.249664] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[   54.249694] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[   54.249755] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   54.2=
49755] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   54.249786] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.249816] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[   54.249816] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 1104=0A[   54.249847] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[   54.249847] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   54.249877] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   54.249908] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   54.249908] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[   54.249938] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[   54.249999] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, =
flags: 0x1, stop: 1=0A[   54.250030] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[   54.250061] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   54.250091=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[   54.25009=
1] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   54.250122] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[   54.250152] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[   54.250183] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[   54.250183] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[   5=
4.250213] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   54.250244] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.250305] omap_i2c omap_i2c.=
1: omap_i2c_xfer 663=0A[   54.250335] i2c i2c-1: master_xfer[0] W, addr=3D0=
x4b, len=3D2=0A[   54.250335] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   =
54.250366] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=
=0A[   54.250396] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   54.25042=
7] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   54.250457] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 886: mask 601f stat 1110=0A[   54.250457] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[   54.250488] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[   54.250488] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[   54.250549] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   54.2=
50549] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   54.250579] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.250610] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[   54.250640] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 0104=0A[   54.250640] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[   54.250671] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   54.250671] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   54.250701] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   54.250701] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[   54.250732] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[   54.250793] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ =
  54.250915] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[   54.250=
946] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[   54.250976] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   54.251007] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[   54.251007] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[   54.251037] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[   54.251068] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[   54.251068] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   54.25=
1098] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   54.251129] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[   54.251159] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[   54.251190] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[   54.251190] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[   54.251220] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   54.251251] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[   54.251251] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   54.251281] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[   54.251281] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[   54.251312] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[   54.251342] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   54.251=
342] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.251403] omap_i2=
c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[   54.251434] om=
ap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   54.251495] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 880=0A[   54.251495] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 0108=0A[   54.251525] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[   54.251525] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   54.251556]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   54.251586] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   54.251617] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0008)=0A[   54.251617] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x0004)=0A[   54.251647] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[   54.251708] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[   54.251739] i=
2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[   54.251770] i2c i2c-1=
: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[   54.251770] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer 626=0A[   54.251800] omap_i2c omap_i2c.1: addr: 0x004b,=
 len: 1, flags: 0x0, stop: 0=0A[   54.251831] omap_i2c omap_i2c.1: omap_i2c=
_xfer_msg 537=0A[   54.251861] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   =
54.251861] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  =
 54.251892] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   54.251892] omap_i2c=
 omap_i2c.1: omap_i2c_isr 894=0A[   54.251922] =3D=3D=3D> irq_wake_thread 1=
39: IRQ 72 wake_up_process 1=0A[   54.251983] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 908=0A[   54.251983] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=
=0A[   54.252014] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.25=
2044] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   54.252044] omap_i2c omap_=
i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[   54.252075] omap_i2c omap=
_i2c.1: omap_i2c_isr 889=0A[   54.252075] omap_i2c omap_i2c.1: omap_i2c_isr=
 894=0A[   54.252105] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proces=
s 0=0A[   54.252136] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   54.=
252136] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   54.252166] omap_i2c=
 omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.252227] omap_i2c omap_i2c.1:=
 addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[   54.252258] omap_i2c omap_i=
2c.1: omap_i2c_xfer_msg 537=0A[   54.252288] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[   54.252319] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 0108=0A[   54.252319] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   54.25=
2349] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   54.252380] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[   54.252410] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[   54.252410] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0008)=0A[   54.252441] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A=
[   54.252471] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.25253=
2] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[   54.252563] i2c i2c-1: maste=
r_xfer[0] W, addr=3D0x4b, len=3D2=0A[   54.252563] omap_i2c omap_i2c.1: oma=
p_i2c_xfer 626=0A[   54.252593] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, =
flags: 0x0, stop: 1=0A[   54.252624] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[   54.252655] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   54.252655=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[   54.25268=
5] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   54.252685] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[   54.252716] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[   54.252777] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[   54.252777] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   5=
4.252807] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   54.252838] om=
ap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   54.252838] omap_i2c omap_i2c.1: o=
map_i2c_isr 886: mask 601f stat 0104=0A[   54.252868] omap_i2c omap_i2c.1: =
omap_i2c_isr 889=0A[   54.252899] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[=
   54.252899] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[ =
  54.252929] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   54.252929] =
omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   54.252960] omap_i2c omap_i2=
c.1: omap_i2c_isr_thread 1033=0A[   54.253021] omap_i2c omap_i2c.1: omap_i2=
c_xfer 663=0A[   55.603973] twl_rtc twl_rtc: device_resume 577=0A[   55.604=
034] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[   55.604095] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   55.604156] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[   55.604187] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[   55.604217] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[   55.604217] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[   55.604248] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   55.60=
4248] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   55.604309] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[   55.604400] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[   55.604431] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[   55.604431] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[   55.604492] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   55.604522] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[   55.604522] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   55.604553] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[   55.604583] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 1=0A[   55.604614] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[   55.604614] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   55.604=
644] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   55.604766] omap_i2=
c omap_i2c.1: omap_i2c_xfer 663=0A[   55.604827] platform twl4030_wdt: devi=
ce_resume 577=0A[   55.604858] twl4030_pwrbutton twl4030_pwrbutton: device_=
resume 577=0A[   55.604888] twl4030-audio twl4030-audio: device_resume 577=
=0A[   55.604919] twl_reg twl_reg.0: device_resume 577=0A[   55.604949] reg=
ulator regulator.1: device_resume 577=0A[   55.605010] twl_reg twl_reg.1: d=
evice_resume 577=0A[   55.605041] regulator regulator.2: device_resume 577=
=0A[   55.605072] twl_reg twl_reg.6: device_resume 577=0A[   55.605102] reg=
ulator regulator.3: device_resume 577=0A[   55.605133] twl_reg twl_reg.3: d=
evice_resume 577=0A[   55.605163] regulator regulator.4: device_resume 577=
=0A[   55.605194] twl_reg twl_reg.5: device_resume 577=0A[   55.605224] reg=
ulator regulator.5: device_resume 577=0A[   55.605285] twl_reg twl_reg.8: d=
evice_resume 577=0A[   55.605316] regulator regulator.6: device_resume 577=
=0A[   55.605346] i2c i2c-3: device_resume 577=0A[   55.605377] i2c 3-0050:=
 device_resume 577=0A[   55.605407] net lo: device_resume 577=0A[   55.6054=
38] mem mem: device_resume 577=0A[   55.605468] mem kmem: device_resume 577=
=0A[   55.605499] mem null: device_resume 577=0A[   55.605560] mem zero: de=
vice_resume 577=0A[   55.605590] mem full: device_resume 577=0A[   55.60562=
1] mem random: device_resume 577=0A[   55.605651] mem urandom: device_resum=
e 577=0A[   55.605682] mem kmsg: device_resume 577=0A[   55.605712] tty tty=
: device_resume 577=0A[   55.605743] tty console: device_resume 577=0A[   5=
5.605773] tty tty0: device_resume 577=0A[   55.605834] vc vcs: device_resum=
e 577=0A[   55.605865] vc vcsa: device_resume 577=0A[   55.605895] vc vcs1:=
 device_resume 577=0A[   55.605926] vc vcsa1: device_resume 577=0A[   55.60=
5957] tty tty1: device_resume 577=0A[   55.605987] tty tty2: device_resume =
577=0A[   55.606018] tty tty3: device_resume 577=0A[   55.606048] tty tty4:=
 device_resume 577=0A[   55.606079] tty tty5: device_resume 577=0A[   55.60=
6140] tty tty6: device_resume 577=0A[   55.606170] tty tty7: device_resume =
577=0A[   55.606201] tty tty8: device_resume 577=0A[   55.606231] tty tty9:=
 device_resume 577=0A[   55.606262] tty tty10: device_resume 577=0A[   55.6=
06292] tty tty11: device_resume 577=0A[   55.606323] tty tty12: device_resu=
me 577=0A[   55.606353] tty tty13: device_resume 577=0A[   55.606384] tty t=
ty14: device_resume 577=0A[   55.606445] tty tty15: device_resume 577=0A[  =
 55.606475] tty tty16: device_resume 577=0A[   55.606506] tty tty17: device=
_resume 577=0A[   55.606536] tty tty18: device_resume 577=0A[   55.606567] =
tty tty19: device_resume 577=0A[   55.606597] tty tty20: device_resume 577=
=0A[   55.606628] tty tty21: device_resume 577=0A[   55.606658] tty tty22: =
device_resume 577=0A[   55.606719] tty tty23: device_resume 577=0A[   55.60=
6750] tty tty24: device_resume 577=0A[   55.606781] tty tty25: device_resum=
e 577=0A[   55.606811] tty tty26: device_resume 577=0A[   55.606842] tty tt=
y27: device_resume 577=0A[   55.606872] tty tty28: device_resume 577=0A[   =
55.606933] tty tty29: device_resume 577=0A[   55.606994] tty tty30: device_=
resume 577=0A[   55.607025] tty tty31: device_resume 577=0A[   55.607055] t=
ty tty32: device_resume 577=0A[   55.607086] tty tty33: device_resume 577=
=0A[   55.607116] tty tty34: device_resume 577=0A[   55.607147] tty tty35: =
device_resume 577=0A[   55.607177] tty tty36: device_resume 577=0A[   55.60=
7208] tty tty37: device_resume 577=0A[   55.607269] tty tty38: device_resum=
e 577=0A[   55.607299] tty tty39: device_resume 577=0A[   55.607330] tty tt=
y40: device_resume 577=0A[   55.607452] tty tty41: device_resume 577=0A[   =
55.607482] tty tty42: device_resume 577=0A[   55.607513] tty tty43: device_=
resume 577=0A[   55.607543] tty tty44: device_resume 577=0A[   55.607574] t=
ty tty45: device_resume 577=0A[   55.607604] tty tty46: device_resume 577=
=0A[   55.607666] tty tty47: device_resume 577=0A[   55.607696] tty tty48: =
device_resume 577=0A[   55.607727] tty tty49: device_resume 577=0A[   55.60=
7757] tty tty50: device_resume 577=0A[   55.607788] tty tty51: device_resum=
e 577=0A[   55.607818] tty tty52: device_resume 577=0A[   55.607849] tty tt=
y53: device_resume 577=0A[   55.607879] tty tty54: device_resume 577=0A[   =
55.607940] tty tty55: device_resume 577=0A[   55.607971] tty tty56: device_=
resume 577=0A[   55.608001] tty tty57: device_resume 577=0A[   55.608032] t=
ty tty58: device_resume 577=0A[   55.608062] tty tty59: device_resume 577=
=0A[   55.608093] tty tty60: device_resume 577=0A[   55.608123] tty tty61: =
device_resume 577=0A[   55.608154] tty tty62: device_resume 577=0A[   55.60=
8215] tty tty63: device_resume 577=0A[   55.608245]  clocksource: device_re=
sume 577=0A[   55.608276] clocksource clocksource0: device_resume 577=0A[  =
 55.608306] alarmtimer alarmtimer: device_resume 577=0A[   55.608337] event=
_source ARMv7 Cortex-A8: device_resume 577=0A[   55.608367] event_source br=
eakpoint: device_resume 577=0A[   55.608398] event_source tracepoint: devic=
e_resume 577=0A[   55.608428] event_source software: device_resume 577=0A[ =
  55.608489] graphics fbcon: device_resume 577=0A[   55.608520] tty ptmx: d=
evice_resume 577=0A[   55.608551] serial8250 serial8250: device_resume 577=
=0A[   55.608581] tty ttyS0: device_resume 577=0A[   55.608612] tty ttyS1: =
device_resume 577=0A[   55.608642] tty ttyS2: device_resume 577=0A[   55.60=
8703] tty ttyS3: device_resume 577=0A[   55.608734] tty ttyO0: device_resum=
e 577=0A[   55.608764] tty ttyO1: device_resume 577=0A[   55.608795] tty tt=
yO2: device_resume 577=0A[   55.608825] tty ttyO3: device_resume 577=0A[   =
55.608856] bdi 1:0: device_resume 577=0A[   55.608886] block ram0: device_r=
esume 577=0A[   55.608917] bdi 1:1: device_resume 577=0A[   55.608978] bloc=
k ram1: device_resume 577=0A[   55.609008] bdi 1:2: device_resume 577=0A[  =
 55.609039] block ram2: device_resume 577=0A[   55.609069] bdi 1:3: device_=
resume 577=0A[   55.609100] block ram3: device_resume 577=0A[   55.609130] =
bdi 1:4: device_resume 577=0A[   55.609161] block ram4: device_resume 577=
=0A[   55.609191] bdi 1:5: device_resume 577=0A[   55.609222] block ram5: d=
evice_resume 577=0A[   55.609283] bdi 1:6: device_resume 577=0A[   55.60931=
3] block ram6: device_resume 577=0A[   55.609344] bdi 1:7: device_resume 57=
7=0A[   55.609374] block ram7: device_resume 577=0A[   55.609405] bdi 1:8: =
device_resume 577=0A[   55.609436] block ram8: device_resume 577=0A[   55.6=
09466] bdi 1:9: device_resume 577=0A[   55.609497] block ram9: device_resum=
e 577=0A[   55.609527] bdi 1:10: device_resume 577=0A[   55.609588] block r=
am10: device_resume 577=0A[   55.609619] bdi 1:11: device_resume 577=0A[   =
55.609649] block ram11: device_resume 577=0A[   55.609680] bdi 1:12: device=
_resume 577=0A[   55.609710] block ram12: device_resume 577=0A[   55.609741=
] bdi 1:13: device_resume 577=0A[   55.609771] block ram13: device_resume 5=
77=0A[   55.609802] bdi 1:14: device_resume 577=0A[   55.609863] block ram1=
4: device_resume 577=0A[   55.609893] bdi 1:15: device_resume 577=0A[   55.=
609924] block ram15: device_resume 577=0A[   55.609954] misc loop-control: =
device_resume 577=0A[   55.609985] bdi 7:0: device_resume 577=0A[   55.6100=
15] block loop0: device_resume 577=0A[   55.610046] bdi 7:1: device_resume =
577=0A[   55.610107] block loop1: device_resume 577=0A[   55.610137] bdi 7:=
2: device_resume 577=0A[   55.610168] block loop2: device_resume 577=0A[   =
55.610198] bdi 7:3: device_resume 577=0A[   55.610229] block loop3: device_=
resume 577=0A[   55.610260] bdi 7:4: device_resume 577=0A[   55.610290] blo=
ck loop4: device_resume 577=0A[   55.610321] bdi 7:5: device_resume 577=0A[=
   55.610351] block loop5: device_resume 577=0A[   55.610412] bdi 7:6: devi=
ce_resume 577=0A[   55.610443] block loop6: device_resume 577=0A[   55.6104=
73] bdi 7:7: device_resume 577=0A[   55.610504] block loop7: device_resume =
577=0A[   55.610534] platform twl4030-codec: device_resume 577=0A[   55.610=
565] bdi mtd-unmap: device_resume 577=0A[   55.610595] bdi mtd-romap: devic=
e_resume 577=0A[   55.610626] bdi mtd-rwmap: device_resume 577=0A[   55.610=
687] spi_master spi1: device_resume 577=0A[   55.610717] spi_master spi2: d=
evice_resume 577=0A[   55.610748] spi_master spi3: device_resume 577=0A[   =
55.610778] spi_master spi4: device_resume 577=0A[   55.610809] usbmon usbmo=
n0: device_resume 577=0A[   55.610839] input mice: device_resume 577=0A[   =
55.610870] misc psaux: device_resume 577=0A[   55.610900] input input0: dev=
ice_resume 577=0A[   55.611724] input event0: device_resume 577=0A[   55.61=
1785] rtc rtc0: device_resume 577=0A[   55.611816] i2c i2c-1: master_xfer[0=
] W, addr=3D0x4b, len=3D1=0A[   55.611846] i2c i2c-1: master_xfer[1] R, add=
r=3D0x4b, len=3D1=0A[   55.611877] omap_i2c omap_i2c.1: omap_i2c_xfer 626=
=0A[   55.611907] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, st=
op: 0=0A[   55.611938] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   55.=
611968] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   55.611999] omap_i2c oma=
p_i2c.1: omap_i2c_isr 886: mask 601f stat 1510=0A[   55.611999] omap_i2c om=
ap_i2c.1: omap_i2c_isr 889=0A[   55.612030] omap_i2c omap_i2c.1: omap_i2c_i=
sr 894=0A[   55.612060] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proc=
ess 1=0A[   55.612121] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   5=
5.612152] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   55.612182] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   55.612213] omap_i2c omap_i2c.=
1: omap_i2c_isr 880=0A[   55.612243] omap_i2c omap_i2c.1: omap_i2c_isr 886:=
 mask 601f stat 1104=0A[   55.612243] omap_i2c omap_i2c.1: omap_i2c_isr 889=
=0A[   55.612274] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   55.612274] =
=3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   55.612304] o=
map_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   55.612304] omap_i2c omap_=
i2c.1: IRQ (ISR =3D 0x0004)=0A[   55.612335] omap_i2c omap_i2c.1: omap_i2c_=
isr_thread 1033=0A[   55.612518] omap_i2c omap_i2c.1: addr: 0x004b, len: 1,=
 flags: 0x1, stop: 1=0A[   55.612548] omap_i2c omap_i2c.1: omap_i2c_xfer_ms=
g 537=0A[   55.612609] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   55.61264=
0] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[   55.6126=
40] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   55.612670] omap_i2c omap_i2=
c.1: omap_i2c_isr 894=0A[   55.612701] =3D=3D=3D> irq_wake_thread 139: IRQ =
72 wake_up_process 1=0A[   55.612731] omap_i2c omap_i2c.1: omap_i2c_isr_thr=
ead 908=0A[   55.612731] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[   55=
=2E612762] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   55.612792] omap_=
i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   55.612854] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer 663=0A[   55.612884] i2c i2c-1: master_xfer[0] W, addr=
=3D0x4b, len=3D2=0A[   55.612915] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A=
[   55.612945] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1=0A[   55.612976] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   55.613=
006] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   55.613006] omap_i2c omap_i=
2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[   55.613037] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[   55.613037] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[   55.613067] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[   55.613128] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   55.6=
13128] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   55.613159] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[   55.613189] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[   55.613189] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 0104=0A[   55.613220] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[   55.613220] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   55.613250] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   55.613281] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   55.613281] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[   55.613311] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[   55.613372] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ =
  55.613403] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[   55.613=
433] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D6=0A[   55.613433] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   55.613464] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[   55.613494] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[   55.613525] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[   55.613555] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[   55.613555] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   55.61=
3586] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   55.613586] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[   55.613647] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[   55.613647] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[   55.613677] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[   55.613708] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   55.613739] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[   55.613739] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   55.613769] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[   55.613769] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[   55.613800] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[   55.613800] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   55.613=
830] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   55.613891] omap_i2=
c omap_i2c.1: addr: 0x004b, len: 6, flags: 0x1, stop: 1=0A[   55.613922] om=
ap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   55.614074] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 880=0A[   55.614105] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 1108=0A[   55.614105] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[   55.614135] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   55.614166]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   55.614196] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   55.614227] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0008)=0A[   55.614257] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x2000)=0A[   55.614288] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[   55.614288] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   55.614318] om=
ap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[   55.614349] o=
map_i2c omap_i2c.1: omap_i2c_isr 889=0A[   55.614349] omap_i2c omap_i2c.1: =
omap_i2c_isr 894=0A[   55.614379] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wa=
ke_up_process 0=0A[   55.614379] omap_i2c omap_i2c.1: omap_i2c_isr_thread 9=
08=0A[   55.614410] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   55.6144=
40] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   55.614501] omap_i2c=
 omap_i2c.1: omap_i2c_xfer 663=0A[   55.614532] i2c-dev i2c-1: device_resum=
e 577=0A[   55.614593] i2c-dev i2c-3: device_resume 577=0A[   55.614624] mi=
sc watchdog: device_resume 577=0A[   55.614654] mmc_host mmc0: device_resum=
e 577=0A[   55.614685] oprofile-perf oprofile-perf.0: device_resume 577=0A[=
   55.614746] misc cpu_dma_latency: device_resume 577=0A[   55.614776] misc=
 network_latency: device_resume 577=0A[   55.614807] misc network_throughpu=
t: device_resume 577=0A[   55.614837] misc ubi_ctrl: device_resume 577=0A[ =
  55.614868] input input1: device_resume 577=0A[   55.614898] input event1:=
 device_resume 577=0A[   55.614959] mmcblk mmc0:0002: device_resume 577=0A[=
   55.615386] bdi 179:0: device_resume 577=0A[   55.615447] block mmcblk0: =
device_resume 577=0A[   55.615478] block mmcblk0p1: device_resume 577=0A[  =
 55.615509] block mmcblk0p2: device_resume 577=0A[   55.615539] vc vcs3: de=
vice_resume 577=0A[   55.615570] vc vcsa3: device_resume 577=0A[   55.61563=
1] vc vcs2: device_resume 577=0A[   55.615661] vc vcsa2: device_resume 577=
=0A[   55.615692] vc vcs5: device_resume 577=0A[   55.615722] vc vcsa5: dev=
ice_resume 577=0A[   55.615753] vc vcs4: device_resume 577=0A[   55.615783]=
 vc vcsa4: device_resume 577=0A[   55.615814] vc vcs6: device_resume 577=0A=
[   55.615844] vc vcsa6: device_resume 577=0A[   55.615875] vc vcs63: devic=
e_resume 577=0A[   55.615936] vc vcsa63: device_resume 577=0A[   55.615966]=
 PM: resume of devices complete after 1379.150 msecs=0A[   55.621795] PM: F=
inishing wakeup.=0A[   55.622711] omap_i2c omap_i2c.3: omap_i2c_runtime_sus=
pend 1358=0A[   55.622741] omap_i2c omap_i2c.3: omap_i2c_low_level_suspend =
1255=0A[   55.622802] [<c001c118>] (unwind_backtrace+0x0/0xf0) from [<c040c=
340>] (omap_i2c_low_level_suspend+0x74/0x8c)=0A[   55.622863] [<c040c340>] =
(omap_i2c_low_level_suspend+0x74/0x8c) from [<c034a9a0>] (pm_generic_runtim=
e_suspend+0x2c/0x40)=0A[   55.622894] [<c034a9a0>] (pm_generic_runtime_susp=
end+0x2c/0x40) from [<c00403a8>] (_od_runtime_suspend+0xc/0x24)=0A[   55.62=
2955] [<c00403a8>] (_od_runtime_suspend+0xc/0x24) from [<c034e434>] (__rpm_=
callback+0x34/0x70)=0A[   55.622985] [<c034e434>] (__rpm_callback+0x34/0x70=
) from [<c034e7b4>] (rpm_suspend+0xe0/0x5d4)=0A[   55.623016] [<c034e7b4>] =
(rpm_suspend+0xe0/0x5d4) from [<c034fd10>] (pm_runtime_work+0x7c/0x98)=0A[ =
  55.623046] [<c034fd10>] (pm_runtime_work+0x7c/0x98) from [<c0061414>] (pr=
ocess_one_work+0x198/0x59c)=0A[   55.623077] [<c0061414>] (process_one_work=
+0x198/0x59c) from [<c0061ba4>] (worker_thread+0x138/0x37c)=0A[   55.623199=
] [<c0061ba4>] (worker_thread+0x138/0x37c) from [<c0067538>] (kthread+0xa4/=
0xb0)=0A[   55.623229] [<c0067538>] (kthread+0xa4/0xb0) from [<c0013ff0>] (=
ret_from_fork+0x14/0x24)=0A[   55.621795] Restarting tasks ... done.=0A[   =
57.053039] omap_i2c omap_i2c.1: omap_i2c_runtime_suspend 1358=0A[   57.0530=
70] omap_i2c omap_i2c.1: omap_i2c_low_level_suspend 1255=0A[   57.053131] [=
<c001c118>] (unwind_backtrace+0x0/0xf0) from [<c040c340>] (omap_i2c_low_lev=
el_suspend+0x74/0x8c)=0A[   57.053161] [<c040c340>] (omap_i2c_low_level_sus=
pend+0x74/0x8c) from [<c034a9a0>] (pm_generic_runtime_suspend+0x2c/0x40)=0A=
[   57.053222] [<c034a9a0>] (pm_generic_runtime_suspend+0x2c/0x40) from [<c=
00403a8>] (_od_runtime_suspend+0xc/0x24)=0A[   57.053253] [<c00403a8>] (_od=
_runtime_suspend+0xc/0x24) from [<c034e434>] (__rpm_callback+0x34/0x70)=0A[=
   57.053283] [<c034e434>] (__rpm_callback+0x34/0x70) from [<c034e7b4>] (rp=
m_suspend+0xe0/0x5d4)=0A[   57.053314] [<c034e7b4>] (rpm_suspend+0xe0/0x5d4=
) from [<c034fd10>] (pm_runtime_work+0x7c/0x98)=0A[   57.053344] [<c034fd10=
>] (pm_runtime_work+0x7c/0x98) from [<c0061414>] (process_one_work+0x198/0x=
59c)=0A[   57.053375] [<c0061414>] (process_one_work+0x198/0x59c) from [<c0=
061ba4>] (worker_thread+0x138/0x37c)=0A[   57.053375] [<c0061ba4>] (worker_=
thread+0x138/0x37c) from [<c0067538>] (kthread+0xa4/0xb0)=0A[   57.053436] =
[<c0067538>] (kthread+0xa4/0xb0) from [<c0013ff0>] (ret_from_fork+0x14/0x24=
)=0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroo=
t@arwen:~# echo mem=08=08=08=08=08=08=08=08dmesg=08=08=08=08=08ls=08=08echo=
 mem > /sys/power/state =0A=0A-bash: echo: write error: Operation not permi=
tted=0Aroot@arwen:~# =0Aroot@arwen:~# ls=0Aprepare  spidev_test=0Aroot@arwe=
n:~# dmesg=0A[   81.008575] platform omap-mcbsp.5: device_resume 577=0A[   =
81.008605] platform omapfb: device_resume 577=0A[   81.008636] cpu cpu0: de=
vice_resume 577=0A[   81.008666] omap_wdt omap_wdt: device_resume 577=0A[  =
 81.008697] arm-pmu arm-pmu: device_resume 577=0A[   81.008758] bdi default=
: device_resume 577=0A[   81.008789] omap-dma-engine omap-dma-engine: devic=
e_resume 577=0A[   81.008819] dma dma0chan0: device_resume 577=0A[   81.008=
850] dma dma0chan1: device_resume 577=0A[   81.008880] dma dma0chan2: devic=
e_resume 577=0A[   81.008911] dma dma0chan3: device_resume 577=0A[   81.008=
941] dma dma0chan4: device_resume 577=0A[   81.008972] dma dma0chan5: devic=
e_resume 577=0A[   81.009002] dma dma0chan6: device_resume 577=0A[   81.009=
063] dma dma0chan7: device_resume 577=0A[   81.009094] dma dma0chan8: devic=
e_resume 577=0A[   81.009124] dma dma0chan9: device_resume 577=0A[   81.009=
155] dma dma0chan10: device_resume 577=0A[   81.009185] dma dma0chan11: dev=
ice_resume 577=0A[   81.009216] dma dma0chan12: device_resume 577=0A[   81.=
009277] dma dma0chan13: device_resume 577=0A[   81.009307] dma dma0chan14: =
device_resume 577=0A[   81.009338] dma dma0chan15: device_resume 577=0A[   =
81.009368] dma dma0chan16: device_resume 577=0A[   81.009399] dma dma0chan1=
7: device_resume 577=0A[   81.009521] dma dma0chan18: device_resume 577=0A[=
   81.009582] dma dma0chan19: device_resume 577=0A[   81.009613] dma dma0ch=
an20: device_resume 577=0A[   81.009643] dma dma0chan21: device_resume 577=
=0A[   81.009674] dma dma0chan22: device_resume 577=0A[   81.009704] dma dm=
a0chan23: device_resume 577=0A[   81.009735] dma dma0chan24: device_resume =
577=0A[   81.009765] dma dma0chan25: device_resume 577=0A[   81.009796] dma=
 dma0chan26: device_resume 577=0A[   81.009826] dma dma0chan27: device_resu=
me 577=0A[   81.009857] dma dma0chan28: device_resume 577=0A[   81.009918] =
dma dma0chan29: device_resume 577=0A[   81.009948] dma dma0chan30: device_r=
esume 577=0A[   81.009979] dma dma0chan31: device_resume 577=0A[   81.01000=
9] dma dma0chan32: device_resume 577=0A[   81.010040] dma dma0chan33: devic=
e_resume 577=0A[   81.010070] dma dma0chan34: device_resume 577=0A[   81.01=
0101] dma dma0chan35: device_resume 577=0A[   81.010131] dma dma0chan36: de=
vice_resume 577=0A[   81.010162] dma dma0chan37: device_resume 577=0A[   81=
=2E010192] dma dma0chan38: device_resume 577=0A[   81.010253] dma dma0chan3=
9: device_resume 577=0A[   81.010284] dma dma0chan40: device_resume 577=0A[=
   81.010314] dma dma0chan41: device_resume 577=0A[   81.010345] dma dma0ch=
an42: device_resume 577=0A[   81.010375] dma dma0chan43: device_resume 577=
=0A[   81.010406] dma dma0chan44: device_resume 577=0A[   81.010437] dma dm=
a0chan45: device_resume 577=0A[   81.010467] dma dma0chan46: device_resume =
577=0A[   81.010498] dma dma0chan47: device_resume 577=0A[   81.010528] dma=
 dma0chan48: device_resume 577=0A[   81.010559] dma dma0chan49: device_resu=
me 577=0A[   81.010620] dma dma0chan50: device_resume 577=0A[   81.010650] =
dma dma0chan51: device_resume 577=0A[   81.010681] dma dma0chan52: device_r=
esume 577=0A[   81.010711] dma dma0chan53: device_resume 577=0A[   81.01074=
2] dma dma0chan54: device_resume 577=0A[   81.010772] dma dma0chan55: devic=
e_resume 577=0A[   81.010803] dma dma0chan56: device_resume 577=0A[   81.01=
0833] dma dma0chan57: device_resume 577=0A[   81.010864] dma dma0chan58: de=
vice_resume 577=0A[   81.010894] dma dma0chan59: device_resume 577=0A[   81=
=2E010925] dma dma0chan60: device_resume 577=0A[   81.010986] dma dma0chan6=
1: device_resume 577=0A[   81.011016] dma dma0chan62: device_resume 577=0A[=
   81.011047] dma dma0chan63: device_resume 577=0A[   81.011077] dma dma0ch=
an64: device_resume 577=0A[   81.011108] dma dma0chan65: device_resume 577=
=0A[   81.011138] dma dma0chan66: device_resume 577=0A[   81.011169] dma dm=
a0chan67: device_resume 577=0A[   81.011199] dma dma0chan68: device_resume =
577=0A[   81.011230] dma dma0chan69: device_resume 577=0A[   81.011260] dma=
 dma0chan70: device_resume 577=0A[   81.011322] dma dma0chan71: device_resu=
me 577=0A[   81.011352] dma dma0chan72: device_resume 577=0A[   81.011383] =
dma dma0chan73: device_resume 577=0A[   81.011413] dma dma0chan74: device_r=
esume 577=0A[   81.011444] dma dma0chan75: device_resume 577=0A[   81.01147=
4] dma dma0chan76: device_resume 577=0A[   81.011505] dma dma0chan77: devic=
e_resume 577=0A[   81.011535] dma dma0chan78: device_resume 577=0A[   81.01=
1566] dma dma0chan79: device_resume 577=0A[   81.011596] dma dma0chan80: de=
vice_resume 577=0A[   81.011657] dma dma0chan81: device_resume 577=0A[   81=
=2E011688] dma dma0chan82: device_resume 577=0A[   81.011718] dma dma0chan8=
3: device_resume 577=0A[   81.011749] dma dma0chan84: device_resume 577=0A[=
   81.011779] dma dma0chan85: device_resume 577=0A[   81.011810] dma dma0ch=
an86: device_resume 577=0A[   81.011840] dma dma0chan87: device_resume 577=
=0A[   81.011871] dma dma0chan88: device_resume 577=0A[   81.011901] dma dm=
a0chan89: device_resume 577=0A[   81.011932] dma dma0chan90: device_resume =
577=0A[   81.011962] dma dma0chan91: device_resume 577=0A[   81.012023] dma=
 dma0chan92: device_resume 577=0A[   81.012054] dma dma0chan93: device_resu=
me 577=0A[   81.012084] dma dma0chan94: device_resume 577=0A[   81.012115] =
dma dma0chan95: device_resume 577=0A[   81.012145] dma dma0chan96: device_r=
esume 577=0A[   81.012176] dma dma0chan97: device_resume 577=0A[   81.01220=
7] dma dma0chan98: device_resume 577=0A[   81.012237] dma dma0chan99: devic=
e_resume 577=0A[   81.012268] dma dma0chan100: device_resume 577=0A[   81.0=
12298] dma dma0chan101: device_resume 577=0A[   81.012329] dma dma0chan102:=
 device_resume 577=0A[   81.012390] dma dma0chan103: device_resume 577=0A[ =
  81.012420] dma dma0chan104: device_resume 577=0A[   81.012451] dma dma0ch=
an105: device_resume 577=0A[   81.012481] dma dma0chan106: device_resume 57=
7=0A[   81.012512] dma dma0chan107: device_resume 577=0A[   81.012542] dma =
dma0chan108: device_resume 577=0A[   81.012573] dma dma0chan109: device_res=
ume 577=0A[   81.012603] dma dma0chan110: device_resume 577=0A[   81.012634=
] dma dma0chan111: device_resume 577=0A[   81.012664] dma dma0chan112: devi=
ce_resume 577=0A[   81.012725] dma dma0chan113: device_resume 577=0A[   81.=
012756] dma dma0chan114: device_resume 577=0A[   81.012786] dma dma0chan115=
: device_resume 577=0A[   81.012817] dma dma0chan116: device_resume 577=0A[=
   81.012847] dma dma0chan117: device_resume 577=0A[   81.012878] dma dma0c=
han118: device_resume 577=0A[   81.012908] dma dma0chan119: device_resume 5=
77=0A[   81.012939] dma dma0chan120: device_resume 577=0A[   81.012969] dma=
 dma0chan121: device_resume 577=0A[   81.013000] dma dma0chan122: device_re=
sume 577=0A[   81.013061] dma dma0chan123: device_resume 577=0A[   81.01309=
2] dma dma0chan124: device_resume 577=0A[   81.013122] dma dma0chan125: dev=
ice_resume 577=0A[   81.013153] dma dma0chan126: device_resume 577=0A[   81=
=2E013183] i2c i2c-1: device_resume 577=0A[   81.013214] twl 1-0048: device=
_resume 577=0A[   81.013244] platform twl: device_resume 577=0A[   81.01327=
5] dummy 1-0049: device_resume 577=0A[   81.013336] dummy 1-004a: device_re=
sume 577=0A[   81.013366] dummy 1-004b: device_resume 577=0A[   81.013397] =
twl4030_gpio twl4030_gpio: device_resume 577=0A[   81.013427] gpio gpiochip=
492: device_resume 577=0A[   81.013458] omap_hsmmc omap_hsmmc.0: device_res=
ume 577=0A[   81.013488] omap_hsmmc omap_hsmmc.0: _od_resume 884=0A[   81.0=
13763] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D4=0A[   81.013793] o=
map_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   81.013824] omap_i2c omap_i2c.1:=
 addr: 0x0049, len: 4, flags: 0x0, stop: 1=0A[   81.013854] omap_i2c omap_i=
2c.1: omap_i2c_xfer_msg 537=0A[   81.013885] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[   81.013885] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1510=0A[   81.013916] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   81.01=
3916] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   81.013977] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[   81.014038] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[   81.014068] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[   81.014099] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[   81.014129] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   81.014129] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[   81.014160] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   81.014160] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[   81.014190] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[   81.014221] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[   81.014221] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   81.014=
282] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   81.014556] omap_i2=
c omap_i2c.1: omap_i2c_xfer 663=0A[   81.014617] i2c i2c-1: master_xfer[0] =
W, addr=3D0x4b, len=3D1=0A[   81.014648] i2c i2c-1: master_xfer[1] R, addr=
=3D0x4b, len=3D1=0A[   81.014678] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A=
[   81.014709] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0=0A[   81.014709] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   81.014=
739] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   81.014770] omap_i2c omap_i=
2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[   81.014770] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[   81.014801] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[   81.014831] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[   81.014892] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   81.0=
14892] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   81.014923] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[   81.014953] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[   81.014953] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 1104=0A[   81.014984] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[   81.014984] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   81.015014] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   81.015045] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   81.015045] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[   81.015075] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[   81.015136] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, =
flags: 0x1, stop: 1=0A[   81.015167] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[   81.015228] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   81.015228=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[   81.01525=
8] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   81.015258] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[   81.015289] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[   81.015319] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[   81.015350] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[   8=
1.015380] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   81.015380] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   81.015441] omap_i2c omap_i2c.=
1: omap_i2c_xfer 663=0A[   81.015502] i2c i2c-1: master_xfer[0] W, addr=3D0=
x4b, len=3D1=0A[   81.015502] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=
=3D1=0A[   81.015533] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   81.01556=
3] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[   81.=
015594] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   81.015624] omap_i2=
c omap_i2c.1: omap_i2c_isr 880=0A[   81.015624] omap_i2c omap_i2c.1: omap_i=
2c_isr 886: mask 601f stat 1110=0A[   81.015655] omap_i2c omap_i2c.1: omap_=
i2c_isr 889=0A[   81.015655] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   81=
=2E015686] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   8=
1.015716] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   81.015747] oma=
p_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   81.015777] omap_i2c omap_i2c.1=
: omap_i2c_isr_thread 1033=0A[   81.015808] omap_i2c omap_i2c.1: omap_i2c_i=
sr 880=0A[   81.015808] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f st=
at 1104=0A[   81.015838] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   81.015=
838] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   81.015869] =3D=3D=3D> irq_=
wake_thread 139: IRQ 72 wake_up_process 0=0A[   81.015899] omap_i2c omap_i2=
c.1: omap_i2c_isr_thread 908=0A[   81.015899] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x0004)=0A[   81.015930] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[   81.015991] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, st=
op: 1=0A[   81.015991] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   81.=
016052] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   81.016082] omap_i2c oma=
p_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[   81.016082] omap_i2c om=
ap_i2c.1: omap_i2c_isr 889=0A[   81.016113] omap_i2c omap_i2c.1: omap_i2c_i=
sr 894=0A[   81.016143] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proc=
ess 1=0A[   81.016204] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   8=
1.016204] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[   81.016235] omap_i=
2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   81.016265] omap_i2c omap_i2c.1: o=
map_i2c_isr_thread 1033=0A[   81.016296] omap_i2c omap_i2c.1: omap_i2c_xfer=
 663=0A[   81.016357] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[=
   81.016357] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[   81.01=
6387] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   81.016418] omap_i2c omap=
_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[   81.016418] omap_i2c=
 omap_i2c.1: omap_i2c_xfer_msg 537=0A[   81.016448] omap_i2c omap_i2c.1: om=
ap_i2c_isr 880=0A[   81.016479] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask=
 601f stat 1110=0A[   81.016479] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ =
  81.016510] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   81.016540] =3D=3D=
=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   81.016571] omap_i2=
c omap_i2c.1: omap_i2c_isr_thread 908=0A[   81.016601] omap_i2c omap_i2c.1:=
 IRQ (ISR =3D 0x0010)=0A[   81.016601] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 1033=0A[   81.016632] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   81.0=
16662] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[   81.=
016693] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   81.016693] omap_i2c oma=
p_i2c.1: omap_i2c_isr 894=0A[   81.016723] =3D=3D=3D> irq_wake_thread 139: =
IRQ 72 wake_up_process 0=0A[   81.016723] omap_i2c omap_i2c.1: omap_i2c_isr=
_thread 908=0A[   81.016754] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ =
  81.016784] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   81.016845]=
 omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[   81.01=
6845] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   81.016906] omap_i2c =
omap_i2c.1: omap_i2c_isr 880=0A[   81.016906] omap_i2c omap_i2c.1: omap_i2c=
_isr 886: mask 601f stat 0108=0A[   81.016937] omap_i2c omap_i2c.1: omap_i2=
c_isr 889=0A[   81.016967] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   81.0=
16967] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   81.01=
6998] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   81.017028] omap_i2=
c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[   81.017059] omap_i2c omap_i2c.1: IR=
Q (ISR =3D 0x0004)=0A[   81.017089] omap_i2c omap_i2c.1: omap_i2c_isr_threa=
d 1033=0A[   81.017150] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[   81.017=
181] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[   81.017211] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   81.017242] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[   81.017333] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[   81.017364] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[   81.017364] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[   81.017395] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   81.01=
7425] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   81.017425] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[   81.017486] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[   81.017486] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[   81.017517] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[   81.017547] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   81.017578] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[   81.017578] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   81.017608] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[   81.017608] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[   81.017639] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[   81.017669] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   81.017=
669] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   81.017730] omap_i2=
c omap_i2c.1: omap_i2c_xfer 663=0A[   81.017883] i2c i2c-1: master_xfer[0] =
W, addr=3D0x4b, len=3D1=0A[   81.017883] i2c i2c-1: master_xfer[1] R, addr=
=3D0x4b, len=3D1=0A[   81.017913] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A=
[   81.017944] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0=0A[   81.017944] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   81.017=
974] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   81.018005] omap_i2c omap_i=
2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[   81.018035] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[   81.018035] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[   81.018066] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[   81.018096] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   81.0=
18127] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   81.018127] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[   81.018157] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[   81.018188] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 1104=0A[   81.018218] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[   81.018218] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   81.018249] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   81.018249] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   81.018280] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[   81.018310] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[   81.018371] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, =
flags: 0x1, stop: 1=0A[   81.018371] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[   81.018432] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   81.018463=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[   81.01846=
3] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   81.018493] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[   81.018493] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[   81.018524] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[   81.018554] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[   8=
1.018585] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   81.018585] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   81.018646] omap_i2c omap_i2c.=
1: omap_i2c_xfer 663=0A[   81.018676] i2c i2c-1: master_xfer[0] W, addr=3D0=
x4b, len=3D1=0A[   81.018707] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=
=3D1=0A[   81.018737] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   81.01876=
8] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[   81.=
018768] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   81.018798] omap_i2=
c omap_i2c.1: omap_i2c_isr 880=0A[   81.018829] omap_i2c omap_i2c.1: omap_i=
2c_isr 886: mask 601f stat 1110=0A[   81.018829] omap_i2c omap_i2c.1: omap_=
i2c_isr 889=0A[   81.018859] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   81=
=2E018890] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   8=
1.018920] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   81.018951] oma=
p_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   81.018951] omap_i2c omap_i2c.1=
: omap_i2c_isr_thread 1033=0A[   81.018981] omap_i2c omap_i2c.1: omap_i2c_i=
sr 880=0A[   81.019012] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f st=
at 1104=0A[   81.019012] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   81.019=
042] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   81.019042] =3D=3D=3D> irq_=
wake_thread 139: IRQ 72 wake_up_process 0=0A[   81.019073] omap_i2c omap_i2=
c.1: omap_i2c_isr_thread 908=0A[   81.019104] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x0004)=0A[   81.019134] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[   81.019165] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, st=
op: 1=0A[   81.019195] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   81.=
019226] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   81.019256] omap_i2c oma=
p_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[   81.019287] omap_i2c om=
ap_i2c.1: omap_i2c_isr 889=0A[   81.019287] omap_i2c omap_i2c.1: omap_i2c_i=
sr 894=0A[   81.019317] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proc=
ess 1=0A[   81.019348] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   8=
1.019378] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[   81.019378] omap_i=
2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[   81.019409] omap_i2c omap_i2c.1: o=
map_i2c_isr_thread 1033=0A[   81.019470] omap_i2c omap_i2c.1: omap_i2c_xfer=
 663=0A[   81.019500] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[=
   81.019531] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   81.019561] omap_=
i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[   81.019561] =
omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   81.019592] omap_i2c omap_i=
2c.1: omap_i2c_isr 880=0A[   81.019622] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 1110=0A[   81.019622] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[   81.019653] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   81.019683]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   81.019714] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   81.019744] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0010)=0A[   81.019744] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 1033=0A[   81.019775] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[=
   81.019805] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A=
[   81.019805] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   81.019836] omap_=
i2c omap_i2c.1: omap_i2c_isr 894=0A[   81.019836] =3D=3D=3D> irq_wake_threa=
d 139: IRQ 72 wake_up_process 0=0A[   81.019866] omap_i2c omap_i2c.1: omap_=
i2c_isr_thread 908=0A[   81.019897] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x000=
4)=0A[   81.019927] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   81.=
019958] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[   82.349273] twl_rtc twl=
_rtc: device_resume 577=0A[   82.349334] i2c i2c-1: master_xfer[0] W, addr=
=3D0x4b, len=3D2=0A[   82.349365] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A=
[   82.349395] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1=0A[   82.349426] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   82.349=
456] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   82.349456] omap_i2c omap_i=
2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[   82.349487] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[   82.349487] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[   82.349548] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[   82.349578] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   82.3=
49609] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   82.349639] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[   82.349670] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[   82.349670] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 0104=0A[   82.349700] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[   82.349700] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   82.349731] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   82.349761] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   82.349761] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[   82.349792] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[   82.349853] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ =
  82.349914] platform twl4030_wdt: device_resume 577=0A[   82.349945] twl40=
30_pwrbutton twl4030_pwrbutton: device_resume 577=0A[   82.349975] twl4030-=
audio twl4030-audio: device_resume 577=0A[   82.350006] twl_reg twl_reg.0: =
device_resume 577=0A[   82.350036] regulator regulator.1: device_resume 577=
=0A[   82.350067] twl_reg twl_reg.1: device_resume 577=0A[   82.350128] reg=
ulator regulator.2: device_resume 577=0A[   82.350158] twl_reg twl_reg.6: d=
evice_resume 577=0A[   82.350189] regulator regulator.3: device_resume 577=
=0A[   82.350219] twl_reg twl_reg.3: device_resume 577=0A[   82.350250] reg=
ulator regulator.4: device_resume 577=0A[   82.350280] twl_reg twl_reg.5: d=
evice_resume 577=0A[   82.350311] regulator regulator.5: device_resume 577=
=0A[   82.350341] twl_reg twl_reg.8: device_resume 577=0A[   82.350402] reg=
ulator regulator.6: device_resume 577=0A[   82.350433] i2c i2c-3: device_re=
sume 577=0A[   82.350463] i2c 3-0050: device_resume 577=0A[   82.350494] ne=
t lo: device_resume 577=0A[   82.350524] mem mem: device_resume 577=0A[   8=
2.350555] mem kmem: device_resume 577=0A[   82.350585] mem null: device_res=
ume 577=0A[   82.350646] mem zero: device_resume 577=0A[   82.350677] mem f=
ull: device_resume 577=0A[   82.350708] mem random: device_resume 577=0A[  =
 82.350738] mem urandom: device_resume 577=0A[   82.350769] mem kmsg: devic=
e_resume 577=0A[   82.350799] tty tty: device_resume 577=0A[   82.350830] t=
ty console: device_resume 577=0A[   82.350860] tty tty0: device_resume 577=
=0A[   82.350921] vc vcs: device_resume 577=0A[   82.350952] vc vcsa: devic=
e_resume 577=0A[   82.350982] vc vcs1: device_resume 577=0A[   82.351013] v=
c vcsa1: device_resume 577=0A[   82.351043] tty tty1: device_resume 577=0A[=
   82.351074] tty tty2: device_resume 577=0A[   82.351104] tty tty3: device=
_resume 577=0A[   82.351135] tty tty4: device_resume 577=0A[   82.351165] t=
ty tty5: device_resume 577=0A[   82.351226] tty tty6: device_resume 577=0A[=
   82.351257] tty tty7: device_resume 577=0A[   82.351287] tty tty8: device=
_resume 577=0A[   82.351318] tty tty9: device_resume 577=0A[   82.351348] t=
ty tty10: device_resume 577=0A[   82.351379] tty tty11: device_resume 577=
=0A[   82.351409] tty tty12: device_resume 577=0A[   82.351440] tty tty13: =
device_resume 577=0A[   82.351501] tty tty14: device_resume 577=0A[   82.35=
1531] tty tty15: device_resume 577=0A[   82.351562] tty tty16: device_resum=
e 577=0A[   82.351593] tty tty17: device_resume 577=0A[   82.351623] tty tt=
y18: device_resume 577=0A[   82.351654] tty tty19: device_resume 577=0A[   =
82.351684] tty tty20: device_resume 577=0A[   82.351715] tty tty21: device_=
resume 577=0A[   82.351745] tty tty22: device_resume 577=0A[   82.351806] t=
ty tty23: device_resume 577=0A[   82.351837] tty tty24: device_resume 577=
=0A[   82.351867] tty tty25: device_resume 577=0A[   82.351898] tty tty26: =
device_resume 577=0A[   82.351928] tty tty27: device_resume 577=0A[   82.35=
1959] tty tty28: device_resume 577=0A[   82.351989] tty tty29: device_resum=
e 577=0A[   82.352020] tty tty30: device_resume 577=0A[   82.352081] tty tt=
y31: device_resume 577=0A[   82.352111] tty tty32: device_resume 577=0A[   =
82.352142] tty tty33: device_resume 577=0A[   82.352172] tty tty34: device_=
resume 577=0A[   82.352203] tty tty35: device_resume 577=0A[   82.352233] t=
ty tty36: device_resume 577=0A[   82.352264] tty tty37: device_resume 577=
=0A[   82.352294] tty tty38: device_resume 577=0A[   82.352355] tty tty39: =
device_resume 577=0A[   82.352386] tty tty40: device_resume 577=0A[   82.35=
2416] tty tty41: device_resume 577=0A[   82.352447] tty tty42: device_resum=
e 577=0A[   82.352478] tty tty43: device_resume 577=0A[   82.352508] tty tt=
y44: device_resume 577=0A[   82.352539] tty tty45: device_resume 577=0A[   =
82.352630] tty tty46: device_resume 577=0A[   82.352661] tty tty47: device_=
resume 577=0A[   82.352691] tty tty48: device_resume 577=0A[   82.352722] t=
ty tty49: device_resume 577=0A[   82.352752] tty tty50: device_resume 577=
=0A[   82.352783] tty tty51: device_resume 577=0A[   82.352813] tty tty52: =
device_resume 577=0A[   82.352874] tty tty53: device_resume 577=0A[   82.35=
2905] tty tty54: device_resume 577=0A[   82.352935] tty tty55: device_resum=
e 577=0A[   82.352966] tty tty56: device_resume 577=0A[   82.352996] tty tt=
y57: device_resume 577=0A[   82.353027] tty tty58: device_resume 577=0A[   =
82.353057] tty tty59: device_resume 577=0A[   82.353179] tty tty60: device_=
resume 577=0A[   82.353210] tty tty61: device_resume 577=0A[   82.353240] t=
ty tty62: device_resume 577=0A[   82.353302] tty tty63: device_resume 577=
=0A[   82.353332]  clocksource: device_resume 577=0A[   82.353363] clocksou=
rce clocksource0: device_resume 577=0A[   82.353393] alarmtimer alarmtimer:=
 device_resume 577=0A[   82.353424] event_source ARMv7 Cortex-A8: device_re=
sume 577=0A[   82.353454] event_source breakpoint: device_resume 577=0A[   =
82.353485] event_source tracepoint: device_resume 577=0A[   82.353515] even=
t_source software: device_resume 577=0A[   82.353576] graphics fbcon: devic=
e_resume 577=0A[   82.353607] tty ptmx: device_resume 577=0A[   82.353637] =
serial8250 serial8250: device_resume 577=0A[   82.353668] tty ttyS0: device=
_resume 577=0A[   82.353698] tty ttyS1: device_resume 577=0A[   82.353729] =
tty ttyS2: device_resume 577=0A[   82.353790] tty ttyS3: device_resume 577=
=0A[   82.353820] tty ttyO0: device_resume 577=0A[   82.353851] tty ttyO1: =
device_resume 577=0A[   82.353881] tty ttyO2: device_resume 577=0A[   82.35=
3912] tty ttyO3: device_resume 577=0A[   82.353942] bdi 1:0: device_resume =
577=0A[   82.353973] block ram0: device_resume 577=0A[   82.354003] bdi 1:1=
: device_resume 577=0A[   82.354064] block ram1: device_resume 577=0A[   82=
=2E354095] bdi 1:2: device_resume 577=0A[   82.354125] block ram2: device_r=
esume 577=0A[   82.354156] bdi 1:3: device_resume 577=0A[   82.354187] bloc=
k ram3: device_resume 577=0A[   82.354217] bdi 1:4: device_resume 577=0A[  =
 82.354248] block ram4: device_resume 577=0A[   82.354278] bdi 1:5: device_=
resume 577=0A[   82.354309] block ram5: device_resume 577=0A[   82.354370] =
bdi 1:6: device_resume 577=0A[   82.354400] block ram6: device_resume 577=
=0A[   82.354431] bdi 1:7: device_resume 577=0A[   82.354461] block ram7: d=
evice_resume 577=0A[   82.354492] bdi 1:8: device_resume 577=0A[   82.35452=
2] block ram8: device_resume 577=0A[   82.354553] bdi 1:9: device_resume 57=
7=0A[   82.354583] block ram9: device_resume 577=0A[   82.354614] bdi 1:10:=
 device_resume 577=0A[   82.354675] block ram10: device_resume 577=0A[   82=
=2E354705] bdi 1:11: device_resume 577=0A[   82.354736] block ram11: device=
_resume 577=0A[   82.354766] bdi 1:12: device_resume 577=0A[   82.354797] b=
lock ram12: device_resume 577=0A[   82.354827] bdi 1:13: device_resume 577=
=0A[   82.354858] block ram13: device_resume 577=0A[   82.354888] bdi 1:14:=
 device_resume 577=0A[   82.354919] block ram14: device_resume 577=0A[   82=
=2E354980] bdi 1:15: device_resume 577=0A[   82.355010] block ram15: device=
_resume 577=0A[   82.355041] misc loop-control: device_resume 577=0A[   82.=
355072] bdi 7:0: device_resume 577=0A[   82.355102] block loop0: device_res=
ume 577=0A[   82.355133] bdi 7:1: device_resume 577=0A[   82.355163] block =
loop1: device_resume 577=0A[   82.355194] bdi 7:2: device_resume 577=0A[   =
82.355255] block loop2: device_resume 577=0A[   82.355285] bdi 7:3: device_=
resume 577=0A[   82.355316] block loop3: device_resume 577=0A[   82.355346]=
 bdi 7:4: device_resume 577=0A[   82.355377] block loop4: device_resume 577=
=0A[   82.355407] bdi 7:5: device_resume 577=0A[   82.355438] block loop5: =
device_resume 577=0A[   82.355468] bdi 7:6: device_resume 577=0A[   82.3554=
99] block loop6: device_resume 577=0A[   82.355560] bdi 7:7: device_resume =
577=0A[   82.355590] block loop7: device_resume 577=0A[   82.355621] platfo=
rm twl4030-codec: device_resume 577=0A[   82.355651] bdi mtd-unmap: device_=
resume 577=0A[   82.355682] bdi mtd-romap: device_resume 577=0A[   82.35571=
2] bdi mtd-rwmap: device_resume 577=0A[   82.355743] spi_master spi1: devic=
e_resume 577=0A[   82.355773] spi_master spi2: device_resume 577=0A[   82.3=
55804] spi_master spi3: device_resume 577=0A[   82.355865] spi_master spi4:=
 device_resume 577=0A[   82.355895] usbmon usbmon0: device_resume 577=0A[  =
 82.355926] input mice: device_resume 577=0A[   82.355957] misc psaux: devi=
ce_resume 577=0A[   82.355987] input input0: device_resume 577=0A[   82.356=
109] input event0: device_resume 577=0A[   82.356140] rtc rtc0: device_resu=
me 577=0A[   82.356201] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=
=0A[   82.356231] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[   8=
2.356231] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   82.356292] omap_i2c =
omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[   82.356292] omap=
_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   82.356323] omap_i2c omap_i2c.1=
: omap_i2c_isr 880=0A[   82.356353] omap_i2c omap_i2c.1: omap_i2c_isr 886: =
mask 601f stat 1510=0A[   82.356384] omap_i2c omap_i2c.1: omap_i2c_isr 889=
=0A[   82.356384] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   82.356414] =
=3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   82.356475] o=
map_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   82.356506] omap_i2c omap_=
i2c.1: IRQ (ISR =3D 0x0010)=0A[   82.356536] omap_i2c omap_i2c.1: omap_i2c_=
isr_thread 1033=0A[   82.356567] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ =
  82.356567] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[=
   82.356597] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   82.356597] omap_i=
2c omap_i2c.1: omap_i2c_isr 894=0A[   82.356628] =3D=3D=3D> irq_wake_thread=
 139: IRQ 72 wake_up_process 0=0A[   82.356658] omap_i2c omap_i2c.1: omap_i=
2c_isr_thread 908=0A[   82.356658] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004=
)=0A[   82.356689] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   82.3=
56842] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[  =
 82.356842] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[   82.356903] oma=
p_i2c omap_i2c.1: omap_i2c_isr 880=0A[   82.356933] omap_i2c omap_i2c.1: om=
ap_i2c_isr 886: mask 601f stat 0108=0A[   82.356933] omap_i2c omap_i2c.1: o=
map_i2c_isr 889=0A[   82.356964] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ =
  82.356994] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  =
 82.357025] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   82.357055] o=
map_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[   82.357055] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[   82.357086] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[   82.357147] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ =
  82.357177] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[   82.357=
208] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[   82.357238] omap_i2c omap_=
i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[   82.357269] omap_i2c =
omap_i2c.1: omap_i2c_xfer_msg 537=0A[   82.357269] omap_i2c omap_i2c.1: oma=
p_i2c_isr 880=0A[   82.357299] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask =
601f stat 1110=0A[   82.357330] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  =
 82.357330] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   82.357360] =3D=3D=
=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[   82.357391] omap_i2=
c omap_i2c.1: omap_i2c_isr_thread 908=0A[   82.357421] omap_i2c omap_i2c.1:=
 IRQ (ISR =3D 0x0010)=0A[   82.357452] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 1033=0A[   82.357482] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   82.3=
57482] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[   82.=
357513] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   82.357513] omap_i2c oma=
p_i2c.1: omap_i2c_isr 894=0A[   82.357543] =3D=3D=3D> irq_wake_thread 139: =
IRQ 72 wake_up_process 0=0A[   82.357543] omap_i2c omap_i2c.1: omap_i2c_isr=
_thread 908=0A[   82.357574] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ =
  82.357604] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   82.357666]=
 omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[   82.357696] i2c i2c-1: master_=
xfer[0] W, addr=3D0x4b, len=3D1=0A[   82.357696] i2c i2c-1: master_xfer[1] =
R, addr=3D0x4b, len=3D6=0A[   82.357727] omap_i2c omap_i2c.1: omap_i2c_xfer=
 626=0A[   82.357757] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0=
, stop: 0=0A[   82.357788] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  =
 82.357818] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   82.357818] omap_i2c=
 omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[   82.357849] omap_i2=
c omap_i2c.1: omap_i2c_isr 889=0A[   82.357849] omap_i2c omap_i2c.1: omap_i=
2c_isr 894=0A[   82.357879] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_=
process 1=0A[   82.357910] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[=
   82.357940] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[   82.357971] om=
ap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   82.358001] omap_i2c omap_=
i2c.1: omap_i2c_isr 880=0A[   82.358001] omap_i2c omap_i2c.1: omap_i2c_isr =
886: mask 601f stat 1104=0A[   82.358032] omap_i2c omap_i2c.1: omap_i2c_isr=
 889=0A[   82.358032] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   82.358062=
] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   82.358093]=
 omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   82.358093] omap_i2c oma=
p_i2c.1: IRQ (ISR =3D 0x0004)=0A[   82.358123] omap_i2c omap_i2c.1: omap_i2=
c_isr_thread 1033=0A[   82.358184] omap_i2c omap_i2c.1: addr: 0x004b, len: =
6, flags: 0x1, stop: 1=0A[   82.358184] omap_i2c omap_i2c.1: omap_i2c_xfer_=
msg 537=0A[   82.358337] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[   82.358=
367] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1108=0A[   82.35=
8367] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[   82.358398] omap_i2c omap_=
i2c.1: omap_i2c_isr 894=0A[   82.358428] =3D=3D=3D> irq_wake_thread 139: IR=
Q 72 wake_up_process 1=0A[   82.358459] omap_i2c omap_i2c.1: omap_i2c_isr_t=
hread 908=0A[   82.358489] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[   =
82.358520] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x2000)=0A[   82.358551] omap_=
i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[   82.358581] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 880=0A[   82.358581] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 0104=0A[   82.358612] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[   82.358612] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[   82.358642]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[   82.358673] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[   82.358673] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0004)=0A[   82.358703] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 1033=0A[   82.358764] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A=
[   82.358795] i2c-dev i2c-1: device_resume 577=0A[   82.358856] i2c-dev i2=
c-3: device_resume 577=0A[   82.358886] misc watchdog: device_resume 577=0A=
[   82.358917] mmc_host mmc0: device_resume 577=0A[   82.358947] oprofile-p=
erf oprofile-perf.0: device_resume 577=0A[   82.358978] misc cpu_dma_latenc=
y: device_resume 577=0A[   82.359039] misc network_latency: device_resume 5=
77=0A[   82.359069] misc network_throughput: device_resume 577=0A[   82.359=
100] misc ubi_ctrl: device_resume 577=0A[   82.359130] input input1: device=
_resume 577=0A[   82.359161] input event1: device_resume 577=0A[   82.35919=
1] mmcblk mmc0:0002: device_resume 577=0A[   82.359283] bdi 179:0: device_r=
esume 577=0A[   82.359313] block mmcblk0: device_resume 577=0A[   82.359344=
] block mmcblk0p1: device_resume 577=0A[   82.359374] block mmcblk0p2: devi=
ce_resume 577=0A[   82.359405] vc vcs3: device_resume 577=0A[   82.359436] =
vc vcsa3: device_resume 577=0A[   82.359497] vc vcs2: device_resume 577=0A[=
   82.359527] vc vcsa2: device_resume 577=0A[   82.359558] vc vcs5: device_=
resume 577=0A[   82.359588] vc vcsa5: device_resume 577=0A[   82.359619] vc=
 vcs4: device_resume 577=0A[   82.359649] vc vcsa4: device_resume 577=0A[  =
 82.359680] vc vcs6: device_resume 577=0A[   82.359710] vc vcsa6: device_re=
sume 577=0A[   82.359741] vc vcs63: device_resume 577=0A[   82.359802] vc v=
csa63: device_resume 577=0A[   82.359832] PM: resume of devices complete af=
ter 1355.194 msecs=0A[   82.365539] PM: Finishing wakeup.=0A[   82.365570] =
Restarting tasks ... done.=0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~=
# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aro=
ot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwe=
n:~# dmesg=08=08=08=08=08ls=08=08echo mem > /sys/power/state =0A=0A-bash: e=
cho: write error: Operation not permitted=0Aroot@arwen:~# =0Aroot@arwen:~# =
dmesg=0A[  155.937225] platform omap-mcbsp.4: device_resume 577=0A[  155.93=
7255] platform omap-mcbsp.5: device_resume 577=0A[  155.937316] platform om=
apfb: device_resume 577=0A[  155.937347] cpu cpu0: device_resume 577=0A[  1=
55.937377] omap_wdt omap_wdt: device_resume 577=0A[  155.937408] arm-pmu ar=
m-pmu: device_resume 577=0A[  155.937438] bdi default: device_resume 577=0A=
[  155.937469] omap-dma-engine omap-dma-engine: device_resume 577=0A[  155.=
937499] dma dma0chan0: device_resume 577=0A[  155.937530] dma dma0chan1: de=
vice_resume 577=0A[  155.937591] dma dma0chan2: device_resume 577=0A[  155.=
937622] dma dma0chan3: device_resume 577=0A[  155.937683] dma dma0chan4: de=
vice_resume 577=0A[  155.937713] dma dma0chan5: device_resume 577=0A[  155.=
937744] dma dma0chan6: device_resume 577=0A[  155.937866] dma dma0chan7: de=
vice_resume 577=0A[  155.937896] dma dma0chan8: device_resume 577=0A[  155.=
937927] dma dma0chan9: device_resume 577=0A[  155.937957] dma dma0chan10: d=
evice_resume 577=0A[  155.937988] dma dma0chan11: device_resume 577=0A[  15=
5.938049] dma dma0chan12: device_resume 577=0A[  155.938079] dma dma0chan13=
: device_resume 577=0A[  155.938110] dma dma0chan14: device_resume 577=0A[ =
 155.938140] dma dma0chan15: device_resume 577=0A[  155.938171] dma dma0cha=
n16: device_resume 577=0A[  155.938201] dma dma0chan17: device_resume 577=
=0A[  155.938232] dma dma0chan18: device_resume 577=0A[  155.938262] dma dm=
a0chan19: device_resume 577=0A[  155.938293] dma dma0chan20: device_resume =
577=0A[  155.938323] dma dma0chan21: device_resume 577=0A[  155.938354] dma=
 dma0chan22: device_resume 577=0A[  155.938415] dma dma0chan23: device_resu=
me 577=0A[  155.938446] dma dma0chan24: device_resume 577=0A[  155.938476] =
dma dma0chan25: device_resume 577=0A[  155.938507] dma dma0chan26: device_r=
esume 577=0A[  155.938537] dma dma0chan27: device_resume 577=0A[  155.93856=
8] dma dma0chan28: device_resume 577=0A[  155.938598] dma dma0chan29: devic=
e_resume 577=0A[  155.938629] dma dma0chan30: device_resume 577=0A[  155.93=
8659] dma dma0chan31: device_resume 577=0A[  155.938690] dma dma0chan32: de=
vice_resume 577=0A[  155.938720] dma dma0chan33: device_resume 577=0A[  155=
=2E938751] dma dma0chan34: device_resume 577=0A[  155.938812] dma dma0chan3=
5: device_resume 577=0A[  155.938842] dma dma0chan36: device_resume 577=0A[=
  155.938873] dma dma0chan37: device_resume 577=0A[  155.938903] dma dma0ch=
an38: device_resume 577=0A[  155.938934] dma dma0chan39: device_resume 577=
=0A[  155.938964] dma dma0chan40: device_resume 577=0A[  155.938995] dma dm=
a0chan41: device_resume 577=0A[  155.939025] dma dma0chan42: device_resume =
577=0A[  155.939056] dma dma0chan43: device_resume 577=0A[  155.939086] dma=
 dma0chan44: device_resume 577=0A[  155.939147] dma dma0chan45: device_resu=
me 577=0A[  155.939178] dma dma0chan46: device_resume 577=0A[  155.939208] =
dma dma0chan47: device_resume 577=0A[  155.939239] dma dma0chan48: device_r=
esume 577=0A[  155.939270] dma dma0chan49: device_resume 577=0A[  155.93930=
0] dma dma0chan50: device_resume 577=0A[  155.939331] dma dma0chan51: devic=
e_resume 577=0A[  155.939361] dma dma0chan52: device_resume 577=0A[  155.93=
9392] dma dma0chan53: device_resume 577=0A[  155.939422] dma dma0chan54: de=
vice_resume 577=0A[  155.939453] dma dma0chan55: device_resume 577=0A[  155=
=2E939514] dma dma0chan56: device_resume 577=0A[  155.939544] dma dma0chan5=
7: device_resume 577=0A[  155.939575] dma dma0chan58: device_resume 577=0A[=
  155.939605] dma dma0chan59: device_resume 577=0A[  155.939636] dma dma0ch=
an60: device_resume 577=0A[  155.939666] dma dma0chan61: device_resume 577=
=0A[  155.939697] dma dma0chan62: device_resume 577=0A[  155.939727] dma dm=
a0chan63: device_resume 577=0A[  155.939758] dma dma0chan64: device_resume =
577=0A[  155.939788] dma dma0chan65: device_resume 577=0A[  155.939849] dma=
 dma0chan66: device_resume 577=0A[  155.939880] dma dma0chan67: device_resu=
me 577=0A[  155.939910] dma dma0chan68: device_resume 577=0A[  155.939941] =
dma dma0chan69: device_resume 577=0A[  155.939971] dma dma0chan70: device_r=
esume 577=0A[  155.940002] dma dma0chan71: device_resume 577=0A[  155.94003=
2] dma dma0chan72: device_resume 577=0A[  155.940063] dma dma0chan73: devic=
e_resume 577=0A[  155.940093] dma dma0chan74: device_resume 577=0A[  155.94=
0124] dma dma0chan75: device_resume 577=0A[  155.940155] dma dma0chan76: de=
vice_resume 577=0A[  155.940216] dma dma0chan77: device_resume 577=0A[  155=
=2E940246] dma dma0chan78: device_resume 577=0A[  155.940277] dma dma0chan7=
9: device_resume 577=0A[  155.940307] dma dma0chan80: device_resume 577=0A[=
  155.940338] dma dma0chan81: device_resume 577=0A[  155.940368] dma dma0ch=
an82: device_resume 577=0A[  155.940399] dma dma0chan83: device_resume 577=
=0A[  155.940429] dma dma0chan84: device_resume 577=0A[  155.940460] dma dm=
a0chan85: device_resume 577=0A[  155.940490] dma dma0chan86: device_resume =
577=0A[  155.940521] dma dma0chan87: device_resume 577=0A[  155.940582] dma=
 dma0chan88: device_resume 577=0A[  155.940612] dma dma0chan89: device_resu=
me 577=0A[  155.940643] dma dma0chan90: device_resume 577=0A[  155.940673] =
dma dma0chan91: device_resume 577=0A[  155.940704] dma dma0chan92: device_r=
esume 577=0A[  155.940734] dma dma0chan93: device_resume 577=0A[  155.94076=
5] dma dma0chan94: device_resume 577=0A[  155.940795] dma dma0chan95: devic=
e_resume 577=0A[  155.940826] dma dma0chan96: device_resume 577=0A[  155.94=
0856] dma dma0chan97: device_resume 577=0A[  155.940887] dma dma0chan98: de=
vice_resume 577=0A[  155.940948] dma dma0chan99: device_resume 577=0A[  155=
=2E940979] dma dma0chan100: device_resume 577=0A[  155.941009] dma dma0chan=
101: device_resume 577=0A[  155.941040] dma dma0chan102: device_resume 577=
=0A[  155.941070] dma dma0chan103: device_resume 577=0A[  155.941101] dma d=
ma0chan104: device_resume 577=0A[  155.941131] dma dma0chan105: device_resu=
me 577=0A[  155.941162] dma dma0chan106: device_resume 577=0A[  155.941192]=
 dma dma0chan107: device_resume 577=0A[  155.941223] dma dma0chan108: devic=
e_resume 577=0A[  155.941284] dma dma0chan109: device_resume 577=0A[  155.9=
41314] dma dma0chan110: device_resume 577=0A[  155.941345] dma dma0chan111:=
 device_resume 577=0A[  155.941375] dma dma0chan112: device_resume 577=0A[ =
 155.941406] dma dma0chan113: device_resume 577=0A[  155.941436] dma dma0ch=
an114: device_resume 577=0A[  155.941467] dma dma0chan115: device_resume 57=
7=0A[  155.941497] dma dma0chan116: device_resume 577=0A[  155.941528] dma =
dma0chan117: device_resume 577=0A[  155.941558] dma dma0chan118: device_res=
ume 577=0A[  155.941619] dma dma0chan119: device_resume 577=0A[  155.941650=
] dma dma0chan120: device_resume 577=0A[  155.941680] dma dma0chan121: devi=
ce_resume 577=0A[  155.941711] dma dma0chan122: device_resume 577=0A[  155.=
941741] dma dma0chan123: device_resume 577=0A[  155.941772] dma dma0chan124=
: device_resume 577=0A[  155.941802] dma dma0chan125: device_resume 577=0A[=
  155.941833] dma dma0chan126: device_resume 577=0A[  155.941864] i2c i2c-1=
: device_resume 577=0A[  155.941925] twl 1-0048: device_resume 577=0A[  155=
=2E941955] platform twl: device_resume 577=0A[  155.941986] dummy 1-0049: d=
evice_resume 577=0A[  155.942016] dummy 1-004a: device_resume 577=0A[  155.=
942047] dummy 1-004b: device_resume 577=0A[  155.942077] twl4030_gpio twl40=
30_gpio: device_resume 577=0A[  155.942108] gpio gpiochip492: device_resume=
 577=0A[  155.942169] omap_hsmmc omap_hsmmc.0: device_resume 577=0A[  155.9=
42169] omap_hsmmc omap_hsmmc.0: _od_resume 884=0A[  155.942474] i2c i2c-1: =
master_xfer[0] W, addr=3D0x49, len=3D4=0A[  155.942504] omap_i2c omap_i2c.1=
: omap_i2c_xfer 626=0A[  155.942535] omap_i2c omap_i2c.1: addr: 0x0049, len=
: 4, flags: 0x0, stop: 1=0A[  155.942565] omap_i2c omap_i2c.1: omap_i2c_xfe=
r_msg 537=0A[  155.942596] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  155.9=
42626] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1510=0A[  155.=
942626] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  155.942657] omap_i2c oma=
p_i2c.1: omap_i2c_isr 894=0A[  155.942687] =3D=3D=3D> irq_wake_thread 139: =
IRQ 72 wake_up_process 1=0A[  155.942779] omap_i2c omap_i2c.1: omap_i2c_isr=
_thread 908=0A[  155.942779] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[ =
 155.942810] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  155.942840]=
 omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  155.942871] omap_i2c omap_i2c.1=
: omap_i2c_isr 886: mask 601f stat 0104=0A[  155.942871] omap_i2c omap_i2c.=
1: omap_i2c_isr 889=0A[  155.942901] omap_i2c omap_i2c.1: omap_i2c_isr 894=
=0A[  155.942901] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=
=0A[  155.942932] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  155.942=
932] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  155.942993] omap_i2c om=
ap_i2c.1: omap_i2c_isr_thread 1033=0A[  155.943267] omap_i2c omap_i2c.1: om=
ap_i2c_xfer 663=0A[  155.943328] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, =
len=3D1=0A[  155.943359] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=
=0A[  155.943389] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  155.943420] o=
map_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  155.9434=
20] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  155.943450] omap_i2c om=
ap_i2c.1: omap_i2c_isr 880=0A[  155.943481] omap_i2c omap_i2c.1: omap_i2c_i=
sr 886: mask 601f stat 1110=0A[  155.943481] omap_i2c omap_i2c.1: omap_i2c_=
isr 889=0A[  155.943511] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  155.943=
542] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  155.9435=
72] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  155.943603] omap_i2c =
omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  155.943634] omap_i2c omap_i2c.1: omap=
_i2c_isr_thread 1033=0A[  155.943664] omap_i2c omap_i2c.1: omap_i2c_isr 880=
=0A[  155.943664] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 110=
4=0A[  155.943695] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  155.943695] o=
map_i2c omap_i2c.1: omap_i2c_isr 894=0A[  155.943725] =3D=3D=3D> irq_wake_t=
hread 139: IRQ 72 wake_up_process 0=0A[  155.943756] omap_i2c omap_i2c.1: o=
map_i2c_isr_thread 908=0A[  155.943756] omap_i2c omap_i2c.1: IRQ (ISR =3D 0=
x0004)=0A[  155.943786] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  =
155.943847] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=
=0A[  155.943878] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  155.94393=
9] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  155.943939] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 886: mask 601f stat 0108=0A[  155.943969] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[  155.943969] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[  155.944000] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[  155.944030] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  155.9=
44061] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  155.944061] omap_i2c =
omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  155.944091] omap_i2c omap_i2c.1: omap=
_i2c_isr_thread 1033=0A[  155.944152] omap_i2c omap_i2c.1: omap_i2c_xfer 66=
3=0A[  155.944183] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  1=
55.944213] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[  155.94424=
4] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  155.944274] omap_i2c omap_i2=
c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  155.944274] omap_i2c om=
ap_i2c.1: omap_i2c_xfer_msg 537=0A[  155.944305] omap_i2c omap_i2c.1: omap_=
i2c_isr 880=0A[  155.944335] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 60=
1f stat 1110=0A[  155.944335] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  15=
5.944366] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  155.944396] =3D=3D=3D>=
 irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  155.944427] omap_i2c om=
ap_i2c.1: omap_i2c_isr_thread 908=0A[  155.944458] omap_i2c omap_i2c.1: IRQ=
 (ISR =3D 0x0010)=0A[  155.944488] omap_i2c omap_i2c.1: omap_i2c_isr_thread=
 1033=0A[  155.944519] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  155.94454=
9] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  155.9445=
49] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  155.944580] omap_i2c omap_i2=
c.1: omap_i2c_isr 894=0A[  155.944610] =3D=3D=3D> irq_wake_thread 139: IRQ =
72 wake_up_process 0=0A[  155.944610] omap_i2c omap_i2c.1: omap_i2c_isr_thr=
ead 908=0A[  155.944641] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  155=
=2E944671] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  155.944732] o=
map_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[  155.9447=
32] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  155.944793] omap_i2c om=
ap_i2c.1: omap_i2c_isr 880=0A[  155.944793] omap_i2c omap_i2c.1: omap_i2c_i=
sr 886: mask 601f stat 0108=0A[  155.944824] omap_i2c omap_i2c.1: omap_i2c_=
isr 889=0A[  155.944854] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  155.944=
854] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  155.9448=
85] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  155.944915] omap_i2c =
omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  155.944946] omap_i2c omap_i2c.1: IRQ =
(ISR =3D 0x0004)=0A[  155.944946] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
1033=0A[  155.945007] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  155.94503=
7] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  155.945068] i2c i=
2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[  155.945098] omap_i2c omap=
_i2c.1: omap_i2c_xfer 626=0A[  155.945129] omap_i2c omap_i2c.1: addr: 0x004=
b, len: 1, flags: 0x0, stop: 0=0A[  155.945129] omap_i2c omap_i2c.1: omap_i=
2c_xfer_msg 537=0A[  155.945159] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ =
 155.945190] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[=
  155.945190] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  155.945220] omap_i=
2c omap_i2c.1: omap_i2c_isr 894=0A[  155.945251] =3D=3D=3D> irq_wake_thread=
 139: IRQ 72 wake_up_process 1=0A[  155.945281] omap_i2c omap_i2c.1: omap_i=
2c_isr_thread 908=0A[  155.945312] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010=
)=0A[  155.945312] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  155.9=
45343] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  155.945373] omap_i2c omap=
_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  155.945373] omap_i2c oma=
p_i2c.1: omap_i2c_isr 889=0A[  155.945404] omap_i2c omap_i2c.1: omap_i2c_is=
r 894=0A[  155.945404] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proce=
ss 0=0A[  155.945465] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  155=
=2E945465] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  155.945495] omap_=
i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  155.945556] omap_i2c omap_i2c=
=2E1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[  155.945587] omap_i2c o=
map_i2c.1: omap_i2c_xfer_msg 537=0A[  155.945678] omap_i2c omap_i2c.1: omap=
_i2c_isr 880=0A[  155.945800] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 6=
01f stat 0108=0A[  155.945831] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  1=
55.945831] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  155.945861] =3D=3D=3D=
> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  155.945922] omap_i2c o=
map_i2c.1: omap_i2c_isr_thread 908=0A[  155.945922] omap_i2c omap_i2c.1: IR=
Q (ISR =3D 0x0008)=0A[  155.945953] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x000=
4)=0A[  155.945983] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  155.=
946044] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  155.946075] i2c i2c-1: =
master_xfer[0] W, addr=3D0x4b, len=3D2=0A[  155.946105] omap_i2c omap_i2c.1=
: omap_i2c_xfer 626=0A[  155.946136] omap_i2c omap_i2c.1: addr: 0x004b, len=
: 2, flags: 0x0, stop: 1=0A[  155.946136] omap_i2c omap_i2c.1: omap_i2c_xfe=
r_msg 537=0A[  155.946166] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  155.9=
46197] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  155.=
946197] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  155.946228] omap_i2c oma=
p_i2c.1: omap_i2c_isr 894=0A[  155.946258] =3D=3D=3D> irq_wake_thread 139: =
IRQ 72 wake_up_process 1=0A[  155.946289] omap_i2c omap_i2c.1: omap_i2c_isr=
_thread 908=0A[  155.946319] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[ =
 155.946319] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  155.946350]=
 omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  155.946380] omap_i2c omap_i2c.1=
: omap_i2c_isr 886: mask 601f stat 0104=0A[  155.946411] omap_i2c omap_i2c.=
1: omap_i2c_isr 889=0A[  155.946411] omap_i2c omap_i2c.1: omap_i2c_isr 894=
=0A[  155.946441] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=
=0A[  155.946441] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  155.946=
472] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  155.946502] omap_i2c om=
ap_i2c.1: omap_i2c_isr_thread 1033=0A[  155.946563] omap_i2c omap_i2c.1: om=
ap_i2c_xfer 663=0A[  155.946685] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, =
len=3D1=0A[  155.946685] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=
=0A[  155.946716] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  155.946746] o=
map_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  155.9467=
77] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  155.946777] omap_i2c om=
ap_i2c.1: omap_i2c_isr 880=0A[  155.946807] omap_i2c omap_i2c.1: omap_i2c_i=
sr 886: mask 601f stat 1110=0A[  155.946838] omap_i2c omap_i2c.1: omap_i2c_=
isr 889=0A[  155.946838] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  155.946=
868] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  155.9468=
99] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  155.946929] omap_i2c =
omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  155.946960] omap_i2c omap_i2c.1: omap=
_i2c_isr_thread 1033=0A[  155.946960] omap_i2c omap_i2c.1: omap_i2c_isr 880=
=0A[  155.946990] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 110=
4=0A[  155.947021] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  155.947021] o=
map_i2c omap_i2c.1: omap_i2c_isr 894=0A[  155.947052] =3D=3D=3D> irq_wake_t=
hread 139: IRQ 72 wake_up_process 0=0A[  155.947052] omap_i2c omap_i2c.1: o=
map_i2c_isr_thread 908=0A[  155.947082] omap_i2c omap_i2c.1: IRQ (ISR =3D 0=
x0004)=0A[  155.947113] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  =
155.947174] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=
=0A[  155.947174] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  155.94723=
5] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  155.947265] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 886: mask 601f stat 0108=0A[  155.947265] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[  155.947296] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[  155.947296] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[  155.947326] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  155.9=
47357] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  155.947387] omap_i2c =
omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  155.947418] omap_i2c omap_i2c.1: omap=
_i2c_isr_thread 1033=0A[  155.947448] omap_i2c omap_i2c.1: omap_i2c_xfer 66=
3=0A[  155.947479] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  1=
55.947509] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[  155.94754=
0] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  155.947570] omap_i2c omap_i2=
c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  155.947570] omap_i2c om=
ap_i2c.1: omap_i2c_xfer_msg 537=0A[  155.947601] omap_i2c omap_i2c.1: omap_=
i2c_isr 880=0A[  155.947631] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 60=
1f stat 1110=0A[  155.947631] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  15=
5.947662] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  155.947692] =3D=3D=3D>=
 irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  155.947723] omap_i2c om=
ap_i2c.1: omap_i2c_isr_thread 908=0A[  155.947753] omap_i2c omap_i2c.1: IRQ=
 (ISR =3D 0x0010)=0A[  155.947753] omap_i2c omap_i2c.1: omap_i2c_isr_thread=
 1033=0A[  155.947784] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  155.94781=
4] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  155.9478=
14] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  155.947845] omap_i2c omap_i2=
c.1: omap_i2c_isr 894=0A[  155.947845] =3D=3D=3D> irq_wake_thread 139: IRQ =
72 wake_up_process 0=0A[  155.947875] omap_i2c omap_i2c.1: omap_i2c_isr_thr=
ead 908=0A[  155.947906] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  155=
=2E947937] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  155.947967] o=
map_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[  155.9479=
98] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  155.948059] omap_i2c om=
ap_i2c.1: omap_i2c_isr 880=0A[  155.948059] omap_i2c omap_i2c.1: omap_i2c_i=
sr 886: mask 601f stat 0108=0A[  155.948089] omap_i2c omap_i2c.1: omap_i2c_=
isr 889=0A[  155.948089] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  155.948=
120] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  155.9481=
50] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  155.948181] omap_i2c =
omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  155.948181] omap_i2c omap_i2c.1: IRQ =
(ISR =3D 0x0004)=0A[  155.948211] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
1033=0A[  155.948272] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  155.94830=
3] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[  155.948333] omap_=
i2c omap_i2c.1: omap_i2c_xfer 626=0A[  155.948364] omap_i2c omap_i2c.1: add=
r: 0x004b, len: 2, flags: 0x0, stop: 1=0A[  155.948364] omap_i2c omap_i2c.1=
: omap_i2c_xfer_msg 537=0A[  155.948394] omap_i2c omap_i2c.1: omap_i2c_isr =
880=0A[  155.948425] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat =
1110=0A[  155.948425] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  155.948455=
] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  155.948455] =3D=3D=3D> irq_wak=
e_thread 139: IRQ 72 wake_up_process 1=0A[  155.948516] omap_i2c omap_i2c.1=
: omap_i2c_isr_thread 908=0A[  155.948516] omap_i2c omap_i2c.1: IRQ (ISR =
=3D 0x0010)=0A[  155.948547] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[  155.948577] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  155.948608] om=
ap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[  155.948608] o=
map_i2c omap_i2c.1: omap_i2c_isr 889=0A[  155.948638] omap_i2c omap_i2c.1: =
omap_i2c_isr 894=0A[  155.948638] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wa=
ke_up_process 0=0A[  155.948669] omap_i2c omap_i2c.1: omap_i2c_isr_thread 9=
08=0A[  155.948669] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  155.9486=
99] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  155.948760] omap_i2c=
 omap_i2c.1: omap_i2c_xfer 663=0A[  157.277618] twl_rtc twl_rtc: device_res=
ume 577=0A[  157.277648] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=
=0A[  157.277679] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  157.277709] o=
map_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[  157.2777=
40] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  157.277770] omap_i2c om=
ap_i2c.1: omap_i2c_isr 880=0A[  157.277770] omap_i2c omap_i2c.1: omap_i2c_i=
sr 886: mask 601f stat 1110=0A[  157.277801] omap_i2c omap_i2c.1: omap_i2c_=
isr 889=0A[  157.277801] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  157.277=
862] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  157.2778=
93] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  157.277923] omap_i2c =
omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  157.277954] omap_i2c omap_i2c.1: omap=
_i2c_isr_thread 1033=0A[  157.277984] omap_i2c omap_i2c.1: omap_i2c_isr 880=
=0A[  157.277984] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 010=
4=0A[  157.278015] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  157.278015] o=
map_i2c omap_i2c.1: omap_i2c_isr 894=0A[  157.278045] =3D=3D=3D> irq_wake_t=
hread 139: IRQ 72 wake_up_process 0=0A[  157.278076] omap_i2c omap_i2c.1: o=
map_i2c_isr_thread 908=0A[  157.278076] omap_i2c omap_i2c.1: IRQ (ISR =3D 0=
x0004)=0A[  157.278106] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  =
157.278167] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  157.278198] platfor=
m twl4030_wdt: device_resume 577=0A[  157.278259] twl4030_pwrbutton twl4030=
_pwrbutton: device_resume 577=0A[  157.278289] twl4030-audio twl4030-audio:=
 device_resume 577=0A[  157.278320] twl_reg twl_reg.0: device_resume 577=0A=
[  157.278350] regulator regulator.1: device_resume 577=0A[  157.278381] tw=
l_reg twl_reg.1: device_resume 577=0A[  157.278411] regulator regulator.2: =
device_resume 577=0A[  157.278472] twl_reg twl_reg.6: device_resume 577=0A[=
  157.278503] regulator regulator.3: device_resume 577=0A[  157.278533] twl=
_reg twl_reg.3: device_resume 577=0A[  157.278564] regulator regulator.4: d=
evice_resume 577=0A[  157.278594] twl_reg twl_reg.5: device_resume 577=0A[ =
 157.278625] regulator regulator.5: device_resume 577=0A[  157.278656] twl_=
reg twl_reg.8: device_resume 577=0A[  157.278686] regulator regulator.6: de=
vice_resume 577=0A[  157.278747] i2c i2c-3: device_resume 577=0A[  157.2787=
78] i2c 3-0050: device_resume 577=0A[  157.278808] net lo: device_resume 57=
7=0A[  157.278839] mem mem: device_resume 577=0A[  157.278869] mem kmem: de=
vice_resume 577=0A[  157.278900] mem null: device_resume 577=0A[  157.27893=
0] mem zero: device_resume 577=0A[  157.278991] mem full: device_resume 577=
=0A[  157.279022] mem random: device_resume 577=0A[  157.279052] mem urando=
m: device_resume 577=0A[  157.279083] mem kmsg: device_resume 577=0A[  157.=
279113] tty tty: device_resume 577=0A[  157.279144] tty console: device_res=
ume 577=0A[  157.279174] tty tty0: device_resume 577=0A[  157.279205] vc vc=
s: device_resume 577=0A[  157.279266] vc vcsa: device_resume 577=0A[  157.2=
79296] vc vcs1: device_resume 577=0A[  157.279327] vc vcsa1: device_resume =
577=0A[  157.279357] tty tty1: device_resume 577=0A[  157.279388] tty tty2:=
 device_resume 577=0A[  157.279418] tty tty3: device_resume 577=0A[  157.27=
9449] tty tty4: device_resume 577=0A[  157.279479] tty tty5: device_resume =
577=0A[  157.279510] tty tty6: device_resume 577=0A[  157.279571] tty tty7:=
 device_resume 577=0A[  157.279602] tty tty8: device_resume 577=0A[  157.27=
9632] tty tty9: device_resume 577=0A[  157.279663] tty tty10: device_resume=
 577=0A[  157.279693] tty tty11: device_resume 577=0A[  157.279724] tty tty=
12: device_resume 577=0A[  157.279754] tty tty13: device_resume 577=0A[  15=
7.279785] tty tty14: device_resume 577=0A[  157.279846] tty tty15: device_r=
esume 577=0A[  157.279876] tty tty16: device_resume 577=0A[  157.279907] tt=
y tty17: device_resume 577=0A[  157.279937] tty tty18: device_resume 577=0A=
[  157.279968] tty tty19: device_resume 577=0A[  157.279998] tty tty20: dev=
ice_resume 577=0A[  157.280029] tty tty21: device_resume 577=0A[  157.28005=
9] tty tty22: device_resume 577=0A[  157.280090] tty tty23: device_resume 5=
77=0A[  157.280151] tty tty24: device_resume 577=0A[  157.280181] tty tty25=
: device_resume 577=0A[  157.280212] tty tty26: device_resume 577=0A[  157.=
280242] tty tty27: device_resume 577=0A[  157.280273] tty tty28: device_res=
ume 577=0A[  157.280303] tty tty29: device_resume 577=0A[  157.280334] tty =
tty30: device_resume 577=0A[  157.280364] tty tty31: device_resume 577=0A[ =
 157.280426] tty tty32: device_resume 577=0A[  157.280456] tty tty33: devic=
e_resume 577=0A[  157.280487] tty tty34: device_resume 577=0A[  157.280517]=
 tty tty35: device_resume 577=0A[  157.280548] tty tty36: device_resume 577=
=0A[  157.280578] tty tty37: device_resume 577=0A[  157.280609] tty tty38: =
device_resume 577=0A[  157.280639] tty tty39: device_resume 577=0A[  157.28=
0700] tty tty40: device_resume 577=0A[  157.280731] tty tty41: device_resum=
e 577=0A[  157.280761] tty tty42: device_resume 577=0A[  157.280792] tty tt=
y43: device_resume 577=0A[  157.280822] tty tty44: device_resume 577=0A[  1=
57.280853] tty tty45: device_resume 577=0A[  157.280914] tty tty46: device_=
resume 577=0A[  157.280975] tty tty47: device_resume 577=0A[  157.281005] t=
ty tty48: device_resume 577=0A[  157.281036] tty tty49: device_resume 577=
=0A[  157.281066] tty tty50: device_resume 577=0A[  157.281097] tty tty51: =
device_resume 577=0A[  157.281127] tty tty52: device_resume 577=0A[  157.28=
1158] tty tty53: device_resume 577=0A[  157.281219] tty tty54: device_resum=
e 577=0A[  157.281249] tty tty55: device_resume 577=0A[  157.281280] tty tt=
y56: device_resume 577=0A[  157.281311] tty tty57: device_resume 577=0A[  1=
57.281341] tty tty58: device_resume 577=0A[  157.281372] tty tty59: device_=
resume 577=0A[  157.281494] tty tty60: device_resume 577=0A[  157.281524] t=
ty tty61: device_resume 577=0A[  157.281555] tty tty62: device_resume 577=
=0A[  157.281585] tty tty63: device_resume 577=0A[  157.281616]  clocksourc=
e: device_resume 577=0A[  157.281677] clocksource clocksource0: device_resu=
me 577=0A[  157.281707] alarmtimer alarmtimer: device_resume 577=0A[  157.2=
81738] event_source ARMv7 Cortex-A8: device_resume 577=0A[  157.281768] eve=
nt_source breakpoint: device_resume 577=0A[  157.281799] event_source trace=
point: device_resume 577=0A[  157.281829] event_source software: device_res=
ume 577=0A[  157.281860] graphics fbcon: device_resume 577=0A[  157.281921]=
 tty ptmx: device_resume 577=0A[  157.281951] serial8250 serial8250: device=
_resume 577=0A[  157.281982] tty ttyS0: device_resume 577=0A[  157.282012] =
tty ttyS1: device_resume 577=0A[  157.282043] tty ttyS2: device_resume 577=
=0A[  157.282073] tty ttyS3: device_resume 577=0A[  157.282135] tty ttyO0: =
device_resume 577=0A[  157.282165] tty ttyO1: device_resume 577=0A[  157.28=
2196] tty ttyO2: device_resume 577=0A[  157.282226] tty ttyO3: device_resum=
e 577=0A[  157.282257] bdi 1:0: device_resume 577=0A[  157.282287] block ra=
m0: device_resume 577=0A[  157.282318] bdi 1:1: device_resume 577=0A[  157.=
282348] block ram1: device_resume 577=0A[  157.282409] bdi 1:2: device_resu=
me 577=0A[  157.282440] block ram2: device_resume 577=0A[  157.282470] bdi =
1:3: device_resume 577=0A[  157.282501] block ram3: device_resume 577=0A[  =
157.282531] bdi 1:4: device_resume 577=0A[  157.282562] block ram4: device_=
resume 577=0A[  157.282592] bdi 1:5: device_resume 577=0A[  157.282623] blo=
ck ram5: device_resume 577=0A[  157.282653] bdi 1:6: device_resume 577=0A[ =
 157.282714] block ram6: device_resume 577=0A[  157.282745] bdi 1:7: device=
_resume 577=0A[  157.282775] block ram7: device_resume 577=0A[  157.282806]=
 bdi 1:8: device_resume 577=0A[  157.282836] block ram8: device_resume 577=
=0A[  157.282867] bdi 1:9: device_resume 577=0A[  157.282897] block ram9: d=
evice_resume 577=0A[  157.282928] bdi 1:10: device_resume 577=0A[  157.2829=
58] block ram10: device_resume 577=0A[  157.283020] bdi 1:11: device_resume=
 577=0A[  157.283050] block ram11: device_resume 577=0A[  157.283081] bdi 1=
:12: device_resume 577=0A[  157.283111] block ram12: device_resume 577=0A[ =
 157.283142] bdi 1:13: device_resume 577=0A[  157.283172] block ram13: devi=
ce_resume 577=0A[  157.283203] bdi 1:14: device_resume 577=0A[  157.283233]=
 block ram14: device_resume 577=0A[  157.283264] bdi 1:15: device_resume 57=
7=0A[  157.283325] block ram15: device_resume 577=0A[  157.283355] misc loo=
p-control: device_resume 577=0A[  157.283386] bdi 7:0: device_resume 577=0A=
[  157.283416] block loop0: device_resume 577=0A[  157.283447] bdi 7:1: dev=
ice_resume 577=0A[  157.283477] block loop1: device_resume 577=0A[  157.283=
508] bdi 7:2: device_resume 577=0A[  157.283538] block loop2: device_resume=
 577=0A[  157.283599] bdi 7:3: device_resume 577=0A[  157.283630] block loo=
p3: device_resume 577=0A[  157.283660] bdi 7:4: device_resume 577=0A[  157.=
283691] block loop4: device_resume 577=0A[  157.283721] bdi 7:5: device_res=
ume 577=0A[  157.283752] block loop5: device_resume 577=0A[  157.283782] bd=
i 7:6: device_resume 577=0A[  157.283813] block loop6: device_resume 577=0A=
[  157.283843] bdi 7:7: device_resume 577=0A[  157.283905] block loop7: dev=
ice_resume 577=0A[  157.283935] platform twl4030-codec: device_resume 577=
=0A[  157.283966] bdi mtd-unmap: device_resume 577=0A[  157.283996] bdi mtd=
-romap: device_resume 577=0A[  157.284027] bdi mtd-rwmap: device_resume 577=
=0A[  157.284057] spi_master spi1: device_resume 577=0A[  157.284088] spi_m=
aster spi2: device_resume 577=0A[  157.284118] spi_master spi3: device_resu=
me 577=0A[  157.284179] spi_master spi4: device_resume 577=0A[  157.284210]=
 usbmon usbmon0: device_resume 577=0A[  157.284240] input mice: device_resu=
me 577=0A[  157.284271] misc psaux: device_resume 577=0A[  157.284301] inpu=
t input0: device_resume 577=0A[  157.284423] input event0: device_resume 57=
7=0A[  157.284454] rtc rtc0: device_resume 577=0A[  157.284515] i2c i2c-1: =
master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  157.284515] i2c i2c-1: master_x=
fer[1] R, addr=3D0x4b, len=3D1=0A[  157.284545] omap_i2c omap_i2c.1: omap_i=
2c_xfer 626=0A[  157.284576] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, fla=
gs: 0x0, stop: 0=0A[  157.284606] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 53=
7=0A[  157.284637] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  157.284667] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1510=0A[  157.284667] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  157.284698] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[  157.284729] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 1=0A[  157.284790] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[  157.284820] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  157.284=
820] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  157.284851] omap_i2=
c omap_i2c.1: omap_i2c_isr 880=0A[  157.284881] omap_i2c omap_i2c.1: omap_i=
2c_isr 886: mask 601f stat 1104=0A[  157.284912] omap_i2c omap_i2c.1: omap_=
i2c_isr 889=0A[  157.284912] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  157=
=2E284942] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  15=
7.284942] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  157.284973] oma=
p_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  157.285003] omap_i2c omap_i2c.1=
: omap_i2c_isr_thread 1033=0A[  157.285125] omap_i2c omap_i2c.1: addr: 0x00=
4b, len: 1, flags: 0x1, stop: 1=0A[  157.285156] omap_i2c omap_i2c.1: omap_=
i2c_xfer_msg 537=0A[  157.285217] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[=
  157.285247] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A=
[  157.285247] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  157.285278] omap_=
i2c omap_i2c.1: omap_i2c_isr 894=0A[  157.285308] =3D=3D=3D> irq_wake_threa=
d 139: IRQ 72 wake_up_process 1=0A[  157.285339] omap_i2c omap_i2c.1: omap_=
i2c_isr_thread 908=0A[  157.285339] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x000=
8)=0A[  157.285369] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  157.2854=
00] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  157.285461] omap_i2c=
 omap_i2c.1: omap_i2c_xfer 663=0A[  157.285491] i2c i2c-1: master_xfer[0] W=
, addr=3D0x4b, len=3D2=0A[  157.285522] omap_i2c omap_i2c.1: omap_i2c_xfer =
626=0A[  157.285552] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0,=
 stop: 1=0A[  157.285552] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  1=
57.285583] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  157.285614] omap_i2c =
omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  157.285614] omap_i2c=
 omap_i2c.1: omap_i2c_isr 889=0A[  157.285644] omap_i2c omap_i2c.1: omap_i2=
c_isr 894=0A[  157.285675] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_p=
rocess 1=0A[  157.285705] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ =
 157.285736] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  157.285736] oma=
p_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  157.285797] omap_i2c omap_i=
2c.1: omap_i2c_isr 880=0A[  157.285827] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 0104=0A[  157.285827] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[  157.285858] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  157.285858]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  157.285888] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  157.285919] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0004)=0A[  157.285949] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 1033=0A[  157.286010] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A=
[  157.286041] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  157.2=
86071] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D6=0A[  157.286071] o=
map_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  157.286102] omap_i2c omap_i2c.1:=
 addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  157.286132] omap_i2c omap_i=
2c.1: omap_i2c_xfer_msg 537=0A[  157.286163] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[  157.286163] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[  157.286193] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  157.28=
6193] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  157.286224] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[  157.286285] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[  157.286285] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[  157.286315] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[  157.286346] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  157.286346] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  157.286376] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  157.286376] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[  157.286407] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[  157.286407] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[  157.286437] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  157.286=
468] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  157.286529] omap_i2=
c omap_i2c.1: addr: 0x004b, len: 6, flags: 0x1, stop: 1=0A[  157.286529] om=
ap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  157.286682] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 880=0A[  157.286712] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 1108=0A[  157.286712] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[  157.286743] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  157.286773]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  157.286804] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  157.286834] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0008)=0A[  157.286834] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x2000)=0A[  157.286865] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[  157.286895] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  157.286926] om=
ap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[  157.286956] o=
map_i2c omap_i2c.1: omap_i2c_isr 889=0A[  157.286956] omap_i2c omap_i2c.1: =
omap_i2c_isr 894=0A[  157.286987] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wa=
ke_up_process 0=0A[  157.286987] omap_i2c omap_i2c.1: omap_i2c_isr_thread 9=
08=0A[  157.287017] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  157.2870=
48] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  157.287109] omap_i2c=
 omap_i2c.1: omap_i2c_xfer 663=0A[  157.287139] i2c-dev i2c-1: device_resum=
e 577=0A[  157.287170] i2c-dev i2c-3: device_resume 577=0A[  157.287231] mi=
sc watchdog: device_resume 577=0A[  157.287261] mmc_host mmc0: device_resum=
e 577=0A[  157.287292] oprofile-perf oprofile-perf.0: device_resume 577=0A[=
  157.287322] misc cpu_dma_latency: device_resume 577=0A[  157.287353] misc=
 network_latency: device_resume 577=0A[  157.287414] misc network_throughpu=
t: device_resume 577=0A[  157.287445] misc ubi_ctrl: device_resume 577=0A[ =
 157.287475] input input1: device_resume 577=0A[  157.287506] input event1:=
 device_resume 577=0A[  157.287536] mmcblk mmc0:0002: device_resume 577=0A[=
  157.287628] bdi 179:0: device_resume 577=0A[  157.287658] block mmcblk0: =
device_resume 577=0A[  157.287689] block mmcblk0p1: device_resume 577=0A[  =
157.287719] block mmcblk0p2: device_resume 577=0A[  157.287750] vc vcs3: de=
vice_resume 577=0A[  157.287780] vc vcsa3: device_resume 577=0A[  157.28784=
1] vc vcs2: device_resume 577=0A[  157.287872] vc vcsa2: device_resume 577=
=0A[  157.287902] vc vcs5: device_resume 577=0A[  157.287933] vc vcsa5: dev=
ice_resume 577=0A[  157.287963] vc vcs4: device_resume 577=0A[  157.287994]=
 vc vcsa4: device_resume 577=0A[  157.288024] vc vcs6: device_resume 577=0A=
[  157.288055] vc vcsa6: device_resume 577=0A[  157.288116] vc vcs63: devic=
e_resume 577=0A[  157.288146] vc vcsa63: device_resume 577=0A[  157.288177]=
 PM: resume of devices complete after 1354.858 msecs=0A[  157.293884] PM: F=
inishing wakeup.=0A[  157.293914] Restarting tasks ... done.=0Aroot@arwen:~=
# ls=0Aprepare  spidev_test=0Aroot@arwen:~# ls=08=08dmesg=08=08=08=08=08ech=
o mem > /sys/power/state =0A=0A-bash: echo: write error: Operation not perm=
itted=0Aroot@arwen:~# =0Aroot@arwen:~# ls=0Aprepare  spidev_test=0Aroot@arw=
en:~# ls=0Aprepare  spidev_test=0Aroot@arwen:~# ls=0Aprepare  spidev_test=
=0Aroot@arwen:~# dmesg=0A[  192.561614] platform omap-mcbsp.4: device_resum=
e 577=0A[  192.561676] platform omap-mcbsp.5: device_resume 577=0A[  192.56=
1706] platform omapfb: device_resume 577=0A[  192.561737] cpu cpu0: device_=
resume 577=0A[  192.561798] omap_wdt omap_wdt: device_resume 577=0A[  192.5=
61828] arm-pmu arm-pmu: device_resume 577=0A[  192.561950] bdi default: dev=
ice_resume 577=0A[  192.561981] omap-dma-engine omap-dma-engine: device_res=
ume 577=0A[  192.562011] dma dma0chan0: device_resume 577=0A[  192.562042] =
dma dma0chan1: device_resume 577=0A[  192.562072] dma dma0chan2: device_res=
ume 577=0A[  192.562133] dma dma0chan3: device_resume 577=0A[  192.562164] =
dma dma0chan4: device_resume 577=0A[  192.562194] dma dma0chan5: device_res=
ume 577=0A[  192.562225] dma dma0chan6: device_resume 577=0A[  192.562255] =
dma dma0chan7: device_resume 577=0A[  192.562286] dma dma0chan8: device_res=
ume 577=0A[  192.562316] dma dma0chan9: device_resume 577=0A[  192.562347] =
dma dma0chan10: device_resume 577=0A[  192.562377] dma dma0chan11: device_r=
esume 577=0A[  192.562408] dma dma0chan12: device_resume 577=0A[  192.56246=
9] dma dma0chan13: device_resume 577=0A[  192.562499] dma dma0chan14: devic=
e_resume 577=0A[  192.562530] dma dma0chan15: device_resume 577=0A[  192.56=
2561] dma dma0chan16: device_resume 577=0A[  192.562591] dma dma0chan17: de=
vice_resume 577=0A[  192.562622] dma dma0chan18: device_resume 577=0A[  192=
=2E562652] dma dma0chan19: device_resume 577=0A[  192.562683] dma dma0chan2=
0: device_resume 577=0A[  192.562713] dma dma0chan21: device_resume 577=0A[=
  192.562744] dma dma0chan22: device_resume 577=0A[  192.562805] dma dma0ch=
an23: device_resume 577=0A[  192.562835] dma dma0chan24: device_resume 577=
=0A[  192.562866] dma dma0chan25: device_resume 577=0A[  192.562896] dma dm=
a0chan26: device_resume 577=0A[  192.562927] dma dma0chan27: device_resume =
577=0A[  192.562957] dma dma0chan28: device_resume 577=0A[  192.562988] dma=
 dma0chan29: device_resume 577=0A[  192.563018] dma dma0chan30: device_resu=
me 577=0A[  192.563049] dma dma0chan31: device_resume 577=0A[  192.563079] =
dma dma0chan32: device_resume 577=0A[  192.563110] dma dma0chan33: device_r=
esume 577=0A[  192.563171] dma dma0chan34: device_resume 577=0A[  192.56320=
1] dma dma0chan35: device_resume 577=0A[  192.563232] dma dma0chan36: devic=
e_resume 577=0A[  192.563262] dma dma0chan37: device_resume 577=0A[  192.56=
3293] dma dma0chan38: device_resume 577=0A[  192.563323] dma dma0chan39: de=
vice_resume 577=0A[  192.563354] dma dma0chan40: device_resume 577=0A[  192=
=2E563385] dma dma0chan41: device_resume 577=0A[  192.563415] dma dma0chan4=
2: device_resume 577=0A[  192.563446] dma dma0chan43: device_resume 577=0A[=
  192.563476] dma dma0chan44: device_resume 577=0A[  192.563537] dma dma0ch=
an45: device_resume 577=0A[  192.563568] dma dma0chan46: device_resume 577=
=0A[  192.563598] dma dma0chan47: device_resume 577=0A[  192.563629] dma dm=
a0chan48: device_resume 577=0A[  192.563659] dma dma0chan49: device_resume =
577=0A[  192.563690] dma dma0chan50: device_resume 577=0A[  192.563720] dma=
 dma0chan51: device_resume 577=0A[  192.563751] dma dma0chan52: device_resu=
me 577=0A[  192.563781] dma dma0chan53: device_resume 577=0A[  192.563812] =
dma dma0chan54: device_resume 577=0A[  192.563873] dma dma0chan55: device_r=
esume 577=0A[  192.563903] dma dma0chan56: device_resume 577=0A[  192.56393=
4] dma dma0chan57: device_resume 577=0A[  192.563964] dma dma0chan58: devic=
e_resume 577=0A[  192.563995] dma dma0chan59: device_resume 577=0A[  192.56=
4025] dma dma0chan60: device_resume 577=0A[  192.564056] dma dma0chan61: de=
vice_resume 577=0A[  192.564086] dma dma0chan62: device_resume 577=0A[  192=
=2E564117] dma dma0chan63: device_resume 577=0A[  192.564147] dma dma0chan6=
4: device_resume 577=0A[  192.564208] dma dma0chan65: device_resume 577=0A[=
  192.564239] dma dma0chan66: device_resume 577=0A[  192.564270] dma dma0ch=
an67: device_resume 577=0A[  192.564300] dma dma0chan68: device_resume 577=
=0A[  192.564331] dma dma0chan69: device_resume 577=0A[  192.564361] dma dm=
a0chan70: device_resume 577=0A[  192.564392] dma dma0chan71: device_resume =
577=0A[  192.564422] dma dma0chan72: device_resume 577=0A[  192.564453] dma=
 dma0chan73: device_resume 577=0A[  192.564483] dma dma0chan74: device_resu=
me 577=0A[  192.564544] dma dma0chan75: device_resume 577=0A[  192.564575] =
dma dma0chan76: device_resume 577=0A[  192.564605] dma dma0chan77: device_r=
esume 577=0A[  192.564636] dma dma0chan78: device_resume 577=0A[  192.56466=
6] dma dma0chan79: device_resume 577=0A[  192.564697] dma dma0chan80: devic=
e_resume 577=0A[  192.564727] dma dma0chan81: device_resume 577=0A[  192.56=
4758] dma dma0chan82: device_resume 577=0A[  192.564788] dma dma0chan83: de=
vice_resume 577=0A[  192.564819] dma dma0chan84: device_resume 577=0A[  192=
=2E564880] dma dma0chan85: device_resume 577=0A[  192.564910] dma dma0chan8=
6: device_resume 577=0A[  192.564941] dma dma0chan87: device_resume 577=0A[=
  192.564971] dma dma0chan88: device_resume 577=0A[  192.565002] dma dma0ch=
an89: device_resume 577=0A[  192.565032] dma dma0chan90: device_resume 577=
=0A[  192.565063] dma dma0chan91: device_resume 577=0A[  192.565093] dma dm=
a0chan92: device_resume 577=0A[  192.565124] dma dma0chan93: device_resume =
577=0A[  192.565155] dma dma0chan94: device_resume 577=0A[  192.565216] dma=
 dma0chan95: device_resume 577=0A[  192.565246] dma dma0chan96: device_resu=
me 577=0A[  192.565277] dma dma0chan97: device_resume 577=0A[  192.565307] =
dma dma0chan98: device_resume 577=0A[  192.565338] dma dma0chan99: device_r=
esume 577=0A[  192.565368] dma dma0chan100: device_resume 577=0A[  192.5653=
99] dma dma0chan101: device_resume 577=0A[  192.565429] dma dma0chan102: de=
vice_resume 577=0A[  192.565460] dma dma0chan103: device_resume 577=0A[  19=
2.565490] dma dma0chan104: device_resume 577=0A[  192.565551] dma dma0chan1=
05: device_resume 577=0A[  192.565582] dma dma0chan106: device_resume 577=
=0A[  192.565612] dma dma0chan107: device_resume 577=0A[  192.565643] dma d=
ma0chan108: device_resume 577=0A[  192.565673] dma dma0chan109: device_resu=
me 577=0A[  192.565704] dma dma0chan110: device_resume 577=0A[  192.565734]=
 dma dma0chan111: device_resume 577=0A[  192.565765] dma dma0chan112: devic=
e_resume 577=0A[  192.565795] dma dma0chan113: device_resume 577=0A[  192.5=
65826] dma dma0chan114: device_resume 577=0A[  192.565887] dma dma0chan115:=
 device_resume 577=0A[  192.565917] dma dma0chan116: device_resume 577=0A[ =
 192.565948] dma dma0chan117: device_resume 577=0A[  192.565979] dma dma0ch=
an118: device_resume 577=0A[  192.566009] dma dma0chan119: device_resume 57=
7=0A[  192.566040] dma dma0chan120: device_resume 577=0A[  192.566070] dma =
dma0chan121: device_resume 577=0A[  192.566101] dma dma0chan122: device_res=
ume 577=0A[  192.566131] dma dma0chan123: device_resume 577=0A[  192.566162=
] dma dma0chan124: device_resume 577=0A[  192.566192] dma dma0chan125: devi=
ce_resume 577=0A[  192.566253] dma dma0chan126: device_resume 577=0A[  192.=
566284] i2c i2c-1: device_resume 577=0A[  192.566314] twl 1-0048: device_re=
sume 577=0A[  192.566345] platform twl: device_resume 577=0A[  192.566375] =
dummy 1-0049: device_resume 577=0A[  192.566406] dummy 1-004a: device_resum=
e 577=0A[  192.566436] dummy 1-004b: device_resume 577=0A[  192.566497] twl=
4030_gpio twl4030_gpio: device_resume 577=0A[  192.566528] gpio gpiochip492=
: device_resume 577=0A[  192.566558] omap_hsmmc omap_hsmmc.0: device_resume=
 577=0A[  192.566589] omap_hsmmc omap_hsmmc.0: _od_resume 884=0A[  192.5668=
64] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D4=0A[  192.566894] omap=
_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  192.566925] omap_i2c omap_i2c.1: ad=
dr: 0x0049, len: 4, flags: 0x0, stop: 1=0A[  192.566955] omap_i2c omap_i2c.=
1: omap_i2c_xfer_msg 537=0A[  192.566986] omap_i2c omap_i2c.1: omap_i2c_isr=
 880=0A[  192.567016] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat=
 1510=0A[  192.567016] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  192.56704=
7] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  192.567108] =3D=3D=3D> irq_wa=
ke_thread 139: IRQ 72 wake_up_process 1=0A[  192.567169] omap_i2c omap_i2c.=
1: omap_i2c_isr_thread 908=0A[  192.567199] omap_i2c omap_i2c.1: IRQ (ISR =
=3D 0x0010)=0A[  192.567199] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[  192.567260] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  192.567260] om=
ap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[  192.567291] o=
map_i2c omap_i2c.1: omap_i2c_isr 889=0A[  192.567291] omap_i2c omap_i2c.1: =
omap_i2c_isr 894=0A[  192.567321] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wa=
ke_up_process 0=0A[  192.567321] omap_i2c omap_i2c.1: omap_i2c_isr_thread 9=
08=0A[  192.567352] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  192.5673=
82] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  192.567687] omap_i2c=
 omap_i2c.1: omap_i2c_xfer 663=0A[  192.567749] i2c i2c-1: master_xfer[0] W=
, addr=3D0x4b, len=3D1=0A[  192.567749] i2c i2c-1: master_xfer[1] R, addr=
=3D0x4b, len=3D1=0A[  192.567779] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A=
[  192.567810] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0=0A[  192.567840] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  192.567=
871] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  192.567871] omap_i2c omap_i=
2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  192.567901] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[  192.567901] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[  192.567932] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[  192.567993] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  192.5=
68023] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  192.568023] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[  192.568054] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[  192.568084] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 1104=0A[  192.568084] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[  192.568115] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  192.568115] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  192.568145] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  192.568176] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[  192.568206] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[  192.568267] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, =
flags: 0x1, stop: 1=0A[  192.568267] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[  192.568328] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  192.568359=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  192.56835=
9] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  192.568389] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[  192.568420] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[  192.568450] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[  192.568450] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  19=
2.568481] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  192.568511] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  192.568603] omap_i2c omap_i2c.=
1: omap_i2c_xfer 663=0A[  192.568634] i2c i2c-1: master_xfer[0] W, addr=3D0=
x4b, len=3D1=0A[  192.568664] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=
=3D1=0A[  192.568695] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  192.56872=
5] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  192.=
568725] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  192.568756] omap_i2=
c omap_i2c.1: omap_i2c_isr 880=0A[  192.568786] omap_i2c omap_i2c.1: omap_i=
2c_isr 886: mask 601f stat 1110=0A[  192.568786] omap_i2c omap_i2c.1: omap_=
i2c_isr 889=0A[  192.568817] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  192=
=2E568847] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  19=
2.568878] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  192.568908] oma=
p_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  192.568908] omap_i2c omap_i2c.1=
: omap_i2c_isr_thread 1033=0A[  192.568939] omap_i2c omap_i2c.1: omap_i2c_i=
sr 880=0A[  192.568969] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f st=
at 1104=0A[  192.568969] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  192.569=
000] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  192.569000] =3D=3D=3D> irq_=
wake_thread 139: IRQ 72 wake_up_process 0=0A[  192.569030] omap_i2c omap_i2=
c.1: omap_i2c_isr_thread 908=0A[  192.569061] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x0004)=0A[  192.569091] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[  192.569122] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, st=
op: 1=0A[  192.569152] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  192.=
569213] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  192.569213] omap_i2c oma=
p_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  192.569244] omap_i2c om=
ap_i2c.1: omap_i2c_isr 889=0A[  192.569244] omap_i2c omap_i2c.1: omap_i2c_i=
sr 894=0A[  192.569274] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proc=
ess 1=0A[  192.569305] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  19=
2.569335] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  192.569335] omap_i=
2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  192.569366] omap_i2c omap_i2c.1: o=
map_i2c_isr_thread 1033=0A[  192.569427] omap_i2c omap_i2c.1: omap_i2c_xfer=
 663=0A[  192.569488] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[=
  192.569519] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[  192.56=
9549] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  192.569549] omap_i2c omap=
_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  192.569580] omap_i2c=
 omap_i2c.1: omap_i2c_xfer_msg 537=0A[  192.569610] omap_i2c omap_i2c.1: om=
ap_i2c_isr 880=0A[  192.569641] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask=
 601f stat 1110=0A[  192.569641] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ =
 192.569671] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  192.569671] =3D=3D=
=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  192.569793] omap_i2=
c omap_i2c.1: omap_i2c_isr_thread 908=0A[  192.569824] omap_i2c omap_i2c.1:=
 IRQ (ISR =3D 0x0010)=0A[  192.569854] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 1033=0A[  192.569854] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  192.5=
69885] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  192.=
569915] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  192.569915] omap_i2c oma=
p_i2c.1: omap_i2c_isr 894=0A[  192.569946] =3D=3D=3D> irq_wake_thread 139: =
IRQ 72 wake_up_process 0=0A[  192.569946] omap_i2c omap_i2c.1: omap_i2c_isr=
_thread 908=0A[  192.569976] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ =
 192.570007] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  192.570068]=
 omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[  192.57=
0068] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  192.570129] omap_i2c =
omap_i2c.1: omap_i2c_isr 880=0A[  192.570159] omap_i2c omap_i2c.1: omap_i2c=
_isr 886: mask 601f stat 0108=0A[  192.570159] omap_i2c omap_i2c.1: omap_i2=
c_isr 889=0A[  192.570190] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  192.5=
70220] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  192.57=
0251] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  192.570251] omap_i2=
c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  192.570281] omap_i2c omap_i2c.1: IR=
Q (ISR =3D 0x0004)=0A[  192.570312] omap_i2c omap_i2c.1: omap_i2c_isr_threa=
d 1033=0A[  192.570343] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  192.570=
373] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[  192.570404] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  192.570434] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[  192.570465] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[  192.570495] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[  192.570495] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[  192.570526] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  192.57=
0526] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  192.570556] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[  192.570617] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[  192.570617] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[  192.570648] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[  192.570678] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  192.570678] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[  192.570709] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  192.570709] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[  192.570739] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[  192.570770] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[  192.570770] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  192.570=
800] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  192.570861] omap_i2=
c omap_i2c.1: omap_i2c_xfer 663=0A[  192.570983] i2c i2c-1: master_xfer[0] =
W, addr=3D0x4b, len=3D1=0A[  192.571014] i2c i2c-1: master_xfer[1] R, addr=
=3D0x4b, len=3D1=0A[  192.571014] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A=
[  192.571044] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0=0A[  192.571075] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  192.571=
105] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  192.571105] omap_i2c omap_i=
2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  192.571136] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[  192.571136] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[  192.571166] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[  192.571228] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  192.5=
71228] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  192.571258] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[  192.571289] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[  192.571289] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 1104=0A[  192.571319] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[  192.571319] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  192.571350] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  192.571380] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  192.571380] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[  192.571411] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[  192.571472] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, =
flags: 0x1, stop: 1=0A[  192.571472] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[  192.571533] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  192.571563=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  192.57156=
3] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  192.571594] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[  192.571624] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[  192.571655] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[  192.571655] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  19=
2.571685] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  192.571716] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  192.571746] omap_i2c omap_i2c.=
1: omap_i2c_xfer 663=0A[  192.571807] i2c i2c-1: master_xfer[0] W, addr=3D0=
x4b, len=3D1=0A[  192.571807] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=
=3D1=0A[  192.571838] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  192.57186=
8] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  192.=
571868] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  192.571899] omap_i2=
c omap_i2c.1: omap_i2c_isr 880=0A[  192.571929] omap_i2c omap_i2c.1: omap_i=
2c_isr 886: mask 601f stat 1110=0A[  192.571929] omap_i2c omap_i2c.1: omap_=
i2c_isr 889=0A[  192.571960] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  192=
=2E571990] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  19=
2.572021] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  192.572051] oma=
p_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  192.572051] omap_i2c omap_i2c.1=
: omap_i2c_isr_thread 1033=0A[  192.572082] omap_i2c omap_i2c.1: omap_i2c_i=
sr 880=0A[  192.572113] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f st=
at 1104=0A[  192.572113] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  192.572=
143] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  192.572143] =3D=3D=3D> irq_=
wake_thread 139: IRQ 72 wake_up_process 0=0A[  192.572174] omap_i2c omap_i2=
c.1: omap_i2c_isr_thread 908=0A[  192.572204] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x0004)=0A[  192.572235] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[  192.572265] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, st=
op: 1=0A[  192.572296] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  192.=
572357] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  192.572357] omap_i2c oma=
p_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  192.572387] omap_i2c om=
ap_i2c.1: omap_i2c_isr 889=0A[  192.572387] omap_i2c omap_i2c.1: omap_i2c_i=
sr 894=0A[  192.572418] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proc=
ess 1=0A[  192.572448] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  19=
2.572479] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  192.572479] omap_i=
2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  192.572509] omap_i2c omap_i2c.1: o=
map_i2c_isr_thread 1033=0A[  192.572570] omap_i2c omap_i2c.1: omap_i2c_xfer=
 663=0A[  192.572601] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[=
  192.572631] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  192.572662] omap_=
i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[  192.572662] =
omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  192.572692] omap_i2c omap_i=
2c.1: omap_i2c_isr 880=0A[  192.572723] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 1110=0A[  192.572723] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[  192.572753] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  192.572753]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  192.572814] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  192.572814] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0010)=0A[  192.572845] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 1033=0A[  192.572875] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[=
  192.572906] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A=
[  192.572906] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  192.572937] omap_=
i2c omap_i2c.1: omap_i2c_isr 894=0A[  192.572937] =3D=3D=3D> irq_wake_threa=
d 139: IRQ 72 wake_up_process 0=0A[  192.572967] omap_i2c omap_i2c.1: omap_=
i2c_isr_thread 908=0A[  192.572967] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x000=
4)=0A[  192.572998] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  192.=
573059] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  193.690765] twl_rtc twl=
_rtc: device_resume 577=0A[  193.690795] i2c i2c-1: master_xfer[0] W, addr=
=3D0x4b, len=3D2=0A[  193.690826] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A=
[  193.690856] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1=0A[  193.690887] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  193.690=
917] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  193.690917] omap_i2c omap_i=
2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  193.690948] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[  193.690948] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[  193.691009] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[  193.691040] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  193.6=
91070] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  193.691070] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[  193.691131] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[  193.691162] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 0104=0A[  193.691162] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[  193.691192] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  193.691223] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  193.691253] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  193.691253] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[  193.691284] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[  193.691345] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ =
 193.691406] platform twl4030_wdt: device_resume 577=0A[  193.691436] twl40=
30_pwrbutton twl4030_pwrbutton: device_resume 577=0A[  193.691467] twl4030-=
audio twl4030-audio: device_resume 577=0A[  193.691497] twl_reg twl_reg.0: =
device_resume 577=0A[  193.691528] regulator regulator.1: device_resume 577=
=0A[  193.691558] twl_reg twl_reg.1: device_resume 577=0A[  193.691619] reg=
ulator regulator.2: device_resume 577=0A[  193.691650] twl_reg twl_reg.6: d=
evice_resume 577=0A[  193.691680] regulator regulator.3: device_resume 577=
=0A[  193.691711] twl_reg twl_reg.3: device_resume 577=0A[  193.691741] reg=
ulator regulator.4: device_resume 577=0A[  193.691772] twl_reg twl_reg.5: d=
evice_resume 577=0A[  193.691802] regulator regulator.5: device_resume 577=
=0A[  193.691833] twl_reg twl_reg.8: device_resume 577=0A[  193.691894] reg=
ulator regulator.6: device_resume 577=0A[  193.691925] i2c i2c-3: device_re=
sume 577=0A[  193.691955] i2c 3-0050: device_resume 577=0A[  193.691986] ne=
t lo: device_resume 577=0A[  193.692016] mem mem: device_resume 577=0A[  19=
3.692047] mem kmem: device_resume 577=0A[  193.692077] mem null: device_res=
ume 577=0A[  193.692138] mem zero: device_resume 577=0A[  193.692169] mem f=
ull: device_resume 577=0A[  193.692199] mem random: device_resume 577=0A[  =
193.692230] mem urandom: device_resume 577=0A[  193.692260] mem kmsg: devic=
e_resume 577=0A[  193.692291] tty tty: device_resume 577=0A[  193.692321] t=
ty console: device_resume 577=0A[  193.692352] tty tty0: device_resume 577=
=0A[  193.692413] vc vcs: device_resume 577=0A[  193.692443] vc vcsa: devic=
e_resume 577=0A[  193.692474] vc vcs1: device_resume 577=0A[  193.692504] v=
c vcsa1: device_resume 577=0A[  193.692535] tty tty1: device_resume 577=0A[=
  193.692565] tty tty2: device_resume 577=0A[  193.692596] tty tty3: device=
_resume 577=0A[  193.692626] tty tty4: device_resume 577=0A[  193.692657] t=
ty tty5: device_resume 577=0A[  193.692718] tty tty6: device_resume 577=0A[=
  193.692749] tty tty7: device_resume 577=0A[  193.692779] tty tty8: device=
_resume 577=0A[  193.692810] tty tty9: device_resume 577=0A[  193.692840] t=
ty tty10: device_resume 577=0A[  193.692871] tty tty11: device_resume 577=
=0A[  193.692901] tty tty12: device_resume 577=0A[  193.692932] tty tty13: =
device_resume 577=0A[  193.692993] tty tty14: device_resume 577=0A[  193.69=
3023] tty tty15: device_resume 577=0A[  193.693054] tty tty16: device_resum=
e 577=0A[  193.693084] tty tty17: device_resume 577=0A[  193.693115] tty tt=
y18: device_resume 577=0A[  193.693145] tty tty19: device_resume 577=0A[  1=
93.693176] tty tty20: device_resume 577=0A[  193.693206] tty tty21: device_=
resume 577=0A[  193.693237] tty tty22: device_resume 577=0A[  193.693298] t=
ty tty23: device_resume 577=0A[  193.693328] tty tty24: device_resume 577=
=0A[  193.693359] tty tty25: device_resume 577=0A[  193.693389] tty tty26: =
device_resume 577=0A[  193.693420] tty tty27: device_resume 577=0A[  193.69=
3450] tty tty28: device_resume 577=0A[  193.693481] tty tty29: device_resum=
e 577=0A[  193.693511] tty tty30: device_resume 577=0A[  193.693572] tty tt=
y31: device_resume 577=0A[  193.693603] tty tty32: device_resume 577=0A[  1=
93.693634] tty tty33: device_resume 577=0A[  193.693664] tty tty34: device_=
resume 577=0A[  193.693695] tty tty35: device_resume 577=0A[  193.693725] t=
ty tty36: device_resume 577=0A[  193.693756] tty tty37: device_resume 577=
=0A[  193.693786] tty tty38: device_resume 577=0A[  193.693847] tty tty39: =
device_resume 577=0A[  193.693878] tty tty40: device_resume 577=0A[  193.69=
3908] tty tty41: device_resume 577=0A[  193.693939] tty tty42: device_resum=
e 577=0A[  193.693969] tty tty43: device_resume 577=0A[  193.694000] tty tt=
y44: device_resume 577=0A[  193.694061] tty tty45: device_resume 577=0A[  1=
93.694122] tty tty46: device_resume 577=0A[  193.694152] tty tty47: device_=
resume 577=0A[  193.694183] tty tty48: device_resume 577=0A[  193.694213] t=
ty tty49: device_resume 577=0A[  193.694244] tty tty50: device_resume 577=
=0A[  193.694274] tty tty51: device_resume 577=0A[  193.694305] tty tty52: =
device_resume 577=0A[  193.694366] tty tty53: device_resume 577=0A[  193.69=
4396] tty tty54: device_resume 577=0A[  193.694427] tty tty55: device_resum=
e 577=0A[  193.694458] tty tty56: device_resume 577=0A[  193.694488] tty tt=
y57: device_resume 577=0A[  193.694519] tty tty58: device_resume 577=0A[  1=
93.694641] tty tty59: device_resume 577=0A[  193.694671] tty tty60: device_=
resume 577=0A[  193.694702] tty tty61: device_resume 577=0A[  193.694732] t=
ty tty62: device_resume 577=0A[  193.694793] tty tty63: device_resume 577=
=0A[  193.694824]  clocksource: device_resume 577=0A[  193.694854] clocksou=
rce clocksource0: device_resume 577=0A[  193.694885] alarmtimer alarmtimer:=
 device_resume 577=0A[  193.694915] event_source ARMv7 Cortex-A8: device_re=
sume 577=0A[  193.694946] event_source breakpoint: device_resume 577=0A[  1=
93.694976] event_source tracepoint: device_resume 577=0A[  193.695007] even=
t_source software: device_resume 577=0A[  193.695068] graphics fbcon: devic=
e_resume 577=0A[  193.695098] tty ptmx: device_resume 577=0A[  193.695129] =
serial8250 serial8250: device_resume 577=0A[  193.695159] tty ttyS0: device=
_resume 577=0A[  193.695190] tty ttyS1: device_resume 577=0A[  193.695220] =
tty ttyS2: device_resume 577=0A[  193.695281] tty ttyS3: device_resume 577=
=0A[  193.695312] tty ttyO0: device_resume 577=0A[  193.695343] tty ttyO1: =
device_resume 577=0A[  193.695373] tty ttyO2: device_resume 577=0A[  193.69=
5404] tty ttyO3: device_resume 577=0A[  193.695434] bdi 1:0: device_resume =
577=0A[  193.695465] block ram0: device_resume 577=0A[  193.695495] bdi 1:1=
: device_resume 577=0A[  193.695556] block ram1: device_resume 577=0A[  193=
=2E695587] bdi 1:2: device_resume 577=0A[  193.695617] block ram2: device_r=
esume 577=0A[  193.695648] bdi 1:3: device_resume 577=0A[  193.695678] bloc=
k ram3: device_resume 577=0A[  193.695709] bdi 1:4: device_resume 577=0A[  =
193.695739] block ram4: device_resume 577=0A[  193.695770] bdi 1:5: device_=
resume 577=0A[  193.695800] block ram5: device_resume 577=0A[  193.695861] =
bdi 1:6: device_resume 577=0A[  193.695892] block ram6: device_resume 577=
=0A[  193.695922] bdi 1:7: device_resume 577=0A[  193.695953] block ram7: d=
evice_resume 577=0A[  193.695983] bdi 1:8: device_resume 577=0A[  193.69601=
4] block ram8: device_resume 577=0A[  193.696044] bdi 1:9: device_resume 57=
7=0A[  193.696075] block ram9: device_resume 577=0A[  193.696105] bdi 1:10:=
 device_resume 577=0A[  193.696166] block ram10: device_resume 577=0A[  193=
=2E696197] bdi 1:11: device_resume 577=0A[  193.696228] block ram11: device=
_resume 577=0A[  193.696258] bdi 1:12: device_resume 577=0A[  193.696289] b=
lock ram12: device_resume 577=0A[  193.696319] bdi 1:13: device_resume 577=
=0A[  193.696350] block ram13: device_resume 577=0A[  193.696380] bdi 1:14:=
 device_resume 577=0A[  193.696411] block ram14: device_resume 577=0A[  193=
=2E696472] bdi 1:15: device_resume 577=0A[  193.696502] block ram15: device=
_resume 577=0A[  193.696533] misc loop-control: device_resume 577=0A[  193.=
696563] bdi 7:0: device_resume 577=0A[  193.696594] block loop0: device_res=
ume 577=0A[  193.696624] bdi 7:1: device_resume 577=0A[  193.696655] block =
loop1: device_resume 577=0A[  193.696685] bdi 7:2: device_resume 577=0A[  1=
93.696746] block loop2: device_resume 577=0A[  193.696777] bdi 7:3: device_=
resume 577=0A[  193.696807] block loop3: device_resume 577=0A[  193.696838]=
 bdi 7:4: device_resume 577=0A[  193.696868] block loop4: device_resume 577=
=0A[  193.696899] bdi 7:5: device_resume 577=0A[  193.696929] block loop5: =
device_resume 577=0A[  193.696960] bdi 7:6: device_resume 577=0A[  193.6970=
21] block loop6: device_resume 577=0A[  193.697051] bdi 7:7: device_resume =
577=0A[  193.697082] block loop7: device_resume 577=0A[  193.697113] platfo=
rm twl4030-codec: device_resume 577=0A[  193.697143] bdi mtd-unmap: device_=
resume 577=0A[  193.697174] bdi mtd-romap: device_resume 577=0A[  193.69720=
4] bdi mtd-rwmap: device_resume 577=0A[  193.697235] spi_master spi1: devic=
e_resume 577=0A[  193.697265] spi_master spi2: device_resume 577=0A[  193.6=
97326] spi_master spi3: device_resume 577=0A[  193.697357] spi_master spi4:=
 device_resume 577=0A[  193.697387] usbmon usbmon0: device_resume 577=0A[  =
193.697418] input mice: device_resume 577=0A[  193.697448] misc psaux: devi=
ce_resume 577=0A[  193.697479] input input0: device_resume 577=0A[  193.697=
601] input event0: device_resume 577=0A[  193.697631] rtc rtc0: device_resu=
me 577=0A[  193.697692] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=
=0A[  193.697692] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[  19=
3.697723] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  193.697784] omap_i2c =
omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  193.697784] omap=
_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  193.697814] omap_i2c omap_i2c.1=
: omap_i2c_isr 880=0A[  193.697845] omap_i2c omap_i2c.1: omap_i2c_isr 886: =
mask 601f stat 1510=0A[  193.697845] omap_i2c omap_i2c.1: omap_i2c_isr 889=
=0A[  193.697875] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  193.697906] =
=3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  193.697967] o=
map_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  193.697998] omap_i2c omap_=
i2c.1: IRQ (ISR =3D 0x0010)=0A[  193.698028] omap_i2c omap_i2c.1: omap_i2c_=
isr_thread 1033=0A[  193.698059] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ =
 193.698059] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[=
  193.698089] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  193.698089] omap_i=
2c omap_i2c.1: omap_i2c_isr 894=0A[  193.698120] =3D=3D=3D> irq_wake_thread=
 139: IRQ 72 wake_up_process 0=0A[  193.698150] omap_i2c omap_i2c.1: omap_i=
2c_isr_thread 908=0A[  193.698150] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004=
)=0A[  193.698181] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  193.6=
98333] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[  =
193.698333] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  193.698394] oma=
p_i2c omap_i2c.1: omap_i2c_isr 880=0A[  193.698425] omap_i2c omap_i2c.1: om=
ap_i2c_isr 886: mask 601f stat 0108=0A[  193.698425] omap_i2c omap_i2c.1: o=
map_i2c_isr 889=0A[  193.698455] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ =
 193.698486] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  =
193.698516] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  193.698547] o=
map_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  193.698547] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[  193.698577] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[  193.698638] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ =
 193.698669] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[  193.698=
699] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  193.698730] omap_i2c omap_=
i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[  193.698730] omap_i2c =
omap_i2c.1: omap_i2c_xfer_msg 537=0A[  193.698760] omap_i2c omap_i2c.1: oma=
p_i2c_isr 880=0A[  193.698791] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask =
601f stat 1110=0A[  193.698791] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  =
193.698822] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  193.698852] =3D=3D=
=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  193.698883] omap_i2=
c omap_i2c.1: omap_i2c_isr_thread 908=0A[  193.698913] omap_i2c omap_i2c.1:=
 IRQ (ISR =3D 0x0010)=0A[  193.698913] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 1033=0A[  193.698974] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  193.6=
99005] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[  193.=
699005] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  193.699035] omap_i2c oma=
p_i2c.1: omap_i2c_isr 894=0A[  193.699035] =3D=3D=3D> irq_wake_thread 139: =
IRQ 72 wake_up_process 1=0A[  193.699066] omap_i2c omap_i2c.1: omap_i2c_isr=
_thread 908=0A[  193.699096] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ =
 193.699127] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  193.699188]=
 omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  193.699218] i2c i2c-1: master_=
xfer[0] W, addr=3D0x4b, len=3D1=0A[  193.699218] i2c i2c-1: master_xfer[1] =
R, addr=3D0x4b, len=3D6=0A[  193.699249] omap_i2c omap_i2c.1: omap_i2c_xfer=
 626=0A[  193.699279] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0=
, stop: 0=0A[  193.699310] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  =
193.699340] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  193.699340] omap_i2c=
 omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  193.699371] omap_i2=
c omap_i2c.1: omap_i2c_isr 889=0A[  193.699371] omap_i2c omap_i2c.1: omap_i=
2c_isr 894=0A[  193.699401] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_=
process 1=0A[  193.699432] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[=
  193.699462] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  193.699493] om=
ap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  193.699523] omap_i2c omap_=
i2c.1: omap_i2c_isr 880=0A[  193.699523] omap_i2c omap_i2c.1: omap_i2c_isr =
886: mask 601f stat 1104=0A[  193.699554] omap_i2c omap_i2c.1: omap_i2c_isr=
 889=0A[  193.699554] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  193.699584=
] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  193.699584]=
 omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  193.699615] omap_i2c oma=
p_i2c.1: IRQ (ISR =3D 0x0004)=0A[  193.699645] omap_i2c omap_i2c.1: omap_i2=
c_isr_thread 1033=0A[  193.699707] omap_i2c omap_i2c.1: addr: 0x004b, len: =
6, flags: 0x1, stop: 1=0A[  193.699707] omap_i2c omap_i2c.1: omap_i2c_xfer_=
msg 537=0A[  193.699859] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  193.699=
890] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1108=0A[  193.69=
9890] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  193.699920] omap_i2c omap_=
i2c.1: omap_i2c_isr 894=0A[  193.699951] =3D=3D=3D> irq_wake_thread 139: IR=
Q 72 wake_up_process 1=0A[  193.699981] omap_i2c omap_i2c.1: omap_i2c_isr_t=
hread 908=0A[  193.700012] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  1=
93.700012] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x2000)=0A[  193.700042] omap_=
i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  193.700073] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 880=0A[  193.700103] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 0104=0A[  193.700134] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[  193.700134] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  193.700164]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  193.700164] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  193.700195] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0004)=0A[  193.700225] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 1033=0A[  193.700256] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A=
[  193.700317] i2c-dev i2c-1: device_resume 577=0A[  193.700347] i2c-dev i2=
c-3: device_resume 577=0A[  193.700408] misc watchdog: device_resume 577=0A=
[  193.700439] mmc_host mmc0: device_resume 577=0A[  193.700469] oprofile-p=
erf oprofile-perf.0: device_resume 577=0A[  193.700500] misc cpu_dma_latenc=
y: device_resume 577=0A[  193.700531] misc network_latency: device_resume 5=
77=0A[  193.700592] misc network_throughput: device_resume 577=0A[  193.700=
622] misc ubi_ctrl: device_resume 577=0A[  193.700653] input input1: device=
_resume 577=0A[  193.700683] input event1: device_resume 577=0A[  193.70071=
4] mmcblk mmc0:0002: device_resume 577=0A[  193.700775] bdi 179:0: device_r=
esume 577=0A[  193.700836] block mmcblk0: device_resume 577=0A[  193.700866=
] block mmcblk0p1: device_resume 577=0A[  193.700897] block mmcblk0p2: devi=
ce_resume 577=0A[  193.700927] vc vcs3: device_resume 577=0A[  193.700958] =
vc vcsa3: device_resume 577=0A[  193.700988] vc vcs2: device_resume 577=0A[=
  193.701019] vc vcsa2: device_resume 577=0A[  193.701080] vc vcs5: device_=
resume 577=0A[  193.701110] vc vcsa5: device_resume 577=0A[  193.701141] vc=
 vcs4: device_resume 577=0A[  193.701171] vc vcsa4: device_resume 577=0A[  =
193.701202] vc vcs6: device_resume 577=0A[  193.701232] vc vcsa6: device_re=
sume 577=0A[  193.701263] vc vcs63: device_resume 577=0A[  193.701293] vc v=
csa63: device_resume 577=0A[  193.701354] PM: resume of devices complete af=
ter 1143.676 msecs=0A[  193.707061] PM: Finishing wakeup.=0A[  193.707092] =
Restarting tasks ... done.=0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~=
# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aro=
ot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwe=
n:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =
=0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot=
@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# rtcwake --help=
=0A=0AUsage:=0A rtcwake [options]=0A=0AOptions:=0A -d, --device <device>   =
 select rtc device (rtc0|rtc1|...)=0A -n, --dry-run            does everyth=
ing, but suspend=0A -l, --local              RTC uses local timezone=0A -m,=
 --mode <mode>        standby|mem|... sleep mode=0A -s, --seconds <seconds>=
  seconds to sleep=0A -t, --time <time_t>      time to wake=0A -u, --utc   =
             RTC uses UTC=0A -v, --verbose            verbose messages=0A -=
V, --version            show version=0A=0AFor more information see rtcwake(=
8).=0Aroot@arwen:~# rtcwake -s 12=08 =08=08 =08120=08=08=08=08=08=08=08=08=
=08=08=08=08=08=08=0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroo=
t@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen=
:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0A=
root@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# rtvw=07=08 =08=08 =08cwake =
-s 120=0Artcwake: suspend to "standby" unavailable=0Aroot@arwen:~# rtcwake =
-s 120 =3Dm =08 =08=08 =08=08 =08m=08 =08-0m=08 =08=08 =08m mem=0Artcwake: =
wakeup from "mem" using /dev/rtc0 at Sat Jan  1 00:05:58 2000=0A=0Aroot@arw=
en:~# =0Aroot@arwen:~# ls=0Aprepare  spidev_test=0Aroot@arwen:~# dmesg =08 =
=08=0A[  357.997375] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  357.=
997406] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  357.997406] omap_i2c=
 omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  357.997436] omap_i2c omap_i2c.1: oma=
p_i2c_isr_thread 1033=0A[  357.997497] omap_i2c omap_i2c.1: omap_i2c_xfer 6=
63=0A[  357.997528] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  =
357.997558] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[  357.9975=
58] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  357.997589] omap_i2c omap_i=
2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  357.997619] omap_i2c o=
map_i2c.1: omap_i2c_xfer_msg 537=0A[  357.997650] omap_i2c omap_i2c.1: omap=
_i2c_isr 880=0A[  357.997650] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 6=
01f stat 1110=0A[  357.997680] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  3=
57.997680] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  357.997711] =3D=3D=3D=
> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  357.997741] omap_i2c o=
map_i2c.1: omap_i2c_isr_thread 908=0A[  357.997772] omap_i2c omap_i2c.1: IR=
Q (ISR =3D 0x0010)=0A[  357.997802] omap_i2c omap_i2c.1: omap_i2c_isr_threa=
d 1033=0A[  357.997833] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  357.9978=
33] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  357.997=
863] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  357.997863] omap_i2c omap_i=
2c.1: omap_i2c_isr 894=0A[  357.997894] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 0=0A[  357.997894] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[  357.997924] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  35=
7.997955] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  357.998016] om=
ap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[  357.99801=
6] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  357.998077] omap_i2c oma=
p_i2c.1: omap_i2c_isr 880=0A[  357.998107] omap_i2c omap_i2c.1: omap_i2c_is=
r 886: mask 601f stat 0108=0A[  357.998107] omap_i2c omap_i2c.1: omap_i2c_i=
sr 889=0A[  357.998138] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  357.9981=
38] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  357.99816=
8] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  357.998199] omap_i2c o=
map_i2c.1: IRQ (ISR =3D 0x0008)=0A[  357.998229] omap_i2c omap_i2c.1: IRQ (=
ISR =3D 0x0004)=0A[  357.998229] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1=
033=0A[  357.998291] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  357.998321=
] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[  357.998352] omap_i=
2c omap_i2c.1: omap_i2c_xfer 626=0A[  357.998382] omap_i2c omap_i2c.1: addr=
: 0x004b, len: 2, flags: 0x0, stop: 1=0A[  357.998413] omap_i2c omap_i2c.1:=
 omap_i2c_xfer_msg 537=0A[  357.998413] omap_i2c omap_i2c.1: omap_i2c_isr 8=
80=0A[  357.998443] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1=
110=0A[  357.998474] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  357.998474]=
 omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  357.998504] =3D=3D=3D> irq_wake=
_thread 139: IRQ 72 wake_up_process 1=0A[  357.998535] omap_i2c omap_i2c.1:=
 omap_i2c_isr_thread 908=0A[  357.998565] omap_i2c omap_i2c.1: IRQ (ISR =3D=
 0x0010)=0A[  357.998565] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[=
  357.998596] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  357.998626] omap_i=
2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[  357.998626] omap_=
i2c omap_i2c.1: omap_i2c_isr 889=0A[  357.998657] omap_i2c omap_i2c.1: omap=
_i2c_isr 894=0A[  357.998687] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_u=
p_process 0=0A[  357.998687] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=
=0A[  357.998718] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  357.998748=
] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  357.998809] omap_i2c o=
map_i2c.1: omap_i2c_xfer 663=0A[  359.028411] =3D=3D=3D> irq_wake_thread 13=
9: IRQ 23 wake_up_process 1=0A[  359.028594] =3D=3D> handle_twl4030_pih 298=
=0A[  359.028625] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D1=0A[  35=
9.028656] i2c i2c-1: master_xfer[1] R, addr=3D0x49, len=3D1=0A[  359.028686=
] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  359.028717] omap_i2c omap_i2c=
=2E1: addr: 0x0049, len: 1, flags: 0x0, stop: 0=0A[  359.028717] omap_i2c o=
map_i2c.1: omap_i2c_xfer_msg 537=0A[  359.028747] omap_i2c omap_i2c.1: omap=
_i2c_isr 880=0A[  359.028778] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 6=
01f stat 1110=0A[  359.028808] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  3=
59.028808] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.028869] =3D=3D=3D=
> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  359.029327] omap_i2c o=
map_i2c.1: omap_i2c_isr_thread 908=0A[  359.029327] omap_i2c omap_i2c.1: IR=
Q (ISR =3D 0x0010)=0A[  359.029357] omap_i2c omap_i2c.1: omap_i2c_isr_threa=
d 1033=0A[  359.029388] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.0294=
18] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  359.029=
418] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.029449] omap_i2c omap_i=
2c.1: omap_i2c_isr 894=0A[  359.029449] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 0=0A[  359.029479] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[  359.029510] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  35=
9.029541] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.029602] om=
ap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x1, stop: 1=0A[  359.02963=
2] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  359.029663] omap_i2c oma=
p_i2c.1: omap_i2c_isr 880=0A[  359.029693] omap_i2c omap_i2c.1: omap_i2c_is=
r 886: mask 601f stat 0108=0A[  359.029693] omap_i2c omap_i2c.1: omap_i2c_i=
sr 889=0A[  359.029724] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.0297=
54] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  359.02981=
5] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.029815] omap_i2c o=
map_i2c.1: IRQ (ISR =3D 0x0008)=0A[  359.029846] omap_i2c omap_i2c.1: IRQ (=
ISR =3D 0x0004)=0A[  359.029876] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1=
033=0A[  359.029937] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  359.029968=
] =3D=3D> handle_twl4030_sih 608=0A[  359.029998] i2c i2c-1: master_xfer[0]=
 W, addr=3D0x4b, len=3D1=0A[  359.029998] i2c i2c-1: master_xfer[1] R, addr=
=3D0x4b, len=3D1=0A[  359.030029] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A=
[  359.030059] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0=0A[  359.030090] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  359.030=
090] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.030120] omap_i2c omap_i=
2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  359.030151] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[  359.030151] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[  359.030212] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[  359.030242] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.0=
30273] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  359.030273] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.030303] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[  359.030334] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 1104=0A[  359.030334] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[  359.030364] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.030395] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  359.030395] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.030426] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[  359.030456] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[  359.030517] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, =
flags: 0x1, stop: 1=0A[  359.030548] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[  359.030578] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.030609=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  359.03063=
9] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.030639] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[  359.030670] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[  359.030700] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[  359.030731] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  35=
9.030731] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.030792] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.030822] omap_i2c omap_i2c.=
1: omap_i2c_xfer 663=0A[  359.030853] i2c i2c-1: master_xfer[0] W, addr=3D0=
x4b, len=3D1=0A[  359.030883] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=
=3D1=0A[  359.030914] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  359.03094=
4] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  359.=
030944] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  359.030975] omap_i2=
c omap_i2c.1: omap_i2c_isr 880=0A[  359.031005] omap_i2c omap_i2c.1: omap_i=
2c_isr 886: mask 601f stat 1110=0A[  359.031005] omap_i2c omap_i2c.1: omap_=
i2c_isr 889=0A[  359.031036] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359=
=2E031066] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  35=
9.031127] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.031127] oma=
p_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  359.031158] omap_i2c omap_i2c.1=
: omap_i2c_isr_thread 1033=0A[  359.031188] omap_i2c omap_i2c.1: omap_i2c_i=
sr 880=0A[  359.031188] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f st=
at 1104=0A[  359.031219] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.031=
219] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.031249] =3D=3D=3D> irq_=
wake_thread 139: IRQ 72 wake_up_process 0=0A[  359.031280] omap_i2c omap_i2=
c.1: omap_i2c_isr_thread 908=0A[  359.031280] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x0004)=0A[  359.031341] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[  359.031372] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, st=
op: 1=0A[  359.031402] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  359.=
031463] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.031463] omap_i2c oma=
p_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  359.031494] omap_i2c om=
ap_i2c.1: omap_i2c_isr 889=0A[  359.031494] omap_i2c omap_i2c.1: omap_i2c_i=
sr 894=0A[  359.031524] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proc=
ess 1=0A[  359.031555] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  35=
9.031585] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  359.031585] omap_i=
2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.031646] omap_i2c omap_i2c.1: o=
map_i2c_isr_thread 1033=0A[  359.031707] omap_i2c omap_i2c.1: omap_i2c_xfer=
 663=0A[  359.031707] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[=
  359.031738] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  359.031768] omap_=
i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[  359.031799] =
omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  359.031799] omap_i2c omap_i=
2c.1: omap_i2c_isr 880=0A[  359.031829] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 1110=0A[  359.031860] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[  359.031860] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.031921]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  359.031951] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.031982] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0010)=0A[  359.031982] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 1033=0A[  359.032043] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[=
  359.032073] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A=
[  359.032073] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.032104] omap_=
i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.032104] =3D=3D=3D> irq_wake_threa=
d 139: IRQ 72 wake_up_process 1=0A[  359.032135] omap_i2c omap_i2c.1: omap_=
i2c_isr_thread 908=0A[  359.032165] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x000=
4)=0A[  359.032226] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.=
032257] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  359.032287] i2c i2c-1: =
master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  359.032318] i2c i2c-1: master_x=
fer[1] R, addr=3D0x4b, len=3D1=0A[  359.032318] omap_i2c omap_i2c.1: omap_i=
2c_xfer 626=0A[  359.032348] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, fla=
gs: 0x0, stop: 0=0A[  359.032379] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 53=
7=0A[  359.032409] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.032409] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  359.032440] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.032440] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[  359.032501] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 1=0A[  359.032531] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[  359.032562] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  359.032=
562] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.032592] omap_i2=
c omap_i2c.1: omap_i2c_isr 880=0A[  359.032623] omap_i2c omap_i2c.1: omap_i=
2c_isr 886: mask 601f stat 1104=0A[  359.032653] omap_i2c omap_i2c.1: omap_=
i2c_isr 889=0A[  359.032653] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359=
=2E032684] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  35=
9.032684] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.032714] oma=
p_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.032745] omap_i2c omap_i2c.1=
: omap_i2c_isr_thread 1033=0A[  359.032806] omap_i2c omap_i2c.1: addr: 0x00=
4b, len: 1, flags: 0x1, stop: 1=0A[  359.032836] omap_i2c omap_i2c.1: omap_=
i2c_xfer_msg 537=0A[  359.032867] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[=
  359.032897] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A=
[  359.032897] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.032928] omap_=
i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.032958] =3D=3D=3D> irq_wake_threa=
d 139: IRQ 72 wake_up_process 1=0A[  359.032989] omap_i2c omap_i2c.1: omap_=
i2c_isr_thread 908=0A[  359.032989] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x000=
8)=0A[  359.033020] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.0330=
50] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.033111] omap_i2c=
 omap_i2c.1: omap_i2c_xfer 663=0A[  359.033843] i2c i2c-1: master_xfer[0] W=
, addr=3D0x4b, len=3D1=0A[  359.033874] i2c i2c-1: master_xfer[1] R, addr=
=3D0x4b, len=3D1=0A[  359.033935] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A=
[  359.034027] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0=0A[  359.034027] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  359.034=
057] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.034088] omap_i2c omap_i=
2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  359.034088] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[  359.034118] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[  359.034149] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[  359.034271] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.0=
34271] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  359.034301] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.034332] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[  359.034332] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 1104=0A[  359.034362] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[  359.034362] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.034393] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  359.034423] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.034423] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[  359.034454] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[  359.034545] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, =
flags: 0x1, stop: 1=0A[  359.034545] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[  359.034759] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.034790=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  359.03482=
0] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.034820] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[  359.034851] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[  359.034973] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[  359.034973] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  35=
9.035003] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.035034] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.035095] omap_i2c omap_i2c.=
1: omap_i2c_xfer 663=0A[  359.035125] i2c i2c-1: master_xfer[0] W, addr=3D0=
x4b, len=3D2=0A[  359.035156] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  3=
59.035186] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=
=0A[  359.035186] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  359.03521=
7] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.035247] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 886: mask 601f stat 1110=0A[  359.035247] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[  359.035278] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[  359.035308] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[  359.035339] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.0=
35369] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  359.035369] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.035430] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[  359.035461] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 0104=0A[  359.035461] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[  359.035491] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.035522] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  359.035552] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.035552] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[  359.035583] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[  359.035644] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ =
 359.035675] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  359.035=
705] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D6=0A[  359.035705] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  359.035736] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  359.035766] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[  359.035797] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[  359.035797] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[  359.035827] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.03=
5827] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.035858] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[  359.035919] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[  359.035919] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[  359.035949] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[  359.035980] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.035980] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  359.036010] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.036010] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[  359.036041] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[  359.036071] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[  359.036071] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.036=
102] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.036163] omap_i2=
c omap_i2c.1: addr: 0x004b, len: 6, flags: 0x1, stop: 1=0A[  359.036163] om=
ap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  359.036315] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 880=0A[  359.036346] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 1108=0A[  359.036346] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[  359.036376] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.036376]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  359.036437] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.036437] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0008)=0A[  359.036468] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x2000)=0A[  359.036499] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[  359.036529] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.036529] om=
ap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[  359.036560] o=
map_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.036560] omap_i2c omap_i2c.1: =
omap_i2c_isr 894=0A[  359.036590] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wa=
ke_up_process 0=0A[  359.036621] omap_i2c omap_i2c.1: omap_i2c_isr_thread 9=
08=0A[  359.036621] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.0366=
51] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.036712] omap_i2c=
 omap_i2c.1: omap_i2c_xfer 663=0A[  359.036987] i2c i2c-1: master_xfer[0] W=
, addr=3D0x4b, len=3D2=0A[  359.036987] omap_i2c omap_i2c.1: omap_i2c_xfer =
626=0A[  359.037017] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0,=
 stop: 1=0A[  359.037048] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  3=
59.037078] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.037109] omap_i2c =
omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  359.037109] omap_i2c=
 omap_i2c.1: omap_i2c_isr 889=0A[  359.037139] omap_i2c omap_i2c.1: omap_i2=
c_isr 894=0A[  359.037170] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_p=
rocess 1=0A[  359.037200] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ =
 359.037231] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  359.037261] oma=
p_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.037292] omap_i2c omap_i=
2c.1: omap_i2c_isr 880=0A[  359.037292] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 0104=0A[  359.037322] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[  359.037322] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.037353]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  359.037353] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.037384] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.037414] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 1033=0A[  359.037475] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A=
[  359.116882] twl_rtc twl_rtc: device_resume 577=0A[  359.116912] i2c i2c-=
1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[  359.116943] omap_i2c omap_i2=
c.1: omap_i2c_xfer 626=0A[  359.116973] omap_i2c omap_i2c.1: addr: 0x004b, =
len: 2, flags: 0x0, stop: 1=0A[  359.117004] omap_i2c omap_i2c.1: omap_i2c_=
xfer_msg 537=0A[  359.117034] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  35=
9.117034] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  3=
59.117065] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.117065] omap_i2c =
omap_i2c.1: omap_i2c_isr 894=0A[  359.117095] =3D=3D=3D> irq_wake_thread 13=
9: IRQ 72 wake_up_process 1=0A[  359.117156] omap_i2c omap_i2c.1: omap_i2c_=
isr_thread 908=0A[  359.117187] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=
=0A[  359.117187] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.11=
7248] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.117279] omap_i2c omap_=
i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[  359.117279] omap_i2c omap=
_i2c.1: omap_i2c_isr 889=0A[  359.117309] omap_i2c omap_i2c.1: omap_i2c_isr=
 894=0A[  359.117340] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proces=
s 1=0A[  359.117370] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.=
117370] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.117401] omap_i2c=
 omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.117462] omap_i2c omap_i2c.1:=
 omap_i2c_xfer 663=0A[  359.117492] platform twl4030_wdt: device_resume 577=
=0A[  359.117553] twl4030_pwrbutton twl4030_pwrbutton: device_resume 577=0A=
[  359.117584] twl4030-audio twl4030-audio: device_resume 577=0A[  359.1176=
14] twl_reg twl_reg.0: device_resume 577=0A[  359.117645] regulator regulat=
or.1: device_resume 577=0A[  359.117675] twl_reg twl_reg.1: device_resume 5=
77=0A[  359.117706] regulator regulator.2: device_resume 577=0A[  359.11773=
6] twl_reg twl_reg.6: device_resume 577=0A[  359.117797] regulator regulato=
r.3: device_resume 577=0A[  359.117828] twl_reg twl_reg.3: device_resume 57=
7=0A[  359.117858] regulator regulator.4: device_resume 577=0A[  359.117889=
] twl_reg twl_reg.5: device_resume 577=0A[  359.117919] regulator regulator=
=2E5: device_resume 577=0A[  359.117950] twl_reg twl_reg.8: device_resume 5=
77=0A[  359.117980] regulator regulator.6: device_resume 577=0A[  359.11804=
1] i2c i2c-3: device_resume 577=0A[  359.118072] i2c 3-0050: device_resume =
577=0A[  359.118103] net lo: device_resume 577=0A[  359.118133] mem mem: de=
vice_resume 577=0A[  359.118164] mem kmem: device_resume 577=0A[  359.11819=
4] mem null: device_resume 577=0A[  359.118225] mem zero: device_resume 577=
=0A[  359.118286] mem full: device_resume 577=0A[  359.118316] mem random: =
device_resume 577=0A[  359.118347] mem urandom: device_resume 577=0A[  359.=
118377] mem kmsg: device_resume 577=0A[  359.118408] tty tty: device_resume=
 577=0A[  359.118438] tty console: device_resume 577=0A[  359.118469] tty t=
ty0: device_resume 577=0A[  359.118499] vc vcs: device_resume 577=0A[  359.=
118560] vc vcsa: device_resume 577=0A[  359.118591] vc vcs1: device_resume =
577=0A[  359.118621] vc vcsa1: device_resume 577=0A[  359.118652] tty tty1:=
 device_resume 577=0A[  359.118682] tty tty2: device_resume 577=0A[  359.11=
8713] tty tty3: device_resume 577=0A[  359.118743] tty tty4: device_resume =
577=0A[  359.118774] tty tty5: device_resume 577=0A[  359.118804] tty tty6:=
 device_resume 577=0A[  359.118865] tty tty7: device_resume 577=0A[  359.11=
8896] tty tty8: device_resume 577=0A[  359.118926] tty tty9: device_resume =
577=0A[  359.118957] tty tty10: device_resume 577=0A[  359.118988] tty tty1=
1: device_resume 577=0A[  359.119018] tty tty12: device_resume 577=0A[  359=
=2E119049] tty tty13: device_resume 577=0A[  359.119079] tty tty14: device_=
resume 577=0A[  359.119140] tty tty15: device_resume 577=0A[  359.119171] t=
ty tty16: device_resume 577=0A[  359.119201] tty tty17: device_resume 577=
=0A[  359.119232] tty tty18: device_resume 577=0A[  359.119262] tty tty19: =
device_resume 577=0A[  359.119293] tty tty20: device_resume 577=0A[  359.11=
9323] tty tty21: device_resume 577=0A[  359.119354] tty tty22: device_resum=
e 577=0A[  359.119415] tty tty23: device_resume 577=0A[  359.119445] tty tt=
y24: device_resume 577=0A[  359.119476] tty tty25: device_resume 577=0A[  3=
59.119506] tty tty26: device_resume 577=0A[  359.119537] tty tty27: device_=
resume 577=0A[  359.119567] tty tty28: device_resume 577=0A[  359.119598] t=
ty tty29: device_resume 577=0A[  359.119628] tty tty30: device_resume 577=
=0A[  359.119689] tty tty31: device_resume 577=0A[  359.119720] tty tty32: =
device_resume 577=0A[  359.119750] tty tty33: device_resume 577=0A[  359.11=
9781] tty tty34: device_resume 577=0A[  359.119812] tty tty35: device_resum=
e 577=0A[  359.119842] tty tty36: device_resume 577=0A[  359.119873] tty tt=
y37: device_resume 577=0A[  359.119903] tty tty38: device_resume 577=0A[  3=
59.119964] tty tty39: device_resume 577=0A[  359.119995] tty tty40: device_=
resume 577=0A[  359.120025] tty tty41: device_resume 577=0A[  359.120056] t=
ty tty42: device_resume 577=0A[  359.120117] tty tty43: device_resume 577=
=0A[  359.120147] tty tty44: device_resume 577=0A[  359.120208] tty tty45: =
device_resume 577=0A[  359.120239] tty tty46: device_resume 577=0A[  359.12=
0269] tty tty47: device_resume 577=0A[  359.120300] tty tty48: device_resum=
e 577=0A[  359.120330] tty tty49: device_resume 577=0A[  359.120361] tty tt=
y50: device_resume 577=0A[  359.120391] tty tty51: device_resume 577=0A[  3=
59.120422] tty tty52: device_resume 577=0A[  359.120452] tty tty53: device_=
resume 577=0A[  359.120513] tty tty54: device_resume 577=0A[  359.120544] t=
ty tty55: device_resume 577=0A[  359.120574] tty tty56: device_resume 577=
=0A[  359.120697] tty tty57: device_resume 577=0A[  359.120727] tty tty58: =
device_resume 577=0A[  359.120758] tty tty59: device_resume 577=0A[  359.12=
0788] tty tty60: device_resume 577=0A[  359.120819] tty tty61: device_resum=
e 577=0A[  359.120849] tty tty62: device_resume 577=0A[  359.120910] tty tt=
y63: device_resume 577=0A[  359.120941]  clocksource: device_resume 577=0A[=
  359.120971] clocksource clocksource0: device_resume 577=0A[  359.121002] =
alarmtimer alarmtimer: device_resume 577=0A[  359.121032] event_source ARMv=
7 Cortex-A8: device_resume 577=0A[  359.121063] event_source breakpoint: de=
vice_resume 577=0A[  359.121093] event_source tracepoint: device_resume 577=
=0A[  359.121124] event_source software: device_resume 577=0A[  359.121185]=
 graphics fbcon: device_resume 577=0A[  359.121215] tty ptmx: device_resume=
 577=0A[  359.121246] serial8250 serial8250: device_resume 577=0A[  359.121=
276] tty ttyS0: device_resume 577=0A[  359.121307] tty ttyS1: device_resume=
 577=0A[  359.121337] tty ttyS2: device_resume 577=0A[  359.121398] tty tty=
S3: device_resume 577=0A[  359.121429] tty ttyO0: device_resume 577=0A[  35=
9.121459] tty ttyO1: device_resume 577=0A[  359.121490] tty ttyO2: device_r=
esume 577=0A[  359.121520] tty ttyO3: device_resume 577=0A[  359.121551] bd=
i 1:0: device_resume 577=0A[  359.121582] block ram0: device_resume 577=0A[=
  359.121612] bdi 1:1: device_resume 577=0A[  359.121673] block ram1: devic=
e_resume 577=0A[  359.121704] bdi 1:2: device_resume 577=0A[  359.121734] b=
lock ram2: device_resume 577=0A[  359.121765] bdi 1:3: device_resume 577=0A=
[  359.121795] block ram3: device_resume 577=0A[  359.121826] bdi 1:4: devi=
ce_resume 577=0A[  359.121856] block ram4: device_resume 577=0A[  359.12188=
7] bdi 1:5: device_resume 577=0A[  359.121917] block ram5: device_resume 57=
7=0A[  359.121978] bdi 1:6: device_resume 577=0A[  359.122009] block ram6: =
device_resume 577=0A[  359.122039] bdi 1:7: device_resume 577=0A[  359.1220=
70] block ram7: device_resume 577=0A[  359.122100] bdi 1:8: device_resume 5=
77=0A[  359.122131] block ram8: device_resume 577=0A[  359.122161] bdi 1:9:=
 device_resume 577=0A[  359.122192] block ram9: device_resume 577=0A[  359.=
122222] bdi 1:10: device_resume 577=0A[  359.122283] block ram10: device_re=
sume 577=0A[  359.122314] bdi 1:11: device_resume 577=0A[  359.122344] bloc=
k ram11: device_resume 577=0A[  359.122375] bdi 1:12: device_resume 577=0A[=
  359.122406] block ram12: device_resume 577=0A[  359.122436] bdi 1:13: dev=
ice_resume 577=0A[  359.122467] block ram13: device_resume 577=0A[  359.122=
497] bdi 1:14: device_resume 577=0A[  359.122558] block ram14: device_resum=
e 577=0A[  359.122589] bdi 1:15: device_resume 577=0A[  359.122619] block r=
am15: device_resume 577=0A[  359.122650] misc loop-control: device_resume 5=
77=0A[  359.122680] bdi 7:0: device_resume 577=0A[  359.122711] block loop0=
: device_resume 577=0A[  359.122741] bdi 7:1: device_resume 577=0A[  359.12=
2772] block loop1: device_resume 577=0A[  359.122833] bdi 7:2: device_resum=
e 577=0A[  359.122863] block loop2: device_resume 577=0A[  359.122894] bdi =
7:3: device_resume 577=0A[  359.122924] block loop3: device_resume 577=0A[ =
 359.122955] bdi 7:4: device_resume 577=0A[  359.122985] block loop4: devic=
e_resume 577=0A[  359.123016] bdi 7:5: device_resume 577=0A[  359.123046] b=
lock loop5: device_resume 577=0A[  359.123077] bdi 7:6: device_resume 577=
=0A[  359.123138] block loop6: device_resume 577=0A[  359.123168] bdi 7:7: =
device_resume 577=0A[  359.123199] block loop7: device_resume 577=0A[  359.=
123229] platform twl4030-codec: device_resume 577=0A[  359.123260] bdi mtd-=
unmap: device_resume 577=0A[  359.123291] bdi mtd-romap: device_resume 577=
=0A[  359.123321] bdi mtd-rwmap: device_resume 577=0A[  359.123352] spi_mas=
ter spi1: device_resume 577=0A[  359.123413] spi_master spi2: device_resume=
 577=0A[  359.123443] spi_master spi3: device_resume 577=0A[  359.123474] s=
pi_master spi4: device_resume 577=0A[  359.123504] usbmon usbmon0: device_r=
esume 577=0A[  359.123535] input mice: device_resume 577=0A[  359.123565] m=
isc psaux: device_resume 577=0A[  359.123596] input input0: device_resume 5=
77=0A[  359.123718] input event0: device_resume 577=0A[  359.123748] rtc rt=
c0: device_resume 577=0A[  359.123809] i2c i2c-1: master_xfer[0] W, addr=3D=
0x4b, len=3D1=0A[  359.123809] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, le=
n=3D1=0A[  359.123840] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  359.1239=
01] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  359=
=2E123901] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  359.123931] omap=
_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.123962] omap_i2c omap_i2c.1: oma=
p_i2c_isr 886: mask 601f stat 1510=0A[  359.123962] omap_i2c omap_i2c.1: om=
ap_i2c_isr 889=0A[  359.123992] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  =
359.124023] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  3=
59.124084] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.124114] om=
ap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  359.124145] omap_i2c omap_i2c.=
1: omap_i2c_isr_thread 1033=0A[  359.124176] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[  359.124176] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1104=0A[  359.124206] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.12=
4206] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.124237] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 0=0A[  359.124237] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[  359.124267] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0004)=0A[  359.124298] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[  359.124450] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, s=
top: 1=0A[  359.124450] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  359=
=2E124511] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.124542] omap_i2c =
omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  359.124542] omap_i2c=
 omap_i2c.1: omap_i2c_isr 889=0A[  359.124572] omap_i2c omap_i2c.1: omap_i2=
c_isr 894=0A[  359.124603] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_p=
rocess 1=0A[  359.124633] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ =
 359.124633] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  359.124664] oma=
p_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.124694] omap_i2c omap_i2c.1=
: omap_i2c_isr_thread 1033=0A[  359.124755] omap_i2c omap_i2c.1: omap_i2c_x=
fer 663=0A[  359.124786] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=
=0A[  359.124816] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  359.124847] o=
map_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[  359.1248=
47] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  359.124877] omap_i2c om=
ap_i2c.1: omap_i2c_isr 880=0A[  359.124908] omap_i2c omap_i2c.1: omap_i2c_i=
sr 886: mask 601f stat 1110=0A[  359.124908] omap_i2c omap_i2c.1: omap_i2c_=
isr 889=0A[  359.124938] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.124=
969] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  359.1249=
99] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.125030] omap_i2c =
omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  359.125030] omap_i2c omap_i2c.1: omap=
_i2c_isr_thread 1033=0A[  359.125091] omap_i2c omap_i2c.1: omap_i2c_isr 880=
=0A[  359.125122] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 010=
4=0A[  359.125122] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.125152] o=
map_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.125152] =3D=3D=3D> irq_wake_t=
hread 139: IRQ 72 wake_up_process 1=0A[  359.125183] omap_i2c omap_i2c.1: o=
map_i2c_isr_thread 908=0A[  359.125213] omap_i2c omap_i2c.1: IRQ (ISR =3D 0=
x0004)=0A[  359.125244] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  =
359.125305] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  359.125335] i2c i2c=
-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  359.125335] i2c i2c-1: mast=
er_xfer[1] R, addr=3D0x4b, len=3D6=0A[  359.125366] omap_i2c omap_i2c.1: om=
ap_i2c_xfer 626=0A[  359.125396] omap_i2c omap_i2c.1: addr: 0x004b, len: 1,=
 flags: 0x0, stop: 0=0A[  359.125427] omap_i2c omap_i2c.1: omap_i2c_xfer_ms=
g 537=0A[  359.125457] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.12545=
7] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  359.1254=
88] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.125488] omap_i2c omap_i2=
c.1: omap_i2c_isr 894=0A[  359.125518] =3D=3D=3D> irq_wake_thread 139: IRQ =
72 wake_up_process 1=0A[  359.125549] omap_i2c omap_i2c.1: omap_i2c_isr_thr=
ead 908=0A[  359.125579] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  359=
=2E125610] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.125640] o=
map_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.125640] omap_i2c omap_i2c.1: =
omap_i2c_isr 886: mask 601f stat 1104=0A[  359.125671] omap_i2c omap_i2c.1:=
 omap_i2c_isr 889=0A[  359.125671] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A=
[  359.125701] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[=
  359.125701] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.125732]=
 omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.125762] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 1033=0A[  359.125823] omap_i2c omap_i2c.1: addr: =
0x004b, len: 6, flags: 0x1, stop: 1=0A[  359.125823] omap_i2c omap_i2c.1: o=
map_i2c_xfer_msg 537=0A[  359.125976] omap_i2c omap_i2c.1: omap_i2c_isr 880=
=0A[  359.126007] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 110=
8=0A[  359.126007] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.126037] o=
map_i2c omap_i2c.1: omap_i2c_isr 894=0A[  359.126068] =3D=3D=3D> irq_wake_t=
hread 139: IRQ 72 wake_up_process 1=0A[  359.126098] omap_i2c omap_i2c.1: o=
map_i2c_isr_thread 908=0A[  359.126129] omap_i2c omap_i2c.1: IRQ (ISR =3D 0=
x0008)=0A[  359.126129] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x2000)=0A[  359.=
126190] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.126190] omap=
_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.126220] omap_i2c omap_i2c.1: oma=
p_i2c_isr 886: mask 601f stat 0104=0A[  359.126251] omap_i2c omap_i2c.1: om=
ap_i2c_isr 889=0A[  359.126251] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  =
359.126281] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  3=
59.126281] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.126312] om=
ap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.126342] omap_i2c omap_i2c.=
1: omap_i2c_isr_thread 1033=0A[  359.126403] omap_i2c omap_i2c.1: omap_i2c_=
xfer 663=0A[  359.126434] i2c-dev i2c-1: device_resume 577=0A[  359.126464]=
 i2c-dev i2c-3: device_resume 577=0A[  359.126525] misc watchdog: device_re=
sume 577=0A[  359.126556] mmc_host mmc0: device_resume 577=0A[  359.126586]=
 oprofile-perf oprofile-perf.0: device_resume 577=0A[  359.126617] misc cpu=
_dma_latency: device_resume 577=0A[  359.126647] misc network_latency: devi=
ce_resume 577=0A[  359.126708] misc network_throughput: device_resume 577=
=0A[  359.126739] misc ubi_ctrl: device_resume 577=0A[  359.126770] input i=
nput1: device_resume 577=0A[  359.126800] input event1: device_resume 577=
=0A[  359.126831] mmcblk mmc0:0002: device_resume 577=0A[  359.126892] bdi =
179:0: device_resume 577=0A[  359.126953] block mmcblk0: device_resume 577=
=0A[  359.126983] block mmcblk0p1: device_resume 577=0A[  359.127014] block=
 mmcblk0p2: device_resume 577=0A[  359.127044] vc vcs3: device_resume 577=
=0A[  359.127075] vc vcsa3: device_resume 577=0A[  359.127105] vc vcs2: dev=
ice_resume 577=0A[  359.127166] vc vcsa2: device_resume 577=0A[  359.127197=
] vc vcs5: device_resume 577=0A[  359.127227] vc vcsa5: device_resume 577=
=0A[  359.127258] vc vcs4: device_resume 577=0A[  359.127288] vc vcsa4: dev=
ice_resume 577=0A[  359.127319] vc vcs6: device_resume 577=0A[  359.127349]=
 vc vcsa6: device_resume 577=0A[  359.127380] vc vcs63: device_resume 577=
=0A[  359.127410] vc vcsa63: device_resume 577=0A[  359.127471] PM: resume =
of devices complete after 1143.981 msecs=0A[  359.133209] PM: Finishing wak=
eup.=0A[  359.133209] Restarting tasks ... done.=0A[  359.153045] i2c i2c-1=
: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[  359.153106] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer 626=0A[  359.153137] omap_i2c omap_i2c.1: addr: 0x004b,=
 len: 2, flags: 0x0, stop: 1=0A[  359.153167] omap_i2c omap_i2c.1: omap_i2c=
_xfer_msg 537=0A[  359.153198] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  3=
59.153198] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1510=0A[  =
359.153228] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  359.153228] omap_i2c=
 omap_i2c.1: omap_i2c_isr 894=0A[  359.153289] =3D=3D=3D> irq_wake_thread 1=
39: IRQ 72 wake_up_process 1=0A[  359.153350] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 908=0A[  359.153381] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=
=0A[  359.153381] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.15=
3442] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  359.153472] omap_i2c omap_=
i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[  359.153503] omap_i2c omap=
_i2c.1: omap_i2c_isr 889=0A[  359.153503] omap_i2c omap_i2c.1: omap_i2c_isr=
 894=0A[  359.153533] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proces=
s 1=0A[  359.153564] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  359.=
153594] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  359.153625] omap_i2c=
 omap_i2c.1: omap_i2c_isr_thread 1033=0A[  359.153686] omap_i2c omap_i2c.1:=
 omap_i2c_xfer 663=0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroo=
t@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen=
:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0A=
root@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@ar=
wen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# =
=0Aroot@arwen:~# echo mem > /sy/=08 =08s/power/str=07=08 =08ate =0A=0A-bash=
: echo: write error: Operation not permitted=0Aroot@arwen:~# =0Aroot@arwen:=
~# ls=0Aprepare  spidev_test=0Aroot@arwen:~# dmesg=0A[  688.471191] platfor=
m omap-mcbsp.4: device_resume 577=0A[  688.471221] platform omap-mcbsp.5: d=
evice_resume 577=0A[  688.471252] platform omapfb: device_resume 577=0A[  6=
88.471313] cpu cpu0: device_resume 577=0A[  688.471343] omap_wdt omap_wdt: =
device_resume 577=0A[  688.471374] arm-pmu arm-pmu: device_resume 577=0A[  =
688.471405] bdi default: device_resume 577=0A[  688.471435] omap-dma-engine=
 omap-dma-engine: device_resume 577=0A[  688.471466] dma dma0chan0: device_=
resume 577=0A[  688.471527] dma dma0chan1: device_resume 577=0A[  688.47155=
7] dma dma0chan2: device_resume 577=0A[  688.471588] dma dma0chan3: device_=
resume 577=0A[  688.471649] dma dma0chan4: device_resume 577=0A[  688.47174=
0] dma dma0chan5: device_resume 577=0A[  688.471801] dma dma0chan6: device_=
resume 577=0A[  688.471832] dma dma0chan7: device_resume 577=0A[  688.47186=
2] dma dma0chan8: device_resume 577=0A[  688.471893] dma dma0chan9: device_=
resume 577=0A[  688.471923] dma dma0chan10: device_resume 577=0A[  688.4719=
54] dma dma0chan11: device_resume 577=0A[  688.471984] dma dma0chan12: devi=
ce_resume 577=0A[  688.472015] dma dma0chan13: device_resume 577=0A[  688.4=
72076] dma dma0chan14: device_resume 577=0A[  688.472106] dma dma0chan15: d=
evice_resume 577=0A[  688.472137] dma dma0chan16: device_resume 577=0A[  68=
8.472167] dma dma0chan17: device_resume 577=0A[  688.472198] dma dma0chan18=
: device_resume 577=0A[  688.472229] dma dma0chan19: device_resume 577=0A[ =
 688.472259] dma dma0chan20: device_resume 577=0A[  688.472290] dma dma0cha=
n21: device_resume 577=0A[  688.472320] dma dma0chan22: device_resume 577=
=0A[  688.472351] dma dma0chan23: device_resume 577=0A[  688.472381] dma dm=
a0chan24: device_resume 577=0A[  688.472442] dma dma0chan25: device_resume =
577=0A[  688.472473] dma dma0chan26: device_resume 577=0A[  688.472503] dma=
 dma0chan27: device_resume 577=0A[  688.472534] dma dma0chan28: device_resu=
me 577=0A[  688.472564] dma dma0chan29: device_resume 577=0A[  688.472595] =
dma dma0chan30: device_resume 577=0A[  688.472625] dma dma0chan31: device_r=
esume 577=0A[  688.472656] dma dma0chan32: device_resume 577=0A[  688.47268=
6] dma dma0chan33: device_resume 577=0A[  688.472717] dma dma0chan34: devic=
e_resume 577=0A[  688.472747] dma dma0chan35: device_resume 577=0A[  688.47=
2808] dma dma0chan36: device_resume 577=0A[  688.472839] dma dma0chan37: de=
vice_resume 577=0A[  688.472869] dma dma0chan38: device_resume 577=0A[  688=
=2E472900] dma dma0chan39: device_resume 577=0A[  688.472930] dma dma0chan4=
0: device_resume 577=0A[  688.472961] dma dma0chan41: device_resume 577=0A[=
  688.472991] dma dma0chan42: device_resume 577=0A[  688.473022] dma dma0ch=
an43: device_resume 577=0A[  688.473052] dma dma0chan44: device_resume 577=
=0A[  688.473083] dma dma0chan45: device_resume 577=0A[  688.473114] dma dm=
a0chan46: device_resume 577=0A[  688.473175] dma dma0chan47: device_resume =
577=0A[  688.473205] dma dma0chan48: device_resume 577=0A[  688.473236] dma=
 dma0chan49: device_resume 577=0A[  688.473266] dma dma0chan50: device_resu=
me 577=0A[  688.473297] dma dma0chan51: device_resume 577=0A[  688.473327] =
dma dma0chan52: device_resume 577=0A[  688.473358] dma dma0chan53: device_r=
esume 577=0A[  688.473388] dma dma0chan54: device_resume 577=0A[  688.47341=
9] dma dma0chan55: device_resume 577=0A[  688.473449] dma dma0chan56: devic=
e_resume 577=0A[  688.473510] dma dma0chan57: device_resume 577=0A[  688.47=
3541] dma dma0chan58: device_resume 577=0A[  688.473571] dma dma0chan59: de=
vice_resume 577=0A[  688.473602] dma dma0chan60: device_resume 577=0A[  688=
=2E473632] dma dma0chan61: device_resume 577=0A[  688.473663] dma dma0chan6=
2: device_resume 577=0A[  688.473693] dma dma0chan63: device_resume 577=0A[=
  688.473724] dma dma0chan64: device_resume 577=0A[  688.473754] dma dma0ch=
an65: device_resume 577=0A[  688.473785] dma dma0chan66: device_resume 577=
=0A[  688.473846] dma dma0chan67: device_resume 577=0A[  688.473876] dma dm=
a0chan68: device_resume 577=0A[  688.473907] dma dma0chan69: device_resume =
577=0A[  688.473937] dma dma0chan70: device_resume 577=0A[  688.473968] dma=
 dma0chan71: device_resume 577=0A[  688.473999] dma dma0chan72: device_resu=
me 577=0A[  688.474029] dma dma0chan73: device_resume 577=0A[  688.474060] =
dma dma0chan74: device_resume 577=0A[  688.474090] dma dma0chan75: device_r=
esume 577=0A[  688.474121] dma dma0chan76: device_resume 577=0A[  688.47415=
1] dma dma0chan77: device_resume 577=0A[  688.474212] dma dma0chan78: devic=
e_resume 577=0A[  688.474243] dma dma0chan79: device_resume 577=0A[  688.47=
4273] dma dma0chan80: device_resume 577=0A[  688.474304] dma dma0chan81: de=
vice_resume 577=0A[  688.474334] dma dma0chan82: device_resume 577=0A[  688=
=2E474365] dma dma0chan83: device_resume 577=0A[  688.474395] dma dma0chan8=
4: device_resume 577=0A[  688.474426] dma dma0chan85: device_resume 577=0A[=
  688.474456] dma dma0chan86: device_resume 577=0A[  688.474487] dma dma0ch=
an87: device_resume 577=0A[  688.474517] dma dma0chan88: device_resume 577=
=0A[  688.474578] dma dma0chan89: device_resume 577=0A[  688.474609] dma dm=
a0chan90: device_resume 577=0A[  688.474639] dma dma0chan91: device_resume =
577=0A[  688.474670] dma dma0chan92: device_resume 577=0A[  688.474700] dma=
 dma0chan93: device_resume 577=0A[  688.474731] dma dma0chan94: device_resu=
me 577=0A[  688.474761] dma dma0chan95: device_resume 577=0A[  688.474792] =
dma dma0chan96: device_resume 577=0A[  688.474822] dma dma0chan97: device_r=
esume 577=0A[  688.474853] dma dma0chan98: device_resume 577=0A[  688.47491=
4] dma dma0chan99: device_resume 577=0A[  688.474945] dma dma0chan100: devi=
ce_resume 577=0A[  688.474975] dma dma0chan101: device_resume 577=0A[  688.=
475006] dma dma0chan102: device_resume 577=0A[  688.475036] dma dma0chan103=
: device_resume 577=0A[  688.475067] dma dma0chan104: device_resume 577=0A[=
  688.475097] dma dma0chan105: device_resume 577=0A[  688.475128] dma dma0c=
han106: device_resume 577=0A[  688.475158] dma dma0chan107: device_resume 5=
77=0A[  688.475189] dma dma0chan108: device_resume 577=0A[  688.475250] dma=
 dma0chan109: device_resume 577=0A[  688.475280] dma dma0chan110: device_re=
sume 577=0A[  688.475311] dma dma0chan111: device_resume 577=0A[  688.47534=
1] dma dma0chan112: device_resume 577=0A[  688.475372] dma dma0chan113: dev=
ice_resume 577=0A[  688.475402] dma dma0chan114: device_resume 577=0A[  688=
=2E475433] dma dma0chan115: device_resume 577=0A[  688.475463] dma dma0chan=
116: device_resume 577=0A[  688.475494] dma dma0chan117: device_resume 577=
=0A[  688.475524] dma dma0chan118: device_resume 577=0A[  688.475585] dma d=
ma0chan119: device_resume 577=0A[  688.475616] dma dma0chan120: device_resu=
me 577=0A[  688.475646] dma dma0chan121: device_resume 577=0A[  688.475677]=
 dma dma0chan122: device_resume 577=0A[  688.475708] dma dma0chan123: devic=
e_resume 577=0A[  688.475738] dma dma0chan124: device_resume 577=0A[  688.4=
75769] dma dma0chan125: device_resume 577=0A[  688.475799] dma dma0chan126:=
 device_resume 577=0A[  688.475830] i2c i2c-1: device_resume 577=0A[  688.4=
75891] twl 1-0048: device_resume 577=0A[  688.475921] platform twl: device_=
resume 577=0A[  688.475952] dummy 1-0049: device_resume 577=0A[  688.475982=
] dummy 1-004a: device_resume 577=0A[  688.476013] dummy 1-004b: device_res=
ume 577=0A[  688.476043] twl4030_gpio twl4030_gpio: device_resume 577=0A[  =
688.476074] gpio gpiochip492: device_resume 577=0A[  688.476135] omap_hsmmc=
 omap_hsmmc.0: device_resume 577=0A[  688.476135] omap_hsmmc omap_hsmmc.0: =
_od_resume 884=0A[  688.476440] i2c i2c-1: master_xfer[0] W, addr=3D0x49, l=
en=3D4=0A[  688.476470] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  688.476=
501] omap_i2c omap_i2c.1: addr: 0x0049, len: 4, flags: 0x0, stop: 1=0A[  68=
8.476531] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  688.476562] omap_=
i2c omap_i2c.1: omap_i2c_isr 880=0A[  688.476593] omap_i2c omap_i2c.1: omap=
_i2c_isr 886: mask 601f stat 1510=0A[  688.476593] omap_i2c omap_i2c.1: oma=
p_i2c_isr 889=0A[  688.476623] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  6=
88.476654] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  68=
8.476745] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  688.476745] oma=
p_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  688.476776] omap_i2c omap_i2c.1=
: omap_i2c_isr_thread 1033=0A[  688.476806] omap_i2c omap_i2c.1: omap_i2c_i=
sr 880=0A[  688.476837] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f st=
at 0104=0A[  688.476837] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  688.476=
867] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  688.476867] =3D=3D=3D> irq_=
wake_thread 139: IRQ 72 wake_up_process 0=0A[  688.476898] omap_i2c omap_i2=
c.1: omap_i2c_isr_thread 908=0A[  688.476928] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x0004)=0A[  688.476959] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[  688.477233] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  688.477294] i=
2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  688.477325] i2c i2c-1=
: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[  688.477355] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer 626=0A[  688.477386] omap_i2c omap_i2c.1: addr: 0x004b,=
 len: 1, flags: 0x0, stop: 0=0A[  688.477386] omap_i2c omap_i2c.1: omap_i2c=
_xfer_msg 537=0A[  688.477416] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  6=
88.477447] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  =
688.477447] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  688.477478] omap_i2c=
 omap_i2c.1: omap_i2c_isr 894=0A[  688.477508] =3D=3D=3D> irq_wake_thread 1=
39: IRQ 72 wake_up_process 1=0A[  688.477569] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 908=0A[  688.477569] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=
=0A[  688.477600] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.47=
7630] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  688.477661] omap_i2c omap_=
i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  688.477661] omap_i2c omap=
_i2c.1: omap_i2c_isr 889=0A[  688.477691] omap_i2c omap_i2c.1: omap_i2c_isr=
 894=0A[  688.477691] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proces=
s 0=0A[  688.477722] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  688.=
477722] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  688.477752] omap_i2c=
 omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.477813] omap_i2c omap_i2c.1:=
 addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[  688.477844] omap_i2c omap_i=
2c.1: omap_i2c_xfer_msg 537=0A[  688.477905] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[  688.477935] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 0108=0A[  688.477935] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  688.47=
7966] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  688.477996] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[  688.478027] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[  688.478027] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0008)=0A[  688.478057] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A=
[  688.478088] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.47814=
9] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  688.478179] i2c i2c-1: maste=
r_xfer[0] W, addr=3D0x4b, len=3D1=0A[  688.478210] i2c i2c-1: master_xfer[1=
] R, addr=3D0x4b, len=3D1=0A[  688.478210] omap_i2c omap_i2c.1: omap_i2c_xf=
er 626=0A[  688.478240] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0=
x0, stop: 0=0A[  688.478271] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[=
  688.478301] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  688.478301] omap_i=
2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  688.478332] omap_=
i2c omap_i2c.1: omap_i2c_isr 889=0A[  688.478332] omap_i2c omap_i2c.1: omap=
_i2c_isr 894=0A[  688.478363] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_u=
p_process 1=0A[  688.478454] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=
=0A[  688.478454] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  688.478485=
] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.478515] omap_i2c o=
map_i2c.1: omap_i2c_isr 880=0A[  688.478515] omap_i2c omap_i2c.1: omap_i2c_=
isr 886: mask 601f stat 1104=0A[  688.478546] omap_i2c omap_i2c.1: omap_i2c=
_isr 889=0A[  688.478546] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  688.47=
8576] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  688.478=
607] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  688.478607] omap_i2c=
 omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  688.478637] omap_i2c omap_i2c.1: oma=
p_i2c_isr_thread 1033=0A[  688.478698] omap_i2c omap_i2c.1: addr: 0x004b, l=
en: 1, flags: 0x1, stop: 1=0A[  688.478729] omap_i2c omap_i2c.1: omap_i2c_x=
fer_msg 537=0A[  688.478759] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  688=
=2E478790] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  =
688.478790] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  688.478820] omap_i2c=
 omap_i2c.1: omap_i2c_isr 894=0A[  688.478851] =3D=3D=3D> irq_wake_thread 1=
39: IRQ 72 wake_up_process 1=0A[  688.478881] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 908=0A[  688.478881] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=
=0A[  688.478912] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  688.478942=
] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.479003] omap_i2c o=
map_i2c.1: omap_i2c_xfer 663=0A[  688.479034] i2c i2c-1: master_xfer[0] W, =
addr=3D0x4b, len=3D1=0A[  688.479034] i2c i2c-1: master_xfer[1] R, addr=3D0=
x4b, len=3D1=0A[  688.479064] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  6=
88.479095] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=
=0A[  688.479125] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  688.47915=
6] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  688.479156] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 886: mask 601f stat 1110=0A[  688.479187] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[  688.479187] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[  688.479217] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[  688.479248] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  688.4=
79278] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  688.479309] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.479339] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[  688.479370] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 1104=0A[  688.479370] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[  688.479400] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  688.479400] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  688.479431] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  688.479461] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[  688.479553] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[  688.479614] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, =
flags: 0x1, stop: 1=0A[  688.479644] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[  688.479675] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  688.479705=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  688.47973=
6] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  688.479736] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[  688.479766] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[  688.479797] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[  688.479827] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  68=
8.479827] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  688.479858] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.479919] omap_i2c omap_i2c.=
1: omap_i2c_xfer 663=0A[  688.479949] i2c i2c-1: master_xfer[0] W, addr=3D0=
x4b, len=3D2=0A[  688.479980] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  6=
88.480010] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=
=0A[  688.480010] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  688.48004=
1] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  688.480072] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 886: mask 601f stat 1110=0A[  688.480072] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[  688.480102] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[  688.480133] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[  688.480163] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  688.4=
80194] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  688.480194] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.480224] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[  688.480255] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 0104=0A[  688.480255] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[  688.480285] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  688.480285] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  688.480316] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  688.480346] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[  688.480377] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[  688.480407] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ =
 688.480560] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  688.480=
560] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[  688.480590] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  688.480621] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  688.480621] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[  688.480651] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[  688.480682] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[  688.480682] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  688.48=
0712] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  688.480743] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[  688.480773] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[  688.480804] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[  688.480804] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[  688.480834] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  688.480865] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  688.480865] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  688.480895] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[  688.480926] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[  688.480926] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[  688.480957] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  688.480=
987] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.481018] omap_i2=
c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[  688.481048] om=
ap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  688.481109] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 880=0A[  688.481109] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 0108=0A[  688.481140] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[  688.481140] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  688.481170]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  688.481201] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  688.481231] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0008)=0A[  688.481231] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x0004)=0A[  688.481262] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[  688.481323] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  688.481353] i=
2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  688.481384] i2c i2c-1=
: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[  688.481384] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer 626=0A[  688.481414] omap_i2c omap_i2c.1: addr: 0x004b,=
 len: 1, flags: 0x0, stop: 0=0A[  688.481445] omap_i2c omap_i2c.1: omap_i2c=
_xfer_msg 537=0A[  688.481475] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  6=
88.481475] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  =
688.481506] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  688.481536] omap_i2c=
 omap_i2c.1: omap_i2c_isr 894=0A[  688.481536] =3D=3D=3D> irq_wake_thread 1=
39: IRQ 72 wake_up_process 1=0A[  688.481597] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 908=0A[  688.481597] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=
=0A[  688.481628] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.48=
1658] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  688.481658] omap_i2c omap_=
i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  688.481689] omap_i2c omap=
_i2c.1: omap_i2c_isr 889=0A[  688.481689] omap_i2c omap_i2c.1: omap_i2c_isr=
 894=0A[  688.481719] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proces=
s 0=0A[  688.481750] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  688.=
481750] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  688.481781] omap_i2c=
 omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.481842] omap_i2c omap_i2c.1:=
 addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[  688.481872] omap_i2c omap_i=
2c.1: omap_i2c_xfer_msg 537=0A[  688.481903] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[  688.481933] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 0108=0A[  688.481933] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  688.48=
1964] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  688.481994] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[  688.482025] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[  688.482025] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0008)=0A[  688.482055] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A=
[  688.482086] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.48214=
7] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[  688.482177] i2c i2c-1: maste=
r_xfer[0] W, addr=3D0x4b, len=3D2=0A[  688.482177] omap_i2c omap_i2c.1: oma=
p_i2c_xfer 626=0A[  688.482208] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, =
flags: 0x0, stop: 1=0A[  688.482238] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[  688.482269] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  688.482269=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  688.48229=
9] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  688.482299] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[  688.482330] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[  688.482391] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[  688.482391] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  68=
8.482421] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  688.482452] om=
ap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  688.482452] omap_i2c omap_i2c.1: o=
map_i2c_isr 886: mask 601f stat 0104=0A[  688.482482] omap_i2c omap_i2c.1: =
omap_i2c_isr 889=0A[  688.482482] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[=
  688.482513] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[ =
 688.482543] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  688.482543] =
omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  688.482574] omap_i2c omap_i2=
c.1: omap_i2c_isr_thread 1033=0A[  688.482635] omap_i2c omap_i2c.1: omap_i2=
c_xfer 663=0A[  689.600585] twl_rtc twl_rtc: device_resume 577=0A[  689.600=
616] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[  689.600646] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  689.600677] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[  689.600708] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[  689.600738] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[  689.600738] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[  689.600769] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  689.60=
0769] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  689.600830] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[  689.600860] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[  689.600891] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[  689.600921] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[  689.600952] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  689.600952] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[  689.600982] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  689.600982] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[  689.601013] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[  689.601043] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[  689.601043] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  689.601=
074] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  689.601135] omap_i2=
c omap_i2c.1: omap_i2c_xfer 663=0A[  689.601165] platform twl4030_wdt: devi=
ce_resume 577=0A[  689.601226] twl4030_pwrbutton twl4030_pwrbutton: device_=
resume 577=0A[  689.601257] twl4030-audio twl4030-audio: device_resume 577=
=0A[  689.601287] twl_reg twl_reg.0: device_resume 577=0A[  689.601318] reg=
ulator regulator.1: device_resume 577=0A[  689.601348] twl_reg twl_reg.1: d=
evice_resume 577=0A[  689.601379] regulator regulator.2: device_resume 577=
=0A[  689.601440] twl_reg twl_reg.6: device_resume 577=0A[  689.601470] reg=
ulator regulator.3: device_resume 577=0A[  689.601501] twl_reg twl_reg.3: d=
evice_resume 577=0A[  689.601531] regulator regulator.4: device_resume 577=
=0A[  689.601562] twl_reg twl_reg.5: device_resume 577=0A[  689.601593] reg=
ulator regulator.5: device_resume 577=0A[  689.601623] twl_reg twl_reg.8: d=
evice_resume 577=0A[  689.601654] regulator regulator.6: device_resume 577=
=0A[  689.601684] i2c i2c-3: device_resume 577=0A[  689.601745] i2c 3-0050:=
 device_resume 577=0A[  689.601776] net lo: device_resume 577=0A[  689.6018=
06] mem mem: device_resume 577=0A[  689.601837] mem kmem: device_resume 577=
=0A[  689.601867] mem null: device_resume 577=0A[  689.601898] mem zero: de=
vice_resume 577=0A[  689.601928] mem full: device_resume 577=0A[  689.60198=
9] mem random: device_resume 577=0A[  689.602020] mem urandom: device_resum=
e 577=0A[  689.602050] mem kmsg: device_resume 577=0A[  689.602081] tty tty=
: device_resume 577=0A[  689.602111] tty console: device_resume 577=0A[  68=
9.602142] tty tty0: device_resume 577=0A[  689.602172] vc vcs: device_resum=
e 577=0A[  689.602203] vc vcsa: device_resume 577=0A[  689.602264] vc vcs1:=
 device_resume 577=0A[  689.602294] vc vcsa1: device_resume 577=0A[  689.60=
2325] tty tty1: device_resume 577=0A[  689.602355] tty tty2: device_resume =
577=0A[  689.602386] tty tty3: device_resume 577=0A[  689.602416] tty tty4:=
 device_resume 577=0A[  689.602447] tty tty5: device_resume 577=0A[  689.60=
2478] tty tty6: device_resume 577=0A[  689.602508] tty tty7: device_resume =
577=0A[  689.602569] tty tty8: device_resume 577=0A[  689.602600] tty tty9:=
 device_resume 577=0A[  689.602630] tty tty10: device_resume 577=0A[  689.6=
02661] tty tty11: device_resume 577=0A[  689.602691] tty tty12: device_resu=
me 577=0A[  689.602722] tty tty13: device_resume 577=0A[  689.602752] tty t=
ty14: device_resume 577=0A[  689.602783] tty tty15: device_resume 577=0A[  =
689.602844] tty tty16: device_resume 577=0A[  689.602874] tty tty17: device=
_resume 577=0A[  689.602905] tty tty18: device_resume 577=0A[  689.602935] =
tty tty19: device_resume 577=0A[  689.602966] tty tty20: device_resume 577=
=0A[  689.602996] tty tty21: device_resume 577=0A[  689.603027] tty tty22: =
device_resume 577=0A[  689.603057] tty tty23: device_resume 577=0A[  689.60=
3118] tty tty24: device_resume 577=0A[  689.603149] tty tty25: device_resum=
e 577=0A[  689.603179] tty tty26: device_resume 577=0A[  689.603210] tty tt=
y27: device_resume 577=0A[  689.603240] tty tty28: device_resume 577=0A[  6=
89.603271] tty tty29: device_resume 577=0A[  689.603301] tty tty30: device_=
resume 577=0A[  689.603332] tty tty31: device_resume 577=0A[  689.603363] t=
ty tty32: device_resume 577=0A[  689.603424] tty tty33: device_resume 577=
=0A[  689.603454] tty tty34: device_resume 577=0A[  689.603485] tty tty35: =
device_resume 577=0A[  689.603515] tty tty36: device_resume 577=0A[  689.60=
3546] tty tty37: device_resume 577=0A[  689.603576] tty tty38: device_resum=
e 577=0A[  689.603607] tty tty39: device_resume 577=0A[  689.603637] tty tt=
y40: device_resume 577=0A[  689.603698] tty tty41: device_resume 577=0A[  6=
89.603729] tty tty42: device_resume 577=0A[  689.603759] tty tty43: device_=
resume 577=0A[  689.603790] tty tty44: device_resume 577=0A[  689.603820] t=
ty tty45: device_resume 577=0A[  689.603851] tty tty46: device_resume 577=
=0A[  689.603912] tty tty47: device_resume 577=0A[  689.603973] tty tty48: =
device_resume 577=0A[  689.604003] tty tty49: device_resume 577=0A[  689.60=
4034] tty tty50: device_resume 577=0A[  689.604064] tty tty51: device_resum=
e 577=0A[  689.604095] tty tty52: device_resume 577=0A[  689.604125] tty tt=
y53: device_resume 577=0A[  689.604156] tty tty54: device_resume 577=0A[  6=
89.604187] tty tty55: device_resume 577=0A[  689.604248] tty tty56: device_=
resume 577=0A[  689.604278] tty tty57: device_resume 577=0A[  689.604309] t=
ty tty58: device_resume 577=0A[  689.604339] tty tty59: device_resume 577=
=0A[  689.604461] tty tty60: device_resume 577=0A[  689.604492] tty tty61: =
device_resume 577=0A[  689.604522] tty tty62: device_resume 577=0A[  689.60=
4553] tty tty63: device_resume 577=0A[  689.604583]  clocksource: device_re=
sume 577=0A[  689.604614] clocksource clocksource0: device_resume 577=0A[  =
689.604644] alarmtimer alarmtimer: device_resume 577=0A[  689.604705] event=
_source ARMv7 Cortex-A8: device_resume 577=0A[  689.604736] event_source br=
eakpoint: device_resume 577=0A[  689.604766] event_source tracepoint: devic=
e_resume 577=0A[  689.604797] event_source software: device_resume 577=0A[ =
 689.604827] graphics fbcon: device_resume 577=0A[  689.604858] tty ptmx: d=
evice_resume 577=0A[  689.604888] serial8250 serial8250: device_resume 577=
=0A[  689.604949] tty ttyS0: device_resume 577=0A[  689.604980] tty ttyS1: =
device_resume 577=0A[  689.605010] tty ttyS2: device_resume 577=0A[  689.60=
5041] tty ttyS3: device_resume 577=0A[  689.605072] tty ttyO0: device_resum=
e 577=0A[  689.605133] tty ttyO1: device_resume 577=0A[  689.605163] tty tt=
yO2: device_resume 577=0A[  689.605194] tty ttyO3: device_resume 577=0A[  6=
89.605224] bdi 1:0: device_resume 577=0A[  689.605255] block ram0: device_r=
esume 577=0A[  689.605285] bdi 1:1: device_resume 577=0A[  689.605316] bloc=
k ram1: device_resume 577=0A[  689.605346] bdi 1:2: device_resume 577=0A[  =
689.605377] block ram2: device_resume 577=0A[  689.605438] bdi 1:3: device_=
resume 577=0A[  689.605468] block ram3: device_resume 577=0A[  689.605499] =
bdi 1:4: device_resume 577=0A[  689.605529] block ram4: device_resume 577=
=0A[  689.605560] bdi 1:5: device_resume 577=0A[  689.605590] block ram5: d=
evice_resume 577=0A[  689.605621] bdi 1:6: device_resume 577=0A[  689.60565=
1] block ram6: device_resume 577=0A[  689.605712] bdi 1:7: device_resume 57=
7=0A[  689.605743] block ram7: device_resume 577=0A[  689.605773] bdi 1:8: =
device_resume 577=0A[  689.605804] block ram8: device_resume 577=0A[  689.6=
05834] bdi 1:9: device_resume 577=0A[  689.605865] block ram9: device_resum=
e 577=0A[  689.605895] bdi 1:10: device_resume 577=0A[  689.605926] block r=
am10: device_resume 577=0A[  689.605957] bdi 1:11: device_resume 577=0A[  6=
89.606018] block ram11: device_resume 577=0A[  689.606048] bdi 1:12: device=
_resume 577=0A[  689.606079] block ram12: device_resume 577=0A[  689.606109=
] bdi 1:13: device_resume 577=0A[  689.606140] block ram13: device_resume 5=
77=0A[  689.606170] bdi 1:14: device_resume 577=0A[  689.606201] block ram1=
4: device_resume 577=0A[  689.606231] bdi 1:15: device_resume 577=0A[  689.=
606262] block ram15: device_resume 577=0A[  689.606323] misc loop-control: =
device_resume 577=0A[  689.606353] bdi 7:0: device_resume 577=0A[  689.6063=
84] block loop0: device_resume 577=0A[  689.606414] bdi 7:1: device_resume =
577=0A[  689.606445] block loop1: device_resume 577=0A[  689.606475] bdi 7:=
2: device_resume 577=0A[  689.606506] block loop2: device_resume 577=0A[  6=
89.606536] bdi 7:3: device_resume 577=0A[  689.606597] block loop3: device_=
resume 577=0A[  689.606628] bdi 7:4: device_resume 577=0A[  689.606658] blo=
ck loop4: device_resume 577=0A[  689.606689] bdi 7:5: device_resume 577=0A[=
  689.606719] block loop5: device_resume 577=0A[  689.606750] bdi 7:6: devi=
ce_resume 577=0A[  689.606781] block loop6: device_resume 577=0A[  689.6068=
11] bdi 7:7: device_resume 577=0A[  689.606842] block loop7: device_resume =
577=0A[  689.606903] platform twl4030-codec: device_resume 577=0A[  689.606=
933] bdi mtd-unmap: device_resume 577=0A[  689.606964] bdi mtd-romap: devic=
e_resume 577=0A[  689.606994] bdi mtd-rwmap: device_resume 577=0A[  689.607=
025] spi_master spi1: device_resume 577=0A[  689.607055] spi_master spi2: d=
evice_resume 577=0A[  689.607086] spi_master spi3: device_resume 577=0A[  6=
89.607147] spi_master spi4: device_resume 577=0A[  689.607177] usbmon usbmo=
n0: device_resume 577=0A[  689.607208] input mice: device_resume 577=0A[  6=
89.607238] misc psaux: device_resume 577=0A[  689.607269] input input0: dev=
ice_resume 577=0A[  689.607391] input event0: device_resume 577=0A[  689.60=
7421] rtc rtc0: device_resume 577=0A[  689.607482] i2c i2c-1: master_xfer[0=
] W, addr=3D0x4b, len=3D1=0A[  689.607482] i2c i2c-1: master_xfer[1] R, add=
r=3D0x4b, len=3D1=0A[  689.607513] omap_i2c omap_i2c.1: omap_i2c_xfer 626=
=0A[  689.607543] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, st=
op: 0=0A[  689.607574] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  689.=
607604] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  689.607635] omap_i2c oma=
p_i2c.1: omap_i2c_isr 886: mask 601f stat 1510=0A[  689.607635] omap_i2c om=
ap_i2c.1: omap_i2c_isr 889=0A[  689.607666] omap_i2c omap_i2c.1: omap_i2c_i=
sr 894=0A[  689.607696] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proc=
ess 1=0A[  689.607757] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  68=
9.607788] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  689.607788] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  689.607818] omap_i2c omap_i2c.=
1: omap_i2c_isr 880=0A[  689.607849] omap_i2c omap_i2c.1: omap_i2c_isr 886:=
 mask 601f stat 1104=0A[  689.607879] omap_i2c omap_i2c.1: omap_i2c_isr 889=
=0A[  689.607879] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  689.607910] =
=3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[  689.607910] o=
map_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  689.607940] omap_i2c omap_=
i2c.1: IRQ (ISR =3D 0x0004)=0A[  689.607971] omap_i2c omap_i2c.1: omap_i2c_=
isr_thread 1033=0A[  689.608093] omap_i2c omap_i2c.1: addr: 0x004b, len: 1,=
 flags: 0x1, stop: 1=0A[  689.608123] omap_i2c omap_i2c.1: omap_i2c_xfer_ms=
g 537=0A[  689.608184] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  689.60821=
5] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[  689.6082=
15] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  689.608245] omap_i2c omap_i2=
c.1: omap_i2c_isr 894=0A[  689.608276] =3D=3D=3D> irq_wake_thread 139: IRQ =
72 wake_up_process 1=0A[  689.608306] omap_i2c omap_i2c.1: omap_i2c_isr_thr=
ead 908=0A[  689.608306] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[  689=
=2E608337] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  689.608367] omap_=
i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  689.608428] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer 663=0A[  689.608459] i2c i2c-1: master_xfer[0] W, addr=
=3D0x4b, len=3D2=0A[  689.608489] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A=
[  689.608520] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1=0A[  689.608520] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  689.608=
551] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  689.608581] omap_i2c omap_i=
2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[  689.608581] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[  689.608612] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[  689.608642] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[  689.608673] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  689.6=
08703] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[  689.608703] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[  689.608764] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[  689.608795] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 0104=0A[  689.608795] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[  689.608825] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  689.608825] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  689.608856] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  689.608886] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[  689.608917] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[  689.608978] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ =
 689.609008] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[  689.609=
008] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D6=0A[  689.609039] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[  689.609069] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[  689.609100] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[  689.609130] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[  689.609130] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[  689.609161] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  689.60=
9161] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  689.609191] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[  689.609222] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[  689.609252] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[  689.609283] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[  689.609313] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  689.609313] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[  689.609344] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[  689.609344] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[  689.609374] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[  689.609374] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[  689.609405] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  689.609=
436] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  689.609497] omap_i2=
c omap_i2c.1: addr: 0x004b, len: 6, flags: 0x1, stop: 1=0A[  689.609497] om=
ap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[  689.609649] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 880=0A[  689.609680] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 1108=0A[  689.609680] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[  689.609710] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[  689.609741]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[  689.609771] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[  689.609802] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0008)=0A[  689.609802] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x2000)=0A[  689.609832] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[  689.609863] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[  689.609893] om=
ap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[  689.609924] o=
map_i2c omap_i2c.1: omap_i2c_isr 889=0A[  689.609924] omap_i2c omap_i2c.1: =
omap_i2c_isr 894=0A[  689.609954] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wa=
ke_up_process 0=0A[  689.609954] omap_i2c omap_i2c.1: omap_i2c_isr_thread 9=
08=0A[  689.609985] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[  689.6100=
15] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[  689.610046] omap_i2c=
 omap_i2c.1: omap_i2c_xfer 663=0A[  689.610107] i2c-dev i2c-1: device_resum=
e 577=0A[  689.610137] i2c-dev i2c-3: device_resume 577=0A[  689.610198] mi=
sc watchdog: device_resume 577=0A[  689.610229] mmc_host mmc0: device_resum=
e 577=0A[  689.610260] oprofile-perf oprofile-perf.0: device_resume 577=0A[=
  689.610290] misc cpu_dma_latency: device_resume 577=0A[  689.610321] misc=
 network_latency: device_resume 577=0A[  689.610351] misc network_throughpu=
t: device_resume 577=0A[  689.610412] misc ubi_ctrl: device_resume 577=0A[ =
 689.610443] input input1: device_resume 577=0A[  689.610473] input event1:=
 device_resume 577=0A[  689.610504] mmcblk mmc0:0002: device_resume 577=0A[=
  689.610565] bdi 179:0: device_resume 577=0A[  689.610595] block mmcblk0: =
device_resume 577=0A[  689.610656] block mmcblk0p1: device_resume 577=0A[  =
689.610687] block mmcblk0p2: device_resume 577=0A[  689.610717] vc vcs3: de=
vice_resume 577=0A[  689.610748] vc vcsa3: device_resume 577=0A[  689.61077=
8] vc vcs2: device_resume 577=0A[  689.610809] vc vcsa2: device_resume 577=
=0A[  689.610839] vc vcs5: device_resume 577=0A[  689.610900] vc vcsa5: dev=
ice_resume 577=0A[  689.610931] vc vcs4: device_resume 577=0A[  689.610961]=
 vc vcsa4: device_resume 577=0A[  689.610992] vc vcs6: device_resume 577=0A=
[  689.611022] vc vcsa6: device_resume 577=0A[  689.611053] vc vcs63: devic=
e_resume 577=0A[  689.611083] vc vcsa63: device_resume 577=0A[  689.611145]=
 PM: resume of devices complete after 1143.829 msecs=0A[  689.616851] PM: F=
inishing wakeup.=0A[  689.616882] Restarting tasks ... done.=0Aroot@arwen:~=
# =07=0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:~# echo mem > /sys/pow=
er/t=08 =08state =0A=0A-bash: echo: write error: Operation not permitted=0A=
root@arwen:~# =0Aroot@arwen:~# dmesg=0A[ 1019.850860] platform omap-mcbsp.5=
: device_resume 577=0A[ 1019.850891] platform omapfb: device_resume 577=0A[=
 1019.850921] cpu cpu0: device_resume 577=0A[ 1019.850982] omap_wdt omap_wd=
t: device_resume 577=0A[ 1019.851013] arm-pmu arm-pmu: device_resume 577=0A=
[ 1019.851043] bdi default: device_resume 577=0A[ 1019.851104] omap-dma-eng=
ine omap-dma-engine: device_resume 577=0A[ 1019.851135] dma dma0chan0: devi=
ce_resume 577=0A[ 1019.851165] dma dma0chan1: device_resume 577=0A[ 1019.85=
1196] dma dma0chan2: device_resume 577=0A[ 1019.851226] dma dma0chan3: devi=
ce_resume 577=0A[ 1019.851348] dma dma0chan4: device_resume 577=0A[ 1019.85=
1409] dma dma0chan5: device_resume 577=0A[ 1019.851440] dma dma0chan6: devi=
ce_resume 577=0A[ 1019.851470] dma dma0chan7: device_resume 577=0A[ 1019.85=
1501] dma dma0chan8: device_resume 577=0A[ 1019.851531] dma dma0chan9: devi=
ce_resume 577=0A[ 1019.851562] dma dma0chan10: device_resume 577=0A[ 1019.8=
51593] dma dma0chan11: device_resume 577=0A[ 1019.851623] dma dma0chan12: d=
evice_resume 577=0A[ 1019.851654] dma dma0chan13: device_resume 577=0A[ 101=
9.851684] dma dma0chan14: device_resume 577=0A[ 1019.851715] dma dma0chan15=
: device_resume 577=0A[ 1019.851776] dma dma0chan16: device_resume 577=0A[ =
1019.851806] dma dma0chan17: device_resume 577=0A[ 1019.851837] dma dma0cha=
n18: device_resume 577=0A[ 1019.851867] dma dma0chan19: device_resume 577=
=0A[ 1019.851898] dma dma0chan20: device_resume 577=0A[ 1019.851928] dma dm=
a0chan21: device_resume 577=0A[ 1019.851959] dma dma0chan22: device_resume =
577=0A[ 1019.851989] dma dma0chan23: device_resume 577=0A[ 1019.852020] dma=
 dma0chan24: device_resume 577=0A[ 1019.852050] dma dma0chan25: device_resu=
me 577=0A[ 1019.852081] dma dma0chan26: device_resume 577=0A[ 1019.852142] =
dma dma0chan27: device_resume 577=0A[ 1019.852172] dma dma0chan28: device_r=
esume 577=0A[ 1019.852203] dma dma0chan29: device_resume 577=0A[ 1019.85223=
3] dma dma0chan30: device_resume 577=0A[ 1019.852264] dma dma0chan31: devic=
e_resume 577=0A[ 1019.852294] dma dma0chan32: device_resume 577=0A[ 1019.85=
2325] dma dma0chan33: device_resume 577=0A[ 1019.852355] dma dma0chan34: de=
vice_resume 577=0A[ 1019.852386] dma dma0chan35: device_resume 577=0A[ 1019=
=2E852416] dma dma0chan36: device_resume 577=0A[ 1019.852478] dma dma0chan3=
7: device_resume 577=0A[ 1019.852508] dma dma0chan38: device_resume 577=0A[=
 1019.852539] dma dma0chan39: device_resume 577=0A[ 1019.852569] dma dma0ch=
an40: device_resume 577=0A[ 1019.852600] dma dma0chan41: device_resume 577=
=0A[ 1019.852630] dma dma0chan42: device_resume 577=0A[ 1019.852661] dma dm=
a0chan43: device_resume 577=0A[ 1019.852691] dma dma0chan44: device_resume =
577=0A[ 1019.852722] dma dma0chan45: device_resume 577=0A[ 1019.852752] dma=
 dma0chan46: device_resume 577=0A[ 1019.852783] dma dma0chan47: device_resu=
me 577=0A[ 1019.852844] dma dma0chan48: device_resume 577=0A[ 1019.852874] =
dma dma0chan49: device_resume 577=0A[ 1019.852905] dma dma0chan50: device_r=
esume 577=0A[ 1019.852935] dma dma0chan51: device_resume 577=0A[ 1019.85296=
6] dma dma0chan52: device_resume 577=0A[ 1019.852996] dma dma0chan53: devic=
e_resume 577=0A[ 1019.853027] dma dma0chan54: device_resume 577=0A[ 1019.85=
3057] dma dma0chan55: device_resume 577=0A[ 1019.853088] dma dma0chan56: de=
vice_resume 577=0A[ 1019.853118] dma dma0chan57: device_resume 577=0A[ 1019=
=2E853179] dma dma0chan58: device_resume 577=0A[ 1019.853210] dma dma0chan5=
9: device_resume 577=0A[ 1019.853240] dma dma0chan60: device_resume 577=0A[=
 1019.853271] dma dma0chan61: device_resume 577=0A[ 1019.853301] dma dma0ch=
an62: device_resume 577=0A[ 1019.853332] dma dma0chan63: device_resume 577=
=0A[ 1019.853363] dma dma0chan64: device_resume 577=0A[ 1019.853393] dma dm=
a0chan65: device_resume 577=0A[ 1019.853424] dma dma0chan66: device_resume =
577=0A[ 1019.853454] dma dma0chan67: device_resume 577=0A[ 1019.853515] dma=
 dma0chan68: device_resume 577=0A[ 1019.853546] dma dma0chan69: device_resu=
me 577=0A[ 1019.853576] dma dma0chan70: device_resume 577=0A[ 1019.853607] =
dma dma0chan71: device_resume 577=0A[ 1019.853637] dma dma0chan72: device_r=
esume 577=0A[ 1019.853668] dma dma0chan73: device_resume 577=0A[ 1019.85369=
8] dma dma0chan74: device_resume 577=0A[ 1019.853729] dma dma0chan75: devic=
e_resume 577=0A[ 1019.853759] dma dma0chan76: device_resume 577=0A[ 1019.85=
3790] dma dma0chan77: device_resume 577=0A[ 1019.853851] dma dma0chan78: de=
vice_resume 577=0A[ 1019.853881] dma dma0chan79: device_resume 577=0A[ 1019=
=2E853912] dma dma0chan80: device_resume 577=0A[ 1019.853942] dma dma0chan8=
1: device_resume 577=0A[ 1019.853973] dma dma0chan82: device_resume 577=0A[=
 1019.854003] dma dma0chan83: device_resume 577=0A[ 1019.854034] dma dma0ch=
an84: device_resume 577=0A[ 1019.854064] dma dma0chan85: device_resume 577=
=0A[ 1019.854095] dma dma0chan86: device_resume 577=0A[ 1019.854125] dma dm=
a0chan87: device_resume 577=0A[ 1019.854156] dma dma0chan88: device_resume =
577=0A[ 1019.854217] dma dma0chan89: device_resume 577=0A[ 1019.854248] dma=
 dma0chan90: device_resume 577=0A[ 1019.854278] dma dma0chan91: device_resu=
me 577=0A[ 1019.854309] dma dma0chan92: device_resume 577=0A[ 1019.854339] =
dma dma0chan93: device_resume 577=0A[ 1019.854370] dma dma0chan94: device_r=
esume 577=0A[ 1019.854400] dma dma0chan95: device_resume 577=0A[ 1019.85443=
1] dma dma0chan96: device_resume 577=0A[ 1019.854461] dma dma0chan97: devic=
e_resume 577=0A[ 1019.854492] dma dma0chan98: device_resume 577=0A[ 1019.85=
4553] dma dma0chan99: device_resume 577=0A[ 1019.854583] dma dma0chan100: d=
evice_resume 577=0A[ 1019.854614] dma dma0chan101: device_resume 577=0A[ 10=
19.854644] dma dma0chan102: device_resume 577=0A[ 1019.854675] dma dma0chan=
103: device_resume 577=0A[ 1019.854705] dma dma0chan104: device_resume 577=
=0A[ 1019.854736] dma dma0chan105: device_resume 577=0A[ 1019.854766] dma d=
ma0chan106: device_resume 577=0A[ 1019.854797] dma dma0chan107: device_resu=
me 577=0A[ 1019.854827] dma dma0chan108: device_resume 577=0A[ 1019.854888]=
 dma dma0chan109: device_resume 577=0A[ 1019.854919] dma dma0chan110: devic=
e_resume 577=0A[ 1019.854949] dma dma0chan111: device_resume 577=0A[ 1019.8=
54980] dma dma0chan112: device_resume 577=0A[ 1019.855010] dma dma0chan113:=
 device_resume 577=0A[ 1019.855041] dma dma0chan114: device_resume 577=0A[ =
1019.855072] dma dma0chan115: device_resume 577=0A[ 1019.855102] dma dma0ch=
an116: device_resume 577=0A[ 1019.855133] dma dma0chan117: device_resume 57=
7=0A[ 1019.855163] dma dma0chan118: device_resume 577=0A[ 1019.855194] dma =
dma0chan119: device_resume 577=0A[ 1019.855255] dma dma0chan120: device_res=
ume 577=0A[ 1019.855285] dma dma0chan121: device_resume 577=0A[ 1019.855316=
] dma dma0chan122: device_resume 577=0A[ 1019.855346] dma dma0chan123: devi=
ce_resume 577=0A[ 1019.855377] dma dma0chan124: device_resume 577=0A[ 1019.=
855407] dma dma0chan125: device_resume 577=0A[ 1019.855438] dma dma0chan126=
: device_resume 577=0A[ 1019.855468] i2c i2c-1: device_resume 577=0A[ 1019.=
855499] twl 1-0048: device_resume 577=0A[ 1019.855560] platform twl: device=
_resume 577=0A[ 1019.855590] dummy 1-0049: device_resume 577=0A[ 1019.85562=
1] dummy 1-004a: device_resume 577=0A[ 1019.855651] dummy 1-004b: device_re=
sume 577=0A[ 1019.855682] twl4030_gpio twl4030_gpio: device_resume 577=0A[ =
1019.855712] gpio gpiochip492: device_resume 577=0A[ 1019.855743] omap_hsmm=
c omap_hsmmc.0: device_resume 577=0A[ 1019.855773] omap_hsmmc omap_hsmmc.0:=
 _od_resume 884=0A[ 1019.856048] i2c i2c-1: master_xfer[0] W, addr=3D0x49, =
len=3D4=0A[ 1019.856079] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[ 1019.85=
6109] omap_i2c omap_i2c.1: addr: 0x0049, len: 4, flags: 0x0, stop: 1=0A[ 10=
19.856140] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[ 1019.856170] omap=
_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1019.856170] omap_i2c omap_i2c.1: oma=
p_i2c_isr 886: mask 601f stat 1510=0A[ 1019.856201] omap_i2c omap_i2c.1: om=
ap_i2c_isr 889=0A[ 1019.856201] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1=
019.856262] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[ 10=
19.856323] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1019.856353] om=
ap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[ 1019.856384] omap_i2c omap_i2c.=
1: omap_i2c_isr_thread 1033=0A[ 1019.856414] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[ 1019.856414] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 0104=0A[ 1019.856445] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1019.85=
6445] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1019.856475] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 0=0A[ 1019.856506] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[ 1019.856506] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0004)=0A[ 1019.856567] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[ 1019.856842] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ 1019.856903] =
i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[ 1019.856933] i2c i2c-=
1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[ 1019.856964] omap_i2c omap_i2=
c.1: omap_i2c_xfer 626=0A[ 1019.856994] omap_i2c omap_i2c.1: addr: 0x004b, =
len: 1, flags: 0x0, stop: 0=0A[ 1019.856994] omap_i2c omap_i2c.1: omap_i2c_=
xfer_msg 537=0A[ 1019.857025] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 101=
9.857055] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[ 10=
19.857055] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1019.857086] omap_i2c =
omap_i2c.1: omap_i2c_isr 894=0A[ 1019.857116] =3D=3D=3D> irq_wake_thread 13=
9: IRQ 72 wake_up_process 1=0A[ 1019.857147] omap_i2c omap_i2c.1: omap_i2c_=
isr_thread 908=0A[ 1019.857177] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=
=0A[ 1019.857208] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.85=
7238] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1019.857238] omap_i2c omap_=
i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[ 1019.857269] omap_i2c omap=
_i2c.1: omap_i2c_isr 889=0A[ 1019.857269] omap_i2c omap_i2c.1: omap_i2c_isr=
 894=0A[ 1019.857299] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proces=
s 0=0A[ 1019.857330] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1019.=
857330] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1019.857360] omap_i2c=
 omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.857421] omap_i2c omap_i2c.1:=
 addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[ 1019.857452] omap_i2c omap_i=
2c.1: omap_i2c_xfer_msg 537=0A[ 1019.857513] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[ 1019.857513] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 0108=0A[ 1019.857543] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1019.85=
7543] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1019.857574] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[ 1019.857604] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[ 1019.857635] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0008)=0A[ 1019.857666] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A=
[ 1019.857696] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.85772=
7] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ 1019.857788] i2c i2c-1: maste=
r_xfer[0] W, addr=3D0x4b, len=3D1=0A[ 1019.857788] i2c i2c-1: master_xfer[1=
] R, addr=3D0x4b, len=3D1=0A[ 1019.857818] omap_i2c omap_i2c.1: omap_i2c_xf=
er 626=0A[ 1019.857849] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0=
x0, stop: 0=0A[ 1019.857879] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[=
 1019.857910] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1019.857910] omap_i=
2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[ 1019.857940] omap_=
i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1019.857940] omap_i2c omap_i2c.1: omap=
_i2c_isr 894=0A[ 1019.857971] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_u=
p_process 1=0A[ 1019.858032] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=
=0A[ 1019.858062] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[ 1019.858093=
] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.858123] omap_i2c o=
map_i2c.1: omap_i2c_isr 880=0A[ 1019.858123] omap_i2c omap_i2c.1: omap_i2c_=
isr 886: mask 601f stat 1104=0A[ 1019.858154] omap_i2c omap_i2c.1: omap_i2c=
_isr 889=0A[ 1019.858154] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1019.85=
8184] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[ 1019.858=
184] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1019.858215] omap_i2c=
 omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1019.858245] omap_i2c omap_i2c.1: oma=
p_i2c_isr_thread 1033=0A[ 1019.858306] omap_i2c omap_i2c.1: addr: 0x004b, l=
en: 1, flags: 0x1, stop: 1=0A[ 1019.858306] omap_i2c omap_i2c.1: omap_i2c_x=
fer_msg 537=0A[ 1019.858367] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1019=
=2E858398] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[ 1=
019.858398] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1019.858428] omap_i2c=
 omap_i2c.1: omap_i2c_isr 894=0A[ 1019.858459] =3D=3D=3D> irq_wake_thread 1=
39: IRQ 72 wake_up_process 1=0A[ 1019.858489] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 908=0A[ 1019.858489] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=
=0A[ 1019.858520] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1019.858551=
] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.858612] omap_i2c o=
map_i2c.1: omap_i2c_xfer 663=0A[ 1019.858642] i2c i2c-1: master_xfer[0] W, =
addr=3D0x4b, len=3D1=0A[ 1019.858642] i2c i2c-1: master_xfer[1] R, addr=3D0=
x4b, len=3D1=0A[ 1019.858673] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[ 10=
19.858703] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0=
=0A[ 1019.858734] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[ 1019.85873=
4] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1019.858764] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 886: mask 601f stat 1110=0A[ 1019.858795] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[ 1019.858795] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[ 1019.858825] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[ 1019.858886] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1019.8=
58886] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[ 1019.858947] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.858978] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[ 1019.858978] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 1104=0A[ 1019.859008] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[ 1019.859008] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1019.859039] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[ 1019.859069] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1019.859069] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[ 1019.859191] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[ 1019.859252] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, =
flags: 0x1, stop: 1=0A[ 1019.859252] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[ 1019.859313] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1019.859344=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[ 1019.85934=
4] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1019.859374] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[ 1019.859405] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[ 1019.859436] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[ 1019.859436] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[ 101=
9.859466] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1019.859497] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.859527] omap_i2c omap_i2c.=
1: omap_i2c_xfer 663=0A[ 1019.859588] i2c i2c-1: master_xfer[0] W, addr=3D0=
x4b, len=3D2=0A[ 1019.859588] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A[ 10=
19.859619] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1=
=0A[ 1019.859649] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[ 1019.85968=
0] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1019.859680] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 886: mask 601f stat 1110=0A[ 1019.859710] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[ 1019.859710] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[ 1019.859741] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[ 1019.859802] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1019.8=
59802] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[ 1019.859832] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.859863] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[ 1019.859863] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 0104=0A[ 1019.859893] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[ 1019.859893] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1019.859924] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[ 1019.859954] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1019.859954] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[ 1019.859985] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[ 1019.860046] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ =
1019.860168] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[ 1019.860=
198] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[ 1019.860198] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[ 1019.860229] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[ 1019.860260] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[ 1019.860290] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[ 1019.860290] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[ 1019.860321] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1019.86=
0351] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1019.860351] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[ 1019.860412] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[ 1019.860412] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[ 1019.860443] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[ 1019.860473] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1019.860504] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[ 1019.860504] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1019.860534] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[ 1019.860534] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[ 1019.860565] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[ 1019.860565] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1019.860=
595] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.860656] omap_i2=
c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[ 1019.860687] om=
ap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[ 1019.860717] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 880=0A[ 1019.860748] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 0108=0A[ 1019.860748] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[ 1019.860778] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1019.860809]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[ 1019.860839] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1019.860839] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0008)=0A[ 1019.860870] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x0004)=0A[ 1019.860900] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[ 1019.860961] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ 1019.860992] i=
2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[ 1019.860992] i2c i2c-1=
: master_xfer[1] R, addr=3D0x4b, len=3D1=0A[ 1019.861022] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer 626=0A[ 1019.861053] omap_i2c omap_i2c.1: addr: 0x004b,=
 len: 1, flags: 0x0, stop: 0=0A[ 1019.861083] omap_i2c omap_i2c.1: omap_i2c=
_xfer_msg 537=0A[ 1019.861083] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 10=
19.861114] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[ 1=
019.861145] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1019.861145] omap_i2c=
 omap_i2c.1: omap_i2c_isr 894=0A[ 1019.861175] =3D=3D=3D> irq_wake_thread 1=
39: IRQ 72 wake_up_process 1=0A[ 1019.861206] omap_i2c omap_i2c.1: omap_i2c=
_isr_thread 908=0A[ 1019.861236] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=
=0A[ 1019.861236] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.86=
1267] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1019.861297] omap_i2c omap_=
i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[ 1019.861328] omap_i2c omap=
_i2c.1: omap_i2c_isr 889=0A[ 1019.861328] omap_i2c omap_i2c.1: omap_i2c_isr=
 894=0A[ 1019.861358] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proces=
s 0=0A[ 1019.861358] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1019.=
861389] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1019.861419] omap_i2c=
 omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.861480] omap_i2c omap_i2c.1:=
 addr: 0x004b, len: 1, flags: 0x1, stop: 1=0A[ 1019.861480] omap_i2c omap_i=
2c.1: omap_i2c_xfer_msg 537=0A[ 1019.861541] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[ 1019.861541] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 0108=0A[ 1019.861572] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1019.86=
1572] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1019.861602] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[ 1019.861633] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[ 1019.861663] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0008)=0A[ 1019.861663] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A=
[ 1019.861694] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.86175=
5] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ 1019.861785] i2c i2c-1: maste=
r_xfer[0] W, addr=3D0x4b, len=3D2=0A[ 1019.861816] omap_i2c omap_i2c.1: oma=
p_i2c_xfer 626=0A[ 1019.861846] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, =
flags: 0x0, stop: 1=0A[ 1019.861846] omap_i2c omap_i2c.1: omap_i2c_xfer_msg=
 537=0A[ 1019.861877] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1019.861907=
] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[ 1019.86190=
7] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1019.861938] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 894=0A[ 1019.861968] =3D=3D=3D> irq_wake_thread 139: IRQ=
 72 wake_up_process 1=0A[ 1019.861999] omap_i2c omap_i2c.1: omap_i2c_isr_th=
read 908=0A[ 1019.862030] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[ 101=
9.862030] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1019.862060] om=
ap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1019.862091] omap_i2c omap_i2c.1: o=
map_i2c_isr 886: mask 601f stat 0104=0A[ 1019.862091] omap_i2c omap_i2c.1: =
omap_i2c_isr 889=0A[ 1019.862121] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[=
 1019.862121] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[ =
1019.862152] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1019.862182] =
omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1019.862213] omap_i2c omap_i2=
c.1: omap_i2c_isr_thread 1033=0A[ 1019.862243] omap_i2c omap_i2c.1: omap_i2=
c_xfer 663=0A[ 1020.980194] twl_rtc twl_rtc: device_resume 577=0A[ 1020.980=
224] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2=0A[ 1020.980255] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[ 1020.980285] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 2, flags: 0x0, stop: 1=0A[ 1020.980316] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[ 1020.980346] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[ 1020.980346] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[ 1020.980377] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1020.98=
0377] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1020.980438] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[ 1020.980499] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[ 1020.980499] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[ 1020.980529] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[ 1020.980560] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1020.980560] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[ 1020.980590] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1020.980590] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[ 1020.980621] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[ 1020.980651] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[ 1020.980651] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1020.980=
682] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1020.980743] omap_i2=
c omap_i2c.1: omap_i2c_xfer 663=0A[ 1020.980804] platform twl4030_wdt: devi=
ce_resume 577=0A[ 1020.980834] twl4030_pwrbutton twl4030_pwrbutton: device_=
resume 577=0A[ 1020.980865] twl4030-audio twl4030-audio: device_resume 577=
=0A[ 1020.980895] twl_reg twl_reg.0: device_resume 577=0A[ 1020.980926] reg=
ulator regulator.1: device_resume 577=0A[ 1020.980957] twl_reg twl_reg.1: d=
evice_resume 577=0A[ 1020.981018] regulator regulator.2: device_resume 577=
=0A[ 1020.981048] twl_reg twl_reg.6: device_resume 577=0A[ 1020.981079] reg=
ulator regulator.3: device_resume 577=0A[ 1020.981109] twl_reg twl_reg.3: d=
evice_resume 577=0A[ 1020.981140] regulator regulator.4: device_resume 577=
=0A[ 1020.981170] twl_reg twl_reg.5: device_resume 577=0A[ 1020.981201] reg=
ulator regulator.5: device_resume 577=0A[ 1020.981231] twl_reg twl_reg.8: d=
evice_resume 577=0A[ 1020.981292] regulator regulator.6: device_resume 577=
=0A[ 1020.981323] i2c i2c-3: device_resume 577=0A[ 1020.981353] i2c 3-0050:=
 device_resume 577=0A[ 1020.981384] net lo: device_resume 577=0A[ 1020.9814=
14] mem mem: device_resume 577=0A[ 1020.981445] mem kmem: device_resume 577=
=0A[ 1020.981475] mem null: device_resume 577=0A[ 1020.981536] mem zero: de=
vice_resume 577=0A[ 1020.981567] mem full: device_resume 577=0A[ 1020.98159=
7] mem random: device_resume 577=0A[ 1020.981628] mem urandom: device_resum=
e 577=0A[ 1020.981658] mem kmsg: device_resume 577=0A[ 1020.981689] tty tty=
: device_resume 577=0A[ 1020.981719] tty console: device_resume 577=0A[ 102=
0.981750] tty tty0: device_resume 577=0A[ 1020.981811] vc vcs: device_resum=
e 577=0A[ 1020.981842] vc vcsa: device_resume 577=0A[ 1020.981872] vc vcs1:=
 device_resume 577=0A[ 1020.981903] vc vcsa1: device_resume 577=0A[ 1020.98=
1933] tty tty1: device_resume 577=0A[ 1020.981964] tty tty2: device_resume =
577=0A[ 1020.981994] tty tty3: device_resume 577=0A[ 1020.982025] tty tty4:=
 device_resume 577=0A[ 1020.982086] tty tty5: device_resume 577=0A[ 1020.98=
2116] tty tty6: device_resume 577=0A[ 1020.982147] tty tty7: device_resume =
577=0A[ 1020.982177] tty tty8: device_resume 577=0A[ 1020.982208] tty tty9:=
 device_resume 577=0A[ 1020.982238] tty tty10: device_resume 577=0A[ 1020.9=
82269] tty tty11: device_resume 577=0A[ 1020.982299] tty tty12: device_resu=
me 577=0A[ 1020.982360] tty tty13: device_resume 577=0A[ 1020.982391] tty t=
ty14: device_resume 577=0A[ 1020.982421] tty tty15: device_resume 577=0A[ 1=
020.982452] tty tty16: device_resume 577=0A[ 1020.982482] tty tty17: device=
_resume 577=0A[ 1020.982513] tty tty18: device_resume 577=0A[ 1020.982543] =
tty tty19: device_resume 577=0A[ 1020.982574] tty tty20: device_resume 577=
=0A[ 1020.982604] tty tty21: device_resume 577=0A[ 1020.982666] tty tty22: =
device_resume 577=0A[ 1020.982696] tty tty23: device_resume 577=0A[ 1020.98=
2727] tty tty24: device_resume 577=0A[ 1020.982757] tty tty25: device_resum=
e 577=0A[ 1020.982788] tty tty26: device_resume 577=0A[ 1020.982818] tty tt=
y27: device_resume 577=0A[ 1020.982849] tty tty28: device_resume 577=0A[ 10=
20.982879] tty tty29: device_resume 577=0A[ 1020.982940] tty tty30: device_=
resume 577=0A[ 1020.982971] tty tty31: device_resume 577=0A[ 1020.983001] t=
ty tty32: device_resume 577=0A[ 1020.983032] tty tty33: device_resume 577=
=0A[ 1020.983062] tty tty34: device_resume 577=0A[ 1020.983093] tty tty35: =
device_resume 577=0A[ 1020.983123] tty tty36: device_resume 577=0A[ 1020.98=
3154] tty tty37: device_resume 577=0A[ 1020.983215] tty tty38: device_resum=
e 577=0A[ 1020.983245] tty tty39: device_resume 577=0A[ 1020.983276] tty tt=
y40: device_resume 577=0A[ 1020.983306] tty tty41: device_resume 577=0A[ 10=
20.983337] tty tty42: device_resume 577=0A[ 1020.983367] tty tty43: device_=
resume 577=0A[ 1020.983398] tty tty44: device_resume 577=0A[ 1020.983489] t=
ty tty45: device_resume 577=0A[ 1020.983520] tty tty46: device_resume 577=
=0A[ 1020.983551] tty tty47: device_resume 577=0A[ 1020.983581] tty tty48: =
device_resume 577=0A[ 1020.983612] tty tty49: device_resume 577=0A[ 1020.98=
3642] tty tty50: device_resume 577=0A[ 1020.983703] tty tty51: device_resum=
e 577=0A[ 1020.983734] tty tty52: device_resume 577=0A[ 1020.983764] tty tt=
y53: device_resume 577=0A[ 1020.983795] tty tty54: device_resume 577=0A[ 10=
20.983825] tty tty55: device_resume 577=0A[ 1020.983856] tty tty56: device_=
resume 577=0A[ 1020.983886] tty tty57: device_resume 577=0A[ 1020.983917] t=
ty tty58: device_resume 577=0A[ 1020.983947] tty tty59: device_resume 577=
=0A[ 1020.984069] tty tty60: device_resume 577=0A[ 1020.984100] tty tty61: =
device_resume 577=0A[ 1020.984161] tty tty62: device_resume 577=0A[ 1020.98=
4191] tty tty63: device_resume 577=0A[ 1020.984222]  clocksource: device_re=
sume 577=0A[ 1020.984252] clocksource clocksource0: device_resume 577=0A[ 1=
020.984283] alarmtimer alarmtimer: device_resume 577=0A[ 1020.984313] event=
_source ARMv7 Cortex-A8: device_resume 577=0A[ 1020.984344] event_source br=
eakpoint: device_resume 577=0A[ 1020.984374] event_source tracepoint: devic=
e_resume 577=0A[ 1020.984436] event_source software: device_resume 577=0A[ =
1020.984466] graphics fbcon: device_resume 577=0A[ 1020.984497] tty ptmx: d=
evice_resume 577=0A[ 1020.984527] serial8250 serial8250: device_resume 577=
=0A[ 1020.984558] tty ttyS0: device_resume 577=0A[ 1020.984588] tty ttyS1: =
device_resume 577=0A[ 1020.984649] tty ttyS2: device_resume 577=0A[ 1020.98=
4680] tty ttyS3: device_resume 577=0A[ 1020.984710] tty ttyO0: device_resum=
e 577=0A[ 1020.984741] tty ttyO1: device_resume 577=0A[ 1020.984771] tty tt=
yO2: device_resume 577=0A[ 1020.984802] tty ttyO3: device_resume 577=0A[ 10=
20.984832] bdi 1:0: device_resume 577=0A[ 1020.984863] block ram0: device_r=
esume 577=0A[ 1020.984924] bdi 1:1: device_resume 577=0A[ 1020.984954] bloc=
k ram1: device_resume 577=0A[ 1020.984985] bdi 1:2: device_resume 577=0A[ 1=
020.985015] block ram2: device_resume 577=0A[ 1020.985046] bdi 1:3: device_=
resume 577=0A[ 1020.985076] block ram3: device_resume 577=0A[ 1020.985107] =
bdi 1:4: device_resume 577=0A[ 1020.985137] block ram4: device_resume 577=
=0A[ 1020.985198] bdi 1:5: device_resume 577=0A[ 1020.985229] block ram5: d=
evice_resume 577=0A[ 1020.985260] bdi 1:6: device_resume 577=0A[ 1020.98529=
0] block ram6: device_resume 577=0A[ 1020.985321] bdi 1:7: device_resume 57=
7=0A[ 1020.985351] block ram7: device_resume 577=0A[ 1020.985382] bdi 1:8: =
device_resume 577=0A[ 1020.985412] block ram8: device_resume 577=0A[ 1020.9=
85443] bdi 1:9: device_resume 577=0A[ 1020.985504] block ram9: device_resum=
e 577=0A[ 1020.985534] bdi 1:10: device_resume 577=0A[ 1020.985565] block r=
am10: device_resume 577=0A[ 1020.985595] bdi 1:11: device_resume 577=0A[ 10=
20.985626] block ram11: device_resume 577=0A[ 1020.985656] bdi 1:12: device=
_resume 577=0A[ 1020.985687] block ram12: device_resume 577=0A[ 1020.985717=
] bdi 1:13: device_resume 577=0A[ 1020.985778] block ram13: device_resume 5=
77=0A[ 1020.985809] bdi 1:14: device_resume 577=0A[ 1020.985839] block ram1=
4: device_resume 577=0A[ 1020.985870] bdi 1:15: device_resume 577=0A[ 1020.=
985900] block ram15: device_resume 577=0A[ 1020.985931] misc loop-control: =
device_resume 577=0A[ 1020.985961] bdi 7:0: device_resume 577=0A[ 1020.9859=
92] block loop0: device_resume 577=0A[ 1020.986053] bdi 7:1: device_resume =
577=0A[ 1020.986083] block loop1: device_resume 577=0A[ 1020.986114] bdi 7:=
2: device_resume 577=0A[ 1020.986145] block loop2: device_resume 577=0A[ 10=
20.986175] bdi 7:3: device_resume 577=0A[ 1020.986206] block loop3: device_=
resume 577=0A[ 1020.986236] bdi 7:4: device_resume 577=0A[ 1020.986267] blo=
ck loop4: device_resume 577=0A[ 1020.986297] bdi 7:5: device_resume 577=0A[=
 1020.986358] block loop5: device_resume 577=0A[ 1020.986389] bdi 7:6: devi=
ce_resume 577=0A[ 1020.986419] block loop6: device_resume 577=0A[ 1020.9864=
50] bdi 7:7: device_resume 577=0A[ 1020.986480] block loop7: device_resume =
577=0A[ 1020.986511] platform twl4030-codec: device_resume 577=0A[ 1020.986=
541] bdi mtd-unmap: device_resume 577=0A[ 1020.986572] bdi mtd-romap: devic=
e_resume 577=0A[ 1020.986633] bdi mtd-rwmap: device_resume 577=0A[ 1020.986=
663] spi_master spi1: device_resume 577=0A[ 1020.986694] spi_master spi2: d=
evice_resume 577=0A[ 1020.986724] spi_master spi3: device_resume 577=0A[ 10=
20.986755] spi_master spi4: device_resume 577=0A[ 1020.986785] usbmon usbmo=
n0: device_resume 577=0A[ 1020.986816] input mice: device_resume 577=0A[ 10=
20.986846] misc psaux: device_resume 577=0A[ 1020.986907] input input0: dev=
ice_resume 577=0A[ 1020.986999] input event0: device_resume 577=0A[ 1020.98=
7060] rtc rtc0: device_resume 577=0A[ 1020.987091] i2c i2c-1: master_xfer[0=
] W, addr=3D0x4b, len=3D1=0A[ 1020.987121] i2c i2c-1: master_xfer[1] R, add=
r=3D0x4b, len=3D1=0A[ 1020.987152] omap_i2c omap_i2c.1: omap_i2c_xfer 626=
=0A[ 1020.987182] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, st=
op: 0=0A[ 1020.987213] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[ 1020.=
987243] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1020.987243] omap_i2c oma=
p_i2c.1: omap_i2c_isr 886: mask 601f stat 1510=0A[ 1020.987274] omap_i2c om=
ap_i2c.1: omap_i2c_isr 889=0A[ 1020.987274] omap_i2c omap_i2c.1: omap_i2c_i=
sr 894=0A[ 1020.987304] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_proc=
ess 1=0A[ 1020.987396] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 102=
0.987396] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[ 1020.987426] omap_i=
2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1020.987457] omap_i2c omap_i2c.=
1: omap_i2c_isr 880=0A[ 1020.987487] omap_i2c omap_i2c.1: omap_i2c_isr 886:=
 mask 601f stat 1104=0A[ 1020.987487] omap_i2c omap_i2c.1: omap_i2c_isr 889=
=0A[ 1020.987518] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1020.987518] =
=3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[ 1020.987548] o=
map_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1020.987579] omap_i2c omap_=
i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1020.987609] omap_i2c omap_i2c.1: omap_i2c_=
isr_thread 1033=0A[ 1020.987731] omap_i2c omap_i2c.1: addr: 0x004b, len: 1,=
 flags: 0x1, stop: 1=0A[ 1020.987762] omap_i2c omap_i2c.1: omap_i2c_xfer_ms=
g 537=0A[ 1020.987853] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1020.98788=
4] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0108=0A[ 1020.9879=
15] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1020.987915] omap_i2c omap_i2=
c.1: omap_i2c_isr 894=0A[ 1020.987945] =3D=3D=3D> irq_wake_thread 139: IRQ =
72 wake_up_process 1=0A[ 1020.988006] omap_i2c omap_i2c.1: omap_i2c_isr_thr=
ead 908=0A[ 1020.988006] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)=0A[ 1020=
=2E988037] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1020.988067] omap_=
i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1020.988128] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer 663=0A[ 1020.988159] i2c i2c-1: master_xfer[0] W, addr=
=3D0x4b, len=3D2=0A[ 1020.988189] omap_i2c omap_i2c.1: omap_i2c_xfer 626=0A=
[ 1020.988220] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1=0A[ 1020.988250] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[ 1020.988=
250] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1020.988281] omap_i2c omap_i=
2c.1: omap_i2c_isr 886: mask 601f stat 1110=0A[ 1020.988311] omap_i2c omap_=
i2c.1: omap_i2c_isr 889=0A[ 1020.988311] omap_i2c omap_i2c.1: omap_i2c_isr =
894=0A[ 1020.988342] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process=
 1=0A[ 1020.988372] omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1020.9=
88403] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)=0A[ 1020.988433] omap_i2c =
omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1020.988464] omap_i2c omap_i2c.1: =
omap_i2c_isr 880=0A[ 1020.988464] omap_i2c omap_i2c.1: omap_i2c_isr 886: ma=
sk 601f stat 0104=0A[ 1020.988494] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A=
[ 1020.988494] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1020.988525] =3D=
=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0=0A[ 1020.988525] omap=
_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1020.988555] omap_i2c omap_i2c=
=2E1: IRQ (ISR =3D 0x0004)=0A[ 1020.988586] omap_i2c omap_i2c.1: omap_i2c_i=
sr_thread 1033=0A[ 1020.988647] omap_i2c omap_i2c.1: omap_i2c_xfer 663=0A[ =
1020.988677] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1=0A[ 1020.988=
677] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D6=0A[ 1020.988708] oma=
p_i2c omap_i2c.1: omap_i2c_xfer 626=0A[ 1020.988739] omap_i2c omap_i2c.1: a=
ddr: 0x004b, len: 1, flags: 0x0, stop: 0=0A[ 1020.988769] omap_i2c omap_i2c=
=2E1: omap_i2c_xfer_msg 537=0A[ 1020.988800] omap_i2c omap_i2c.1: omap_i2c_=
isr 880=0A[ 1020.988800] omap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f s=
tat 1110=0A[ 1020.988830] omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1020.98=
8830] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1020.988861] =3D=3D=3D> irq=
_wake_thread 139: IRQ 72 wake_up_process 1=0A[ 1020.988891] omap_i2c omap_i=
2c.1: omap_i2c_isr_thread 908=0A[ 1020.988922] omap_i2c omap_i2c.1: IRQ (IS=
R =3D 0x0010)=0A[ 1020.988952] omap_i2c omap_i2c.1: omap_i2c_isr_thread 103=
3=0A[ 1020.988983] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1020.988983] o=
map_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 1104=0A[ 1020.989013] =
omap_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1020.989013] omap_i2c omap_i2c.1:=
 omap_i2c_isr 894=0A[ 1020.989044] =3D=3D=3D> irq_wake_thread 139: IRQ 72 w=
ake_up_process 0=0A[ 1020.989074] omap_i2c omap_i2c.1: omap_i2c_isr_thread =
908=0A[ 1020.989074] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1020.989=
105] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1020.989166] omap_i2=
c omap_i2c.1: addr: 0x004b, len: 6, flags: 0x1, stop: 1=0A[ 1020.989166] om=
ap_i2c omap_i2c.1: omap_i2c_xfer_msg 537=0A[ 1020.989318] omap_i2c omap_i2c=
=2E1: omap_i2c_isr 880=0A[ 1020.989349] omap_i2c omap_i2c.1: omap_i2c_isr 8=
86: mask 601f stat 1108=0A[ 1020.989349] omap_i2c omap_i2c.1: omap_i2c_isr =
889=0A[ 1020.989379] omap_i2c omap_i2c.1: omap_i2c_isr 894=0A[ 1020.989379]=
 =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1=0A[ 1020.989440] =
omap_i2c omap_i2c.1: omap_i2c_isr_thread 908=0A[ 1020.989471] omap_i2c omap=
_i2c.1: IRQ (ISR =3D 0x0008)=0A[ 1020.989501] omap_i2c omap_i2c.1: IRQ (ISR=
 =3D 0x2000)=0A[ 1020.989532] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=
=0A[ 1020.989562] omap_i2c omap_i2c.1: omap_i2c_isr 880=0A[ 1020.989562] om=
ap_i2c omap_i2c.1: omap_i2c_isr 886: mask 601f stat 0104=0A[ 1020.989593] o=
map_i2c omap_i2c.1: omap_i2c_isr 889=0A[ 1020.989593] omap_i2c omap_i2c.1: =
omap_i2c_isr 894=0A[ 1020.989624] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wa=
ke_up_process 0=0A[ 1020.989654] omap_i2c omap_i2c.1: omap_i2c_isr_thread 9=
08=0A[ 1020.989654] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)=0A[ 1020.9896=
85] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1033=0A[ 1020.989746] omap_i2c=
 omap_i2c.1: omap_i2c_xfer 663=0A[ 1020.989776] i2c-dev i2c-1: device_resum=
e 577=0A[ 1020.989837] i2c-dev i2c-3: device_resume 577=0A[ 1020.989868] mi=
sc watchdog: device_resume 577=0A[ 1020.989898] mmc_host mmc0: device_resum=
e 577=0A[ 1020.989929] oprofile-perf oprofile-perf.0: device_resume 577=0A[=
 1020.989959] misc cpu_dma_latency: device_resume 577=0A[ 1020.989990] misc=
 network_latency: device_resume 577=0A[ 1020.990051] misc network_throughpu=
t: device_resume 577=0A[ 1020.990081] misc ubi_ctrl: device_resume 577=0A[ =
1020.990112] input input1: device_resume 577=0A[ 1020.990142] input event1:=
 device_resume 577=0A[ 1020.990173] mmcblk mmc0:0002: device_resume 577=0A[=
 1020.990264] bdi 179:0: device_resume 577=0A[ 1020.990295] block mmcblk0: =
device_resume 577=0A[ 1020.990325] block mmcblk0p1: device_resume 577=0A[ 1=
020.990356] block mmcblk0p2: device_resume 577=0A[ 1020.990386] vc vcs3: de=
vice_resume 577=0A[ 1020.990417] vc vcsa3: device_resume 577=0A[ 1020.99044=
7] vc vcs2: device_resume 577=0A[ 1020.990509] vc vcsa2: device_resume 577=
=0A[ 1020.990539] vc vcs5: device_resume 577=0A[ 1020.990570] vc vcsa5: dev=
ice_resume 577=0A[ 1020.990600] vc vcs4: device_resume 577=0A[ 1020.990631]=
 vc vcsa4: device_resume 577=0A[ 1020.990661] vc vcs6: device_resume 577=0A=
[ 1020.990692] vc vcsa6: device_resume 577=0A[ 1020.990722] vc vcs63: devic=
e_resume 577=0A[ 1020.990783] vc vcsa63: device_resume 577=0A[ 1020.990814]=
 PM: resume of devices complete after 1143.920 msecs=0A[ 1020.996520] PM: F=
inishing wakeup.=0A[ 1020.996551] Restarting tasks ... done.=0Aroot@arwen:~=
# ls=0Aprepare  spidev_test=0Aroot@arwen:~# =0Aroot@arwen:~# =0Aroot@arwen:=
~# ls=0Aprepare  spidev_test=0Aroot@arwen:~# free=0A             total     =
  used       free     shared    buffers     cached=0AMem:        505336    =
  27120     478216          0       3896      10520=0A-/+ buffers/cache:   =
   12704     492632=0ASwap:            0          0          0=0Aroot@arwen=
:~# cat p=08 =08/proc/interrupts =0A           CPU0       =0A 20:          =
0      INTC  gpmc=0A 23:          1      INTC  TWL4030-PIH=0A 25:          =
0      INTC  l3-debug-irq=0A 26:          0      INTC  l3-app-irq=0A 28:   =
    2907      INTC  DMA=0A 72:        695      INTC  omap_i2c=0A 77:       =
   0      INTC  omap_i2c=0A 90:      17959      INTC  OMAP UART2=0A 99:    =
   4702      INTC  mmc0=0A111:      11143      INTC  gp_timer=0A118:       =
   0      GPIO  user=0A306:       4030      PRCM  pm_wkup=0A315:          2=
      PRCM  hwmod_io, pm_io=0A338:          0   twl4030  twl4030_gpio=0A343=
:          1   twl4030  twl4030_power=0A346:          0   twl4030  twl4030_=
pwrbutton=0A349:          1   twl4030  rtc0=0A354:          0   twl4030  mm=
c0=0AIPI0:          0  CPU wakeup interrupts=0AIPI1:          0  Timer broa=
dcast interrupts=0AIPI2:          0  Rescheduling interrupts=0AIPI3:       =
   0  Function call interrupts=0AIPI4:          0  Single function call int=
errupts=0AIPI5:          0  CPU stop interrupts=0AErr:          0=0Aroot@ar=
wen:~#=20
--x+WOirvrtTKur1pg--

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfsI2AAoJEIaOsuA1yqREnDUQAKP8X43Lp0hh75NAWUO98A2h
Xq36ln2A+m68dA5kEur9fM6HQ3f9fz5jPfI1O4ltb6jzRQSNYPc1yVX9jxGZJ2op
oRH8MsUA1H4I/B6uQJTjcB9lVSWTus+ITo+POhGxUMgcKwl9WcyN6mM/fr+UIsDR
F8Rm2LnPu4QBKV+RKREP4Ljs6gTAR3O+If7LBINQpC+g8Zxvma1xcvo5seDR4Bqs
T5PKTVC3M4O4m7hG/JSmWzs6pT0vJfCaOq4ZzMvRrqWskol6HRPrEjoCXZ2ww2xI
mKoXLLMN1I0nigiLH9hZMHObNIvgC0IRTF6W3v78SbpEOorx6su7Me57u+Pwj2sf
y/Eo1VMy2eNECNwCk32eLdaDkeQ1+hXu+YMo1UJJZ0KfQTQFEwc9Nn9Y6byZ9lgF
QZiXmKQ4KSmhzmR02wdzU5IIg0FzQl8fc4G05BQGXJ4DJN3OLUxClBbHNCIiyRXT
D5uK9QjFN24Fm6TYpVd4sCIwYhFG/XfCLhLDT4RPVX5VEuUVZwDbhIX9n79JAHyT
zG2V19K7bYs0wNWSbF90TH/cpZkb7g6rpbbAgQUBugDJ4SRPDMpswQmoyTmYIAyq
/2Mg50enFH8F7jdm7rmNZjilV/EOWOlkuPvNNcS2NqZzFi8Jk1wtmXqc1sqDw+At
8HZWZ+E5/O3xolcGbIbp
=XMQa
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--


--===============2051650222036589256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2051650222036589256==--
