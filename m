From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: RE: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Thu, 4 Jun 2009 06:02:24 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D5372710@zmy16exm69.ds.mot.com>
References: <874ouyay8i.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C9E497.060FDD04"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail119.messagelabs.com ([216.82.241.195]:52942 "EHLO
	mail119.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbZFCWDJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 18:03:09 -0400
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate5.mot.com (8.14.3/8.14.3) with ESMTP id n53M39BN021336
	for <linux-omap@vger.kernel.org>; Wed, 3 Jun 2009 15:03:09 -0700 (MST)
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id n53M39Wa022681
	for <linux-omap@vger.kernel.org>; Wed, 3 Jun 2009 17:03:09 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id n53M36eM022602
	for <linux-omap@vger.kernel.org>; Wed, 3 Jun 2009 17:03:07 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <874ouyay8i.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Mike Chan <mikechan@google.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9E497.060FDD04
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Kevin,

See below for more comments/explanations:

>=20
> I still think there at least a couple different problems going on and
> I think you are addressing some symptoms but not the root cause.
>=20
I understand that combine these two changes in one patch may cause
Some confusion, so this time I separate into two patchs and=20
they are attached.

I agree that I didn't describe the issue more in detail, but I think the
Second patch (also the original one I intended to make) does address
The root cause and not workaround the symptoms.
See below for the problem in detail.

> It would help if you described in more detail the problem(s) you are
> having and which part of this patch fixes which part of your
> problem(s).
>=20
I met this problem when I am using a touch controller that has a
firmware
That does not work in a graceful way, the controller seems to report
Touch event very frequently and seems the HW is too sensitive, this does
not mean the issue Is caused by the controller, I think this just make
the issue exposed more easily.

The controller is using a GPIO to assert interrupt to OMAP, the
interrupt
Line will be dirven low until the OMAP driver reads out the data through
I2C.
On OMAP side, we configure the GPIO interrupt pin to be low level
detect,
The issue is, after the touch driver calls irq_disable, since it is
empty unless
Set the IRQ_DISABLED flag, so next time only the generic handler
function
handle_level_irq is called, this handler just ack to OMAP GPIO IRQ that
is
To clear the IRQ status and mask the GPIO on OMAP side, but since NO
Touch driver IRQ action is called, so the touch Controller can not gets
acknowledged, then the interrupt line will be always driven low by the
external controller, if we check the IRQ status for that GPIO pin, we
will find
The IRQ is always set. This will prevent PER enterring RET/OFF state
since GPIO
Will not acknowledge the IDLE request. The main purpose of the second
patch
Is to clear the level/edge detect registers for OMAP GPIO when their IRQ
is
Disabled, this can ensure the GPIO IRQ status will not be set and
prevent LPM.


> This GPIO interrupt handling code is very sensitive to changes so we
> need to really understand your problem before making changes here.
>=20
I totally undersand this and I am glad to have a thorough understanding
By everyone and maybe we can find a better solution for this issue.
But now seems I need make you guys understand the issue first. :-)

> Also it's quite possible there are bugs in your driver as well.  Is
> there any chance you can reproduce this on a public platform such as
> the 3430SDP using the PM branch? =20
>=20
> If I use the PM branch on SDP, enable the touchscreen and go into
> suspend, I do not see the GPIO driver keeping the system out of
> retention.  In addition, if I add=20
>=20
>   enable_irq_wake(gpio_to_irq(ts_gpio));
>=20
> to the board init code, I can also use the touchscreen as a wakeup
> source and it does not prevent retention so you should be able to
> reproduce there.
You can say that my touch controller is somehow buggy since it reports
Events very frequently and will always keep the interrupt line low
unless it is
Acknowledged by the touch driver, but I think more important is we can
not
Expect and *assume* all the peripherals to work as well as we expected,
The OMAP GPIO framework should be robust enough to handle such cases
Since it will act as a risky hole for PM on OMAP.

I understand that this will be hard to reproduce if the Touch controller
works
Very gracefully, even for us, we do not see the problem on some other
HWs
Since the controller will not report events/interupts so frequently.

Enable_irq_wake and disable_irq_wake is working regardless of irq
enabled or disabled
Since on OMAP3, they are using IOPAD wakeup(If PER is in RET/OFF) or
module level wakeup(if PER is ACTIVE), and the code is handled by gpio
suspend/resume functions, see more below.

> > 1: irq mask/unmask are typically used by the IRQ handling framework
> > or CHIP IRQ handler to disable and enable IRQ during the IRQ handing
> > procedure;=20
>=20
> The mask/unmask are also used by the lazy disable feature of the
> generic IRQ code.  More on this below...
I tried to figureout but didn't find any comment on what is the issue
fixed
By this lazy irq disable or what we can benefit from this lazy irq
disable,
Seems the change is mainly for x86.

>=20
> The driver's ISR should *never* be called after disable_irq().
> However, the actual interrupt may still fire.  Here is what is
> _supposed_ to happen.
> ............snipped.................
> You could try the patch below[1] which will warn if the triggering
> is not setup properly for a given GPIO IRQ.  This would result
> in a broken lazy disable.
>=20
I can confirm, the irq actions is not called in my case after
irq_disabled
Is called even without my patch, but the patch is not related
With the IRQ handling, what it tries to do is to simply find a place
To clear the level/edge detect settings.


> This is where I disagree.  Basically, I think things you are doing in
> disable are either done elsewhere already, or should be.
>=20
> IOW, you're new disable hook does the equivalent of:
>=20
>   irq_chip->mask(irq)
>   irq_chip->set_wake(irq, 0); /* a.k.a. disable_irq_wake() */
>   irq_chip->ack(irq);
>=20
> The lazy disable will take care of the mask (and ack if it's level
> triggered).  And if you don't want your driver's IRQ to be a wakeup
> event, you should also call disable_irq_wake() in your driver if you
> really want wakeup events disabled.
>=20
> Your enable hook does he equivalent of
>=20
>   irq_chip->set_wake(irq, 1); /* a.k.a. enable_irq_wake(irq); */
>   irq_chip->unmask(irq);
>=20
> Which is the same as your driver doing:
>=20
>   enable_irq_wake(irq);
>   enable_irq(irq);
>=20
> So your driver should be simply add enable_irq_wake() if it wants to
> (re)enable the wakeup feature.
I think you may ignored the most imortant change I want to make. :-)
That is to clear the GPIO level/edge detect settings, since for OMAP,
The GPIO module will set IRQ status based on the settings and
External GPIO input signals and regardless of the IRQ EN settings,
This is the main issue I want to address. Since most likely, some
peripherals
May drive the interrupt line to assert interrupts, there is no issue if
the GPIO
Is enabled by drivers, since the IRQ status will be cleared and the
controller
Will be also ACKed, but think about the case that the IRQ is disabled at
The GPIO HW level which means no even generic IRQ handler will be
Called, thus the IRQ status will be always pending there.

We met more than once such issues that pending GPIO IRQ status will
Prevent low power mode.

This is what I want to address, but there is no such API combination can
Do this unless we have the new disable_irq and enable_irq hooks. Though
Set_irq_type may change the level/detect settings, but we can not
Put such omap specfic hooks in the generic driver code. That is why
I added the two new hooks.In fact, the change does not provide any
new fundamental APIs, It just combine some existing APIs for OMAP
GPIO special settings.=20

>=20
> Stated in another way, and possibly more simply, disable_irq() does
> not imply disable_irq_wake() and enable_irq() does not imply
> enable_irq_wake().
>=20
I unserstand this. Wakeup is indepent of irq enable/disable. The
_set_gpio_wakeup function just sets bank->suspend_wakeup
Which is used in gpio suspend/resume, and specially for OMAP3,
The code configures IOPAD wakeup.


> There is a possible bug here in the case of edge triggered interrupts:
> a disable_irq() will not result in an irq_chip->ack().  Therfore,
> pending IRQs that are not wakeup-enabled should probably be ACK'd in
> the prepare_to_idle hook, or possibly in the set_wake() hook.  In the
> disable case of set_wake(), if the IRQ is disabled, any pending IRQs
> should be cleared.
I think there is no issue with edge interrupt handling since the generic
Handler handle_edge_irq can still be called after disable_irq as long
As the IRQ is pending in the IRQ status register. The generic handler
will
ACK the IRQ(means clear the IRQ status).

I think current set_wake should be ok, no need try to clear IRQ status,
Since IRQ staus will be set *ANY TIME* when the external input signal
Meets the level/edge detect conditions. This is the key point, IRQ
status
Will be set even when IRQEN bit is cleared, that is why we need clear
The level/edge detect also.

>=20
> Yes, please send that part as a separate fix as it is a clear bugfix.
> Also, it's probably better to put the TRM reference in the git
> changelog instead of the code as those section numbers will become out
> of date shortly.
Done. Sent in attachement. 0001-Only........patch

>=20
> So, IIUC, your drivers ISR is being called after disable_irq()?  If
> so, something has gone horribly wrong.  This should not be possible
> with the genirq framework.  Again, it would be nice to reproduce this
> using the touchscreen on the SDP using the PM branch.  Please try
> with my patch below[1] and tell me if you see any warnings.
>=20
No, my driver action handler is not called, but the generic handler is
called,
But the issue is the external interupt signal will not be released
unless
The driver's action handler ack's the external controller.

>=20
> Sorry, I said the prepare_for/resume_from idle hooks but I was
> thinking of the suspend/resume hooks....
>=20
> > But for OMAP3, there is no non-wakeup gpio, all the GPIOs are wakeup
> > gpios.
>=20
> On OMAP3, all GPIOs are wakeup capable, but by non-wakeup GPIO is
> meant GPIOs that are not *configured* for wakeup.  =20
>=20
> The suspend hook will ensure that wakeups are disabled for any non
> wake-enabled GPIO and restore them on resume.
>=20
My understanding is we have two majors places that related with GPIO
WAKEUP.
1: suspend/resume hooks, I think this is just for the wakeup from system
wide suspend,
And will only enable wakeup for those GPIOs that the driver explictly
calls
enable_irq_wake, if driver does not call this explicitly, then no wakeup
will happen on that pin.
Suspend/resume hooks will not do anything else.
2: omap2_gpio_prepare_for_idle/omap2_gpio_resume_after_idle, for OMAP2,
It tries to workaround the non-wakeup gpio issue which may cause
spurious interrupts
If we enable edge detection on those GPIOs, but for OMAP3, the hooks are
used similarly
To avoid any edge GPIO interrupt lossing, since once PER enters RET/OFF,
only IOPAD
Wakeup events can happen and only IO wakeup interrupt can be seen by
ARM,
After GPIO context is restored, since the external GPIO input ls already
at a high/low level,
There is no edge can be detected by the GPIO module any more, so we
check the GPIO inputs
And compare it with the input level before IDLE, if it changes, then we
trigger a GPIO IRQ
By setting LEVEL detect register. This is needed for OMAP3 since we also
met the issue that
The edge interrupt is lost during PER RET/OFF.

None of the above hooks can address the issue I am facing now, since
none of the hooks
Will CLEAR the level/edge settings for those GPIO with IRQ disabled.

> >
>=20
> Hope this helps,
>=20
> Kevin
>=20

------_=_NextPart_001_01C9E497.060FDD04
Content-Type: application/octet-stream;
	name="0001-Only-enable-WAKEUPEN-for-edge-detection-GPIOs.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Only-enable-WAKEUPEN-for-edge-detection-GPIOs.patch
Content-Disposition: attachment;
	filename="0001-Only-enable-WAKEUPEN-for-edge-detection-GPIOs.patch"

RnJvbSBjOWUwY2ZjNTQ0YmQzMGNmNWVjZmQ3N2ZlMDNmZDUyMzM2MzQ0YjBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHVucWl1IFdhbmcgPGNxd2FuZ0Btb3Rvcm9sYS5jb20+CkRh
dGU6IFRodSwgNCBKdW4gMjAwOSAwNDoyOTowMiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIE9ubHkg
ZW5hYmxlIFdBS0VVUEVOIGZvciBlZGdlIGRldGVjdGlvbiBHUElPcywKIHNlZSBPTUFQMzR4eF9F
UzMuMV9UUk1fVl9RIEcyNS41LjMuMQogRm9yIE9NQVAzLCBvbmx5IGVkZ2UgR1BJT3MgbWF5IGxv
c2UgaW50ZXJydXB0cwogd2hlbiBQRVIgZW50ZXJzIFJFVC9PRkYgc3RhdGUsIHRoaXMgaXMgYWRk
cmVzc2VkCiBieSBncGlvIHByZXBhcmV8cmVzdW1lIGlkbGUgZnVuY3Rpb25zCgoKU2lnbmVkLW9m
Zi1ieTogQ2h1bnFpdSBXYW5nIDxjcXdhbmdAbW90b3JvbGEuY29tPgotLS0KIGFyY2gvYXJtL3Bs
YXQtb21hcC9ncGlvLmMgfCAgIDE0ICsrKysrKysrKysrKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxh
dC1vbWFwL2dwaW8uYyBiL2FyY2gvYXJtL3BsYXQtb21hcC9ncGlvLmMKaW5kZXggYmQwNGI0MC4u
MTMzNTQyNCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2dwaW8uYworKysgYi9hcmNo
L2FybS9wbGF0LW9tYXAvZ3Bpby5jCkBAIC01OTcsNyArNTk3LDExIEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBzZXRfMjR4eF9ncGlvX3RyaWdnZXJpbmcoc3RydWN0IGdwaW9fYmFuayAqYmFuaywgaW50
IGdwaW8sCiAJCXRyaWdnZXIgJiBJUlFfVFlQRV9FREdFX0ZBTExJTkcpOwogCiAJaWYgKGxpa2Vs
eSghKGJhbmstPm5vbl93YWtldXBfZ3Bpb3MgJiBncGlvX2JpdCkpKSB7Ci0JCWlmICh0cmlnZ2Vy
ICE9IDApCisJCS8qCisJCSAqIEdQSU8gd2FrZXVwIHJlcXVlc3QgY2FuIG9ubHkgYmUgZ2VuZXJh
dGVkIG9uIGVkZ2UKKwkJICogdHJhbnNpdGlvbnMKKwkJICovCisJCWlmICgodHJpZ2dlciAmIElS
UV9UWVBFX0VER0VfQk9USCkgIT0gMCkKIAkJCV9fcmF3X3dyaXRlbCgxIDw8IGdwaW8sIGJhbmst
PmJhc2UKIAkJCQkJKyBPTUFQMjRYWF9HUElPX1NFVFdLVUVOQSk7CiAJCWVsc2UKQEAgLTYwNiw3
ICs2MTAsMTMgQEAgc3RhdGljIGlubGluZSB2b2lkIHNldF8yNHh4X2dwaW9fdHJpZ2dlcmluZyhz
dHJ1Y3QgZ3Bpb19iYW5rICpiYW5rLCBpbnQgZ3BpbywKIAl9CiAJLyogVGhpcyBwYXJ0IG5lZWRz
IHRvIGJlIGV4ZWN1dGVkIGFsd2F5cyBmb3IgT01BUDM0eHggKi8KIAlpZiAoY3B1X2lzX29tYXAz
NHh4KCkgfHwgKGJhbmstPm5vbl93YWtldXBfZ3Bpb3MgJiBncGlvX2JpdCkpIHsKLQkJaWYgKHRy
aWdnZXIgIT0gMCkKKwkJLyoKKwkJICogTG9nIHRoZSBlZGdlIGdwaW8gYW5kIG1hbnVhbGx5IHRy
aWdnZXIgdGhlIElSUQorCQkgKiBhZnRlciByZXN1bWUgaWYgdGhlIGlucHV0IGxldmVsIGNoYW5n
ZXMKKwkJICogdG8gYXZvaWQgaXJxIGxvc3QgZHVyaW5nIFBFUiBSRVQvT0ZGIG1vZGUKKwkJICog
QXBwbGllcyBmb3Igb21hcDIgbm9uLXdha2V1cCBncGlvIGFuZCBhbGwgb21hcDMgZ3Bpb3MKKwkJ
ICovCisJCWlmICgodHJpZ2dlciAmIElSUV9UWVBFX0VER0VfQk9USCkgIT0gMCkKIAkJCWJhbmst
PmVuYWJsZWRfbm9uX3dha2V1cF9ncGlvcyB8PSBncGlvX2JpdDsKIAkJZWxzZQogCQkJYmFuay0+
ZW5hYmxlZF9ub25fd2FrZXVwX2dwaW9zICY9IH5ncGlvX2JpdDsKLS0gCjEuNS40LjMKCg==

------_=_NextPart_001_01C9E497.060FDD04
Content-Type: application/octet-stream;
	name="0002-Clear-GPIO-level-edge-detect-settings-when-IRQ-is-di.patch"
Content-Transfer-Encoding: base64
Content-Description: 0002-Clear-GPIO-level-edge-detect-settings-when-IRQ-is-di.patch
Content-Disposition: attachment;
	filename="0002-Clear-GPIO-level-edge-detect-settings-when-IRQ-is-di.patch"

RnJvbSA2ODUyM2FkYWNhMGEzZTViYzdjNmIxZjE5NTBmZjQwYTQxNTM2ZTY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHVucWl1IFdhbmcgPGNxd2FuZ0Btb3Rvcm9sYS5jb20+CkRh
dGU6IFRodSwgNCBKdW4gMjAwOSAwNDo0MDoxMCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIENsZWFy
IEdQSU8gbGV2ZWwvZWRnZSBkZXRlY3Qgc2V0dGluZ3Mgd2hlbiBJUlEgaXMgZGlzYWJsZWQgYnkg
ZHJpdmVycwogUGVuZGluZyBJUlEgc3RhdHVzIHdpbGwgcHJldmVudCBQRVIgYW5kIENPUkUgdHJh
bnNpdGlvbiB0byBSRVQvT0ZGIHN0YXRlCiBHUElPIElSUSBzdGF0dXMgYml0IG1heWJlIHNldCBl
dmVuIHdoZW4gSVJRIGlzIGRpc2FibGVkIGlmIHRoZSBpbnB1dAogc2lnbmFsIG1lZXRzIHRoZSBs
ZXZlbC9lZGdlIGRldGVjdCBzZXR0aW5ncyBvbiBPTUFQMi8zLgogU2VlIE9NQVAzNHh4X0VTMy4x
X1RSTV9WX1EgRzI1LjUuMy4xIEdQSU8gaW50ZXJydXB0IGFuZCB3YWtldXAgZW5hYmxlIG5vdGUu
CgoKU2lnbmVkLW9mZi1ieTogQ2h1bnFpdSBXYW5nIDxjcXdhbmdAbW90b3JvbGEuY29tPgotLS0K
IGFyY2gvYXJtL3BsYXQtb21hcC9ncGlvLmMgfCAgIDM2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQogMSBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9ncGlvLmMgYi9hcmNoL2Fy
bS9wbGF0LW9tYXAvZ3Bpby5jCmluZGV4IDEzMzU0MjQuLmMzNTY1NDIgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL3BsYXQtb21hcC9ncGlvLmMKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2dwaW8uYwpA
QCAtNTgxLDcgKzU4MSw3IEBAIHZvaWQgb21hcF9zZXRfZ3Bpb19kZWJvdW5jZV90aW1lKGludCBn
cGlvLCBpbnQgZW5jX3RpbWUpCiBFWFBPUlRfU1lNQk9MKG9tYXBfc2V0X2dwaW9fZGVib3VuY2Vf
dGltZSk7CiAKICNpZiBkZWZpbmVkKENPTkZJR19BUkNIX09NQVAyNFhYKSB8fCBkZWZpbmVkKENP
TkZJR19BUkNIX09NQVAzNFhYKQotc3RhdGljIGlubGluZSB2b2lkIHNldF8yNHh4X2dwaW9fdHJp
Z2dlcmluZyhzdHJ1Y3QgZ3Bpb19iYW5rICpiYW5rLCBpbnQgZ3BpbywKK3N0YXRpYyB2b2lkIHNl
dF8yNHh4X2dwaW9fdHJpZ2dlcmluZyhzdHJ1Y3QgZ3Bpb19iYW5rICpiYW5rLCBpbnQgZ3BpbywK
IAkJCQkJCWludCB0cmlnZ2VyKQogewogCXZvaWQgX19pb21lbSAqYmFzZSA9IGJhbmstPmJhc2U7
CkBAIC0xMTQzLDYgKzExNDMsMzggQEAgc3RhdGljIHZvaWQgZ3Bpb19hY2tfaXJxKHVuc2lnbmVk
IGludCBpcnEpCiAJX2NsZWFyX2dwaW9faXJxc3RhdHVzKGJhbmssIGdwaW8pOwogfQogCitzdGF0
aWMgdm9pZCBncGlvX2VuYWJsZV9pcnEodW5zaWduZWQgaW50IGlycSkKK3sKKwl1bnNpZ25lZCBp
bnQgZ3BpbyA9IGlycSAtIElIX0dQSU9fQkFTRTsKKwlzdHJ1Y3QgZ3Bpb19iYW5rICpiYW5rID0g
Z2V0X2lycV9jaGlwX2RhdGEoaXJxKTsKKwlpbnQgdHJpZ2dlciA9IGlycV9kZXNjW2lycV0uc3Rh
dHVzICYgSVJRX1RZUEVfU0VOU0VfTUFTSzsKKworI2lmIGRlZmluZWQoQ09ORklHX0FSQ0hfT01B
UDI0WFgpIHx8IGRlZmluZWQoQ09ORklHX0FSQ0hfT01BUDM0WFgpCisJc2V0XzI0eHhfZ3Bpb190
cmlnZ2VyaW5nKGJhbmssIGdldF9ncGlvX2luZGV4KGdwaW8pLCB0cmlnZ2VyKTsKKyNlbmRpZgor
CV9zZXRfZ3Bpb19pcnFlbmFibGUoYmFuaywgZ3BpbywgMSk7Cit9CisKK3N0YXRpYyB2b2lkIGdw
aW9fZGlzYWJsZV9pcnEodW5zaWduZWQgaW50IGlycSkKK3sKKwl1bnNpZ25lZCBpbnQgZ3BpbyA9
IGlycSAtIElIX0dQSU9fQkFTRTsKKwlzdHJ1Y3QgZ3Bpb19iYW5rICpiYW5rID0gZ2V0X2lycV9j
aGlwX2RhdGEoaXJxKTsKKworCV9zZXRfZ3Bpb19pcnFlbmFibGUoYmFuaywgZ3BpbywgMCk7Cisj
aWYgZGVmaW5lZChDT05GSUdfQVJDSF9PTUFQMjRYWCkgfHwgZGVmaW5lZChDT05GSUdfQVJDSF9P
TUFQMzRYWCkKKwkvKgorCSAqIENsZWFyIHRoZSBldmVudCBkZXRlY3Qgc2V0dGluZyBhbmQgSVJR
IHN0YXR1cyB0byBwcmV2ZW50CisJICogSVJRIHN0YXVzIGJlZW4gc2V0IGFuZCBwZW5kaW5nIHRo
ZXJlIFdoaWxlIElSUSBpcyBkaXNhYmxlZAorCSAqIGJ5IGRyaXZlcnMsIG90aGVyd2lzZSBHUElP
IG1vZHVsZSB3aWxsIG5vdCBhY2tub3dsZWRnZQorCSAqIHRoZSBJRExFIHJlcXVlc3QgZnJvbSBQ
RVIgcG93ZXIgZG9tYWluLCB0aGlzIG1heSBwcmV2ZW50CisJICogU3lzdGVtIHdpZGUgcmV0ZW50
aW9uCisJICovCisJc2V0XzI0eHhfZ3Bpb190cmlnZ2VyaW5nKGJhbmssIGdldF9ncGlvX2luZGV4
KGdwaW8pLCBJUlFfVFlQRV9OT05FKTsKKwlfY2xlYXJfZ3Bpb19pcnFzdGF0dXMoYmFuaywgZ3Bp
byk7CisjZW5kaWYKKworfQorCiBzdGF0aWMgdm9pZCBncGlvX21hc2tfaXJxKHVuc2lnbmVkIGlu
dCBpcnEpCiB7CiAJdW5zaWduZWQgaW50IGdwaW8gPSBpcnEgLSBJSF9HUElPX0JBU0U7CkBAIC0x
MTcwLDYgKzEyMDIsOCBAQCBzdGF0aWMgdm9pZCBncGlvX3VubWFza19pcnEodW5zaWduZWQgaW50
IGlycSkKIHN0YXRpYyBzdHJ1Y3QgaXJxX2NoaXAgZ3Bpb19pcnFfY2hpcCA9IHsKIAkubmFtZQkJ
PSAiR1BJTyIsCiAJLnNodXRkb3duCT0gZ3Bpb19pcnFfc2h1dGRvd24sCisJLmVuYWJsZQkJPSBn
cGlvX2VuYWJsZV9pcnEsCisJLmRpc2FibGUJPSBncGlvX2Rpc2FibGVfaXJxLAogCS5hY2sJCT0g
Z3Bpb19hY2tfaXJxLAogCS5tYXNrCQk9IGdwaW9fbWFza19pcnEsCiAJLnVubWFzawkJPSBncGlv
X3VubWFza19pcnEsCi0tIAoxLjUuNC4zCgo=

------_=_NextPart_001_01C9E497.060FDD04--
