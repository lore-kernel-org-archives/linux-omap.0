From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Fri, 22 Jun 2012 13:00:39 +0530
Message-ID: <CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	<87fw9o32v2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87fw9o32v2.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 22, 2012 at 12:32 AM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:
>
>> On Thu, Jun 21, 2012 at 7:12 PM, Keshava Munegowda
>> <keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
>>> This commit 354ab8567ae3107a8cbe7228c3181990ba598aac titled
>>> "Fix OMAP EHCI suspend/resume failure (i693)" is causing
>>> the usb hub and device detection fails in beagle XM
>>> causeing NFS not functional. This affects the core retention too.
>>> The same commit logic needs to be revisted adhering to hwmod and
>>> device tree framework.
>>> for now, this commit id 354ab8567ae3107a8cbe7228c3181990ba598aac
>>> titled "Fix OMAP EHCI suspend/resume failure (i693)" reverted.
>>>
>>> This patch is validated on BeagleXM with NFS support over
>>> usb ethernet and USB mass storage and other device detection.
>>>
>>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>
> [...]
>
>>
>> hi kevin
>>
>> here is pm count log on beagle XM with the above patch:
>
> What are you meaning to show by this log?
>
> This dump shows that neither PER or CORE are hitting retention in idl=
e.
> Which sounds to me like you have not enabled UART runtime suspend:
>
> echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay=
_ms
> echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay=
_ms
> echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay=
_ms
> echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay=
_ms
>
> My test with your patch shows that it fixes the oops during boot, and
> doesn't hang during suspend, but that USB host is still preventing CO=
RE
> retention during idle (after UART runtime suspend is enabled.)
>
> This happens on 3530/Overo, 3630/Beagle-xM and 3730/Overo
>
> Setting CONFIG_MFD_OMAP_USB_HOST=3Dn allows CORE to hit retention aga=
in.
>
> Kevin



Hi kevin
       It woks. only the log was wrong. I was using no_console_suspend
in boot args.
i removed it. now I can see the core retention hits with USB host in Be=
agle XM.
below is the log:

Please press Enter to activate this console.
/ #
/ #
/ # echo mem > /sys/power/state
[   18.730499] PM: Syncing filesystems ... done.
[   18.735076] PM: Preparing system for mem sleep
[   18.777343] Freezing user space processes ... (elapsed 0.02 seconds)=
 done.
[   18.808410] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   18.816131] PM: Entering mem sleep
[   18.819702] Suspending console(s) (use no_console_suspend to debug)
[   18.832000] usb 1-2.1: usb suspend, wakeup 0
[   18.855285] hub 1-2:1.0: hub_suspend
[   18.855529] usb 1-2: unlink qh256-0001/dec8ca40 start 1 [1/0 us]
[   18.855957] usb 1-2: usb suspend, wakeup 0
[   18.878417] hub 1-0:1.0: hub_suspend
[   18.878479] usb usb1: bus suspend, wakeup 0
[   18.878479] ehci-omap ehci-omap.0: suspend root hub
[   18.991302] PM: suspend of devices complete after 161.865 msecs
[   18.993865] PM: late suspend of devices complete after 2.502 msecs
[   18.998443] PM: noirq suspend of devices complete after 4.547 msecs
[   18.998504] Disabling non-boot CPUs ...
[   19.257965] Successfully put all powerdomains to target state
[   19.260253] PM: noirq resume of devices complete after 2.105 msecs
[   19.263336] PM: early resume of devices complete after 1.739 msecs
[   19.571258] usb usb1: usb resume
[   19.571258] ehci-omap ehci-omap.0: resume root hub after power loss
[   19.614288] hub 1-0:1.0: hub_resume
[   19.614501] hub 1-0:1.0: port 2: status 0000 change 0000
[   19.615020] hub 1-0:1.0: port 2 status 0000.0000 after resume, -19
[   19.615020] usb 1-2: can't resume, status -19
[   19.615020] hub 1-0:1.0: logical disconnect on port 2
[   19.615600] PM: resume of devices complete after 352.111 msecs
[   19.735168] PM: Finishing wakeup.
[   19.739715] hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0000
[   19.745544] hub 1-0:1.0: port 2, status 0000, change 0000, 12 Mb/s
[   19.752105] usb 1-2: USB disconnect, device number 2
[   19.757385] usb 1-2.1: USB disconnect, device number 3
[   19.762817] usb 1-2.1: unregistering device
[   19.767211] usb 1-2.1: unregistering interface 1-2.1:1.0
[   19.783142] Restarting tasks ... done.
/ # [   19.798645] usb 1-2.1: usb_disable_device nuking all URBs
[   19.813323] usb 1-2: unregistering device
[   19.817718] usb 1-2: unregistering interface 1-2:1.0
[   19.841735] usb 1-2: usb_disable_device nuking all URBs

/ # [   22.200866] hub 1-0:1.0: hub_suspend
[   22.204864] usb usb1: bus auto-suspend, wakeup 1
[   22.209838] ehci-omap ehci-omap.0: suspend root hub

/ #
/ #
/ # mkdir /debug
mount -t debugfs debugfs / # mount -t debugfs debugfs /debug
/ #
/ #
/ # echo mem > /sys/power/state
[   74.603454] PM: Syncing filesystems ... done.
[   74.608215] PM: Preparing system for mem sleep
[   74.637695] Freezing user space processes ... (elapsed 0.02 seconds)=
 done.
[   74.661132] Freezing remaining freezable tasks ... (elapsed 0.01
seconds) done.
[   74.668853] PM: Entering mem sleep
[   74.672424] Suspending console(s) (use no_console_suspend to debug)
[   74.685516] usb usb1: usb auto-resume
[   74.685546] ehci-omap ehci-omap.0: resume root hub
[   74.762573] hub 1-0:1.0: hub_resume
[   74.762817] hub 1-0:1.0: hub_suspend
[   74.762847] usb usb1: bus suspend, wakeup 0
[   74.762878] ehci-omap ehci-omap.0: suspend root hub
[   74.875061] PM: suspend of devices complete after 192.942 msecs
[   74.877441] PM: late suspend of devices complete after 2.349 msecs
[   74.881591] PM: noirq suspend of devices complete after 4.118 msecs
[   74.881591] Disabling non-boot CPUs ...
[   75.162689] Successfully put all powerdomains to target state
[   75.164886] PM: noirq resume of devices complete after 2.044 msecs
[   75.167785] PM: early resume of devices complete after 1.555 msecs
[   75.476531] usb usb1: usb resume
[   75.476562] ehci-omap ehci-omap.0: resume root hub after power loss
[   75.551544] hub 1-0:1.0: hub_resume
[   75.552032] PM: resume of devices complete after 384.123 msecs
[   75.643096] PM: Finishing wakeup.
[   75.647155] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   75.657257] Restarting tasks ... done.
/ #
/ # [   77.653442] hub 1-0:1.0: hub_suspend
[   77.657257] usb usb1: bus auto-suspend, wakeup 1
[   77.662200] ehci-omap ehci-omap.0: suspend root hub

/ # cat /debug/pm_debug/co
/debug/pm_debug/core_pwrdm/  /debug/pm_debug/count
/ # cat /debug/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
dss_pwrdm (ON),OFF:0,RET:565,INA:0,ON:566,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
neon_pwrdm (ON),OFF:0,RET:565,INA:0,ON:566,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:565,INA:0,ON:566,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (3)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
core_l4_clkdm->core_pwrdm (25)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)
/ #
/ #
/ # cat /debug/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
dss_pwrdm (ON),OFF:0,RET:676,INA:0,ON:677,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
neon_pwrdm (ON),OFF:0,RET:676,INA:0,ON:677,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:676,INA:0,ON:677,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (3)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
core_l4_clkdm->core_pwrdm (25)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)
/ # cat /debug/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
dss_pwrdm (ON),OFF:0,RET:760,INA:0,ON:761,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
neon_pwrdm (ON),OFF:0,RET:760,INA:0,ON:761,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:760,INA:0,ON:761,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (3)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
core_l4_clkdm->core_pwrdm (25)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)
/ #
/ # echo mem > /sys/power/state
[  136.349517] PM: Syncing filesystems ... done.
[  136.354125] PM: Preparing system for mem sleep
[  136.380157] Freezing user space processes ... (elapsed 0.02 seconds)=
 done.
[  136.411437] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[  136.419158] PM: Entering mem sleep
[  136.422729] Suspending console(s) (use no_console_suspend to debug)
[  136.435882] usb usb1: usb auto-resume
[  136.435913] ehci-omap ehci-omap.0: resume root hub
[  136.512481] hub 1-0:1.0: hub_resume
[  136.512634] hub 1-0:1.0: hub_suspend
[  136.512695] usb usb1: bus suspend, wakeup 0
[  136.512695] ehci-omap ehci-omap.0: suspend root hub
[  136.624847] PM: suspend of devices complete after 192.612 msecs
[  136.627227] PM: late suspend of devices complete after 2.319 msecs
[  136.631378] PM: noirq suspend of devices complete after 4.151 msecs
[  136.631408] Disabling non-boot CPUs ...
[  137.409423] Successfully put all powerdomains to target state
[  137.411590] PM: noirq resume of devices complete after 2.045 msecs
[  137.414489] PM: early resume of devices complete after 1.556 msecs
[  137.723266] usb usb1: usb resume
[  137.723266] ehci-omap ehci-omap.0: resume root hub after power loss
[  137.798187] hub 1-0:1.0: hub_resume
[  137.798583] PM: resume of devices complete after 383.972 msecs
[  137.889617] PM: Finishing wakeup.
[  137.893676] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[  137.903594] Restarting tasks ... done.
/ #
/ #
/ # echo mem > /sys/power/state[  140.259704] hub 1-0:1.0: hub_suspend
[  140.263519] usb usb1: bus auto-suspend, wakeup 1
[  140.268463] ehci-omap ehci-omap.0: suspend root hub
/ # cat /debug/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:3,INA:0,ON:4,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
core_pwrdm (ON),OFF:0,RET:3,INA:0,ON:4,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:3,INA:0,ON:4,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
dss_pwrdm (ON),OFF:0,RET:905,INA:0,ON:906,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
neon_pwrdm (ON),OFF:0,RET:905,INA:0,ON:906,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:905,INA:0,ON:906,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (3)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
core_l4_clkdm->core_pwrdm (25)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)
/ # echo mem > /sys/power/state
[ 1851.239776] PM: Syncing filesystems ... done.
[ 1851.244506] PM: Preparing system for mem sleep
[ 1851.268096] Freezing user space processes ... (elapsed 0.01 seconds)=
 done.
[ 1851.291290] Freezing remaining freezable tasks ... (elapsed 0.01
seconds) done.
[ 1851.299011] PM: Entering mem sleep
[ 1851.302581] Suspending console(s) (use no_console_suspend to debug)
[ 1851.315734] usb usb1: usb auto-resume
[ 1851.315734] ehci-omap ehci-omap.0: resume root hub
[ 1851.392547] hub 1-0:1.0: hub_resume
[ 1851.392730] hub 1-0:1.0: hub_suspend
[ 1851.392761] usb usb1: bus suspend, wakeup 0
[ 1851.392791] ehci-omap ehci-omap.0: suspend root hub
[ 1851.504852] PM: suspend of devices complete after 192.961 msecs
[ 1851.507232] PM: late suspend of devices complete after 2.382 msecs
[ 1851.511383] PM: noirq suspend of devices complete after 4.123 msecs
[ 1851.511413] Disabling non-boot CPUs ...
[ 1852.511322] Successfully put all powerdomains to target state
[ 1852.513519] PM: noirq resume of devices complete after 2.046 msecs
[ 1852.516418] PM: early resume of devices complete after 1.588 msecs
[ 1852.825164] usb usb1: usb resume
[ 1852.825164] ehci-omap ehci-omap.0: resume root hub after power loss
[ 1852.900085] hub 1-0:1.0: hub_resume
[ 1852.900482] PM: resume of devices complete after 383.948 msecs
[ 1852.991546] PM: Finishing wakeup.
[ 1852.995574] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[ 1853.005676] Restarting tasks ... done.
/ # cat /debug/pm_debug/count [ 1855.259979] hub 1-0:1.0: hub_suspend
[ 1855.263793] usb usb1: bus auto-suspend, wakeup 1
[ 1855.268707] ehci-omap ehci-omap.0: suspend root hub

usbhost_pwrdm (ON),OFF:0,RET:4,INA:0,ON:5,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
core_pwrdm (ON),OFF:0,RET:4,INA:0,ON:5,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:4,INA:0,ON:5,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
dss_pwrdm (ON),OFF:0,RET:2805,INA:0,ON:2806,RET-LOGIC-OFF:0,RET-MEMBANK=
1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
neon_pwrdm (ON),OFF:0,RET:2805,INA:0,ON:2806,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:2805,INA:0,ON:2806,RET-LOGIC-OFF:0,RET-MEMBANK=
1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (3)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
core_l4_clkdm->core_pwrdm (25)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)
/ # echo mem > /sys/power/state
[ 2278.128540] PM: Syncing filesystems ... done.
[ 2278.133117] PM: Preparing system for mem sleep
[ 2278.159027] Freezing user space processes ... (elapsed 0.01 seconds)=
 done.
[ 2278.182220] Freezing remaining freezable tasks ... (elapsed 0.01
seconds) done.
[ 2278.189941] PM: Entering mem sleep
[ 2278.193511] Suspending console(s) (use no_console_suspend to debug)
[ 2278.206726] usb usb1: usb auto-resume
[ 2278.206756] ehci-omap ehci-omap.0: resume root hub
[ 2278.283477] hub 1-0:1.0: hub_resume
[ 2278.283660] hub 1-0:1.0: hub_suspend
[ 2278.283691] usb usb1: bus suspend, wakeup 0
[ 2278.283721] ehci-omap ehci-omap.0: suspend root hub
[ 2278.395782] PM: suspend of devices complete after 192.952 msecs
[ 2278.398162] PM: late suspend of devices complete after 2.352 msecs
[ 2278.402313] PM: noirq suspend of devices complete after 4.123 msecs
[ 2278.402313] Disabling non-boot CPUs ...
[ 2278.898864] Successfully put all powerdomains to target state
[ 2278.901062] PM: noirq resume of devices complete after 2.046 msecs
[ 2278.903961] PM: early resume of devices complete after 1.557 msecs
[ 2279.212676] usb usb1: usb resume
[ 2279.212676] ehci-omap ehci-omap.0: resume root hub after power loss
[ 2279.287628] hub 1-0:1.0: hub_resume
[ 2279.288024] PM: resume of devices complete after 383.916 msecs
[ 2279.379058] PM: Finishing wakeup.
[ 2279.383087] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[ 2279.393005] Restarting tasks ... done.
/ #
/ #
/ # cat /debug/pm_debug/count [ 2281.756500] hub 1-0:1.0: hub_suspend
[ 2281.760314] usb usb1: bus auto-suspend, wakeup 1
[ 2281.765228] ehci-omap ehci-omap.0: suspend root hub

usbhost_pwrdm (ON),OFF:0,RET:5,INA:0,ON:6,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
core_pwrdm (ON),OFF:0,RET:5,INA:0,ON:6,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:5,INA:0,ON:6,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
dss_pwrdm (ON),OFF:0,RET:3368,INA:0,ON:3369,RET-LOGIC-OFF:0,RET-MEMBANK=
1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
neon_pwrdm (ON),OFF:0,RET:3368,INA:0,ON:3369,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:3368,INA:0,ON:3369,RET-LOGIC-OFF:0,RET-MEMBANK=
1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (3)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
core_l4_clkdm->core_pwrdm (25)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)


>> regards
>> keshava
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
