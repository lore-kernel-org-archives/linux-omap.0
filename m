From: Bharathraj Nagaraju <bharathraj.nagaraju@sasken.com>
Subject: RE: Reg: USB: ehci-omap: Suspend the controller during idle.
Date: Mon, 26 Aug 2013 11:29:19 +0000
Message-ID: <88EA9DA16B788648836D263C936F15C2D8FA@exgmbxfz02.sasken.com>
References: <8D86EEFC18AF0D43A2B8E0ABFA8B88A17B16B9455E@EXGMBX01.sasken.com>,<520107C5.20803@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_88EA9DA16B788648836D263C936F15C2D8FAexgmbxfz02saskencom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-blr1.sasken.com ([203.200.200.72]:40778 "EHLO
	mta-blr1.sasken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab3HZL3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Aug 2013 07:29:30 -0400
In-Reply-To: <520107C5.20803@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

--_002_88EA9DA16B788648836D263C936F15C2D8FAexgmbxfz02saskencom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear All,

With continuation to below mail, our client requirement is pushing us to im=
plement the EHCI runtime suspend/resume.

I have implemented EHCI runtime suspend/resume using timer concept,Please f=
ind the below design and attached patch for the same.

Design Approach:
     - A timer of 10sec is scheduled.
     - During EHCI transaction (tx/rx), this timer is reset.
       If the EHCI clocks are switched off, it is switched on before any ac=
tual
       transaction.
     - If there are no transaction on EHCI for >10secs, the timer callback =
is invoked.
     - EHCI clocks are disabled in the timer expire function.

NOTE : Runtime remote wake up feature need to be implement.

With the above approach the ECHI is suspended,if there are no transaction f=
or > 10secs,during next transaction
i am enabling the clocks and resuming the EHCI controller, but we are getti=
ng below errors and its not working properly

[   66.986175] catalina_wwan_ctrl_attr_wwan_on_show: wwan_on status =3D 1
[   66.993743] ehci-omap ehci-omap.0: ehci_omap_bus_resume
[   66.999542] ehci-omap ehci-omap.0: resume root hub
[   67.024475] ehci_bus_resume: port_status[2]=3D0x501000, PORT_SUSPEND=3D0
[   67.031311] ehci_bus_resume: port_status[1]=3D0x501000, PORT_SUSPEND=3D0
[   67.038238] ehci_bus_resume: port_status[0]=3D0x601885, PORT_SUSPEND=3D1=
28
[   67.079223] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 1
[   67.086090] ehci-omap ehci-omap.0: detected XactErr len 0/512 retry 1
[   67.093139] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 2
[   67.099975] ehci-omap ehci-omap.0: detected XactErr len 0/512 retry 2
[   67.106994] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 3
[   67.113830] ehci-omap ehci-omap.0: detected XactErr len 0/512 retry 3
[   67.120819] ehci-omap ehci-omap.0: detected XactErr len 0/10 retry 4

Can you please guide me why we are getting above errors.

Regards
Bharath

________________________________________
From: Roger Quadros [rogerq@ti.com]
Sent: Tuesday, August 06, 2013 7:57 PM
To: Bharathraj Nagaraju
Cc: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org; Kevin Hilman; Al=
an Stern
Subject: Re: Reg: USB: ehci-omap: Suspend the controller during idle.

Hi,

On 08/06/2013 03:55 PM, Bharathraj Nagaraju wrote:
>   Dear All,
>
>   We are working on omap4470 based device,kernel-3.0.31 is running on thi=
s.
>   In our device modem is connected to OMAP4470 using USB EHCI.
>
>   In our current kernel code, clocks are enabled when ports get connected
>   and disabled during disconnect.Due to this current consumption is more =
in idle use case.
>
>   I have tried to put the host in smart idle/standby mode,due to erratas =
around Host doesn't allow us
>   use smart idle/standby capabilities.
>
>   1) i571: USB host EHCI may stall when entering smart-standby mode
>   2) i660: USBHOST Configured In Smart-Idle Can Lead To a Deadlock
>
>   we are thinking to implement USB EHCI runtime suspend/resume feature.
>
>   In kernel-3.0.31 architecture the usbcore driver is parent of ehci and =
ohci drivers.
>   The ehci and ohci drivers call the pm_runtime_get_sync and pm_runtime_p=
ut_sync of parent device usbhs core.
>
>   From the ehci-omap driver what i can see only partial implementation of=
 runtime PM.
>   what i mean is that runtime PM methods are used only during the normal =
suspend path
>   and when nothing is connected to ports(modem disconnected in our case).
>
>   I am thinking to change the ehci driver code, could claver enough to us=
e runtime PM
>   to disable the hardware when modem is connected and the system is in id=
le state.
>
>   Kindly guide me how can i go about this.
>
>   Let me know if you need further clarification from me on this.
>
>   Thanks for spending your valuable time .......:)


The problem with OMAP EHCI controller is that it needs to rely on IO Daisy =
chain mechanism
to wake up when it is suspended. Without that, we can't really put the cont=
roller in to runtime
suspend, else we will not be able to detect a new device connect.

IO daisy chaining is still not supported in mainline. One approach had been=
 posted [1] and it works
but it is still in transition.

I've made some patches [2] which implement USB runtime suspend with remote =
wakeup working
for OMAP3 beagle-xm board. This depends on [1]. It shouldn't be hard to get=
 it working on OMAP4.

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/101105
[2] http://article.gmane.org/gmane.linux.ports.arm.kernel/251250

cheers,
-roger


________________________________

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, propriet=
ary or legally privileged information. In case you are not the original int=
ended Recipient of the message, you must not, directly or indirectly, use, =
disclose, distribute, print, or copy any part of this message and you are r=
equested to delete it and inform the sender. Any views expressed in this me=
ssage are those of the individual sender unless otherwise stated. Nothing c=
ontained in this message shall be construed as an offer or acceptance of an=
y offer by Sasken Communication Technologies Limited ("Sasken") unless sent=
 with that express intent and with due authority of Sasken. Sasken has take=
n enough precautions to prevent the spread of viruses. However the company =
accepts no liability for any damage caused by any virus transmitted by this=
 email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html

--_002_88EA9DA16B788648836D263C936F15C2D8FAexgmbxfz02saskencom_
Content-Type: text/x-patch;
	name="0001-EHCI-Selective-suspend-resume-implementation-Draft-R.patch"
Content-Description: 0001-EHCI-Selective-suspend-resume-implementation-Draft-R.patch
Content-Disposition: attachment;
	filename="0001-EHCI-Selective-suspend-resume-implementation-Draft-R.patch";
	size=7667; creation-date="Mon, 26 Aug 2013 11:29:02 GMT";
	modification-date="Mon, 26 Aug 2013 11:29:02 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1ZmJlMTdhYTM3MjRiZTk1N2U5MGFjNTcwYTEwODVjNjFkZjMxZjk0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBiaGFyYXRoIDxiaGFyYXRocmFqLm5hZ2FyYWp1QHNhc2tlbi5j
b20+CkRhdGU6IE1vbiwgMjYgQXVnIDIwMTMgMTY6MTg6MTggKzA1MzAKU3ViamVjdDogW1BBVENI
XSBbRUhDSV0gU2VsZWN0aXZlIHN1c3BlbmQvcmVzdW1lIGltcGxlbWVudGF0aW9uIC0gRHJhZnQK
IFJldmlzaW9uIDAuMQoKSXNzdWU6CiBJbiBzeXN0ZW0gSWRsZSBjYXNlLCB0aGUgRUhDSSByZWxh
dGVkIGNsb2NrcyBhcmUga2VwdCBPTi4KIFRoaXMgY29uc3VtZXMgY3VycmVudCBpbiB0aGF0IGNv
bmRpdGlvbi4KCiBEeWFubWljIG1lYW5zIG9mIHN1c3BlbmRpbmcgdGhlIEVIQ0kgY2xvY2tzIHNo
b3VsZCBiZSBkb25lCiBpbiBzeXN0ZW0gaWRsZSBjb25kaXRpb24gdG8gc2F2ZSBtb3JlIHBvd2Vy
LgoKIE5vdGU6CiAgIEluIHN5c3RlbSBzdXNwZW5kIHBhdGgsIHRoZSBFSENJIGNsb2NrcyBhcmUg
ZGlzYWJsZWQgYW5kIGVuYWJsZWQgZHVyaW5nIHJlc3VtZS4KICAgVGhpcyBlbnN1cmUgdGhlIGN1
cnJlbnQgY29uc3VtcHRpb24gaXMgTk9UIGFmZmVjdGVkIGluIHRoZSBzdXNwZW5kIHVzZSBjYXNl
LgoKRGVzaWduIEFwcHJvYWNoOgogLSBBIHRpbWVyIG9mIDEwc2VjIGlzIHNjaGVkdWxlZC4KIC0g
RHVyaW5nIEVIQ0kgdHJhbnNjYXRpb24gKHR4L3J4KSwgdGhpcyB0aW1lciBpcyByZXNldC4KICAg
IElmIHRoZSBFSENJIGNsb2NrcyBhcmUgc3d0aWNoZWQgb2ZmLCBpdCBpcyBzd2l0Y2hlZCBvbiBi
ZWZvcmUgYW55IGFjdHVhbAogICAgdHJhbnNhY3Rpb24uCiAtIElmIHRoZXJlIGFyZSBubyB0cmFu
c2FjdGlvbiBvbiBFSENJIGZvciA+MTBzZWNzLCB0aGUgdGltZXIgY2FsbGJhY2sgaXMgaW52b2tl
ZC4KIC0gRUhDSSBjbG9ja3MgYXJlIGRpc2FibGVkIGluIHRoZSB0aW1lciBleHBpcmUgZnVuY3Rp
b24uCgpTaWduZWQtb2ZmLWJ5OiBiaGFyYXRoIDxiaGFyYXRocmFqLm5hZ2FyYWp1QHNhc2tlbi5j
b20+Ci0tLQogZHJpdmVycy91c2IvaG9zdC9laGNpLWhjZC5jICB8ICAgMjMgKysrKysrKysrKysK
IGRyaXZlcnMvdXNiL2hvc3QvZWhjaS1vbWFwLmMgfCAgIDkwICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy91c2IvaG9zdC9laGNpLmggICAgICB8ICAg
IDYgKysrCiAzIGZpbGVzIGNoYW5nZWQsIDExOSBpbnNlcnRpb25zKCspCiBtb2RlIGNoYW5nZSAx
MDA2NDQgPT4gMTAwNzU1IGRyaXZlcnMvdXNiL2hvc3QvZWhjaS1oY2QuYwogbW9kZSBjaGFuZ2Ug
MTAwNjQ0ID0+IDEwMDc1NSBkcml2ZXJzL3VzYi9ob3N0L2VoY2kuaAoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2hvc3QvZWhjaS1oY2QuYyBiL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1oY2QuYwpv
bGQgbW9kZSAxMDA2NDQKbmV3IG1vZGUgMTAwNzU1CmluZGV4IGJlMGZhZDIuLmE5ODBiNWQKLS0t
IGEvZHJpdmVycy91c2IvaG9zdC9laGNpLWhjZC5jCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QvZWhj
aS1oY2QuYwpAQCAtNDEzLDYgKzQxMywxNSBAQCBzdGF0aWMgdm9pZCBlaGNpX3dhdGNoZG9nKHVu
c2lnbmVkIGxvbmcgcGFyYW0pCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSAoJmVoY2ktPmxvY2ss
IGZsYWdzKTsKIH0KIAorCitzdGF0aWMgdm9pZCBlaGNpX3RpbWVyX2Z1bmMgKHVuc2lnbmVkIGxv
bmcgX2VoY2kpCit7CisgICAgICAgIHN0cnVjdCBlaGNpX2hjZCAgICAgICAgICAqZWhjaSA9IChz
dHJ1Y3QgZWhjaV9oY2QgKilfZWhjaTsKKyAgICAgICAgc3RydWN0IHVzYl9oY2QgKmhjZCA9ZWhj
aV90b19oY2QoZWhjaSk7CisKKwkgICAgZWhjaV9vbWFwX2J1c19jbGtfZGlzYWJsZShoY2QpOwor
fQorCiAvKiBPbiBzb21lIHN5c3RlbXMsIGxlYXZpbmcgcmVtb3RlIHdha2V1cCBlbmFibGVkIHBy
ZXZlbnRzIHN5c3RlbSBzaHV0ZG93bi4KICAqIFRoZSBmaXJtd2FyZSBzZWVtcyB0byB0aGluayB0
aGF0IHBvd2VyaW5nIG9mZiBpcyBhIHdha2V1cCBldmVudCEKICAqIFRoaXMgcm91dGluZSB0dXJu
cyBvZmYgcmVtb3RlIHdha2V1cCBhbmQgZXZlcnl0aGluZyBlbHNlLCBvbiBhbGwgcG9ydHMuCkBA
IC01ODAsNiArNTg5LDEyIEBAIHN0YXRpYyBpbnQgZWhjaV9pbml0KHN0cnVjdCB1c2JfaGNkICpo
Y2QpCiAJZWhjaS0+aWFhX3dhdGNoZG9nLmZ1bmN0aW9uID0gZWhjaV9pYWFfd2F0Y2hkb2c7CiAJ
ZWhjaS0+aWFhX3dhdGNoZG9nLmRhdGEgPSAodW5zaWduZWQgbG9uZykgZWhjaTsKIAorCWluaXRf
dGltZXIoJmVoY2ktPmVoY2lfdGltZXIpOworICAgIGVoY2ktPmVoY2lfdGltZXIuZnVuY3Rpb24g
PSBlaGNpX3RpbWVyX2Z1bmM7CisgICAgZWhjaS0+ZWhjaV90aW1lci5kYXRhID0gKHVuc2lnbmVk
IGxvbmcpIGVoY2k7CisKKyAgICBtb2RfdGltZXIoJmVoY2ktPmVoY2lfdGltZXIsIGppZmZpZXMg
KyBtc2Vjc190b19qaWZmaWVzKDMwMDAwMCkpOworCiAJaGNjX3BhcmFtcyA9IGVoY2lfcmVhZGwo
ZWhjaSwgJmVoY2ktPmNhcHMtPmhjY19wYXJhbXMpOwogCiAJLyoKQEAgLTk3NCw2ICs5ODksMTQg
QEAgc3RhdGljIGludCBlaGNpX3VyYl9lbnF1ZXVlICgKIAlzdHJ1Y3QgZWhjaV9oY2QJCSplaGNp
ID0gaGNkX3RvX2VoY2kgKGhjZCk7CiAJc3RydWN0IGxpc3RfaGVhZAlxdGRfbGlzdDsKIAorCWlm
IChlaGNpLT5laGNpX3N0YXRlKSB7CisJCWVoY2ktPmVoY2lfc3RhdGU9MDsKKwkJZWhjaV9vbWFw
X2J1c19jbGtfZW5hYmxlKGhjZCk7CisJfSBlbHNlIHsKKwkJZGVsX3RpbWVyICgmZWhjaS0+ZWhj
aV90aW1lcik7CisJCW1vZF90aW1lcigmZWhjaS0+ZWhjaV90aW1lciwgamlmZmllcyArIG1zZWNz
X3RvX2ppZmZpZXMoMTAwMDApKTsJCisJfQorCiAJSU5JVF9MSVNUX0hFQUQgKCZxdGRfbGlzdCk7
CiAKIAlzd2l0Y2ggKHVzYl9waXBldHlwZSAodXJiLT5waXBlKSkgewpkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvaG9zdC9laGNpLW9tYXAuYyBiL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1vbWFwLmMK
aW5kZXggZjJmY2VjNS4uYmZhMjg1ZCAxMDA3NTUKLS0tIGEvZHJpdmVycy91c2IvaG9zdC9laGNp
LW9tYXAuYworKysgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktb21hcC5jCkBAIC03OTQsNiArNzk0
LDE0IEBAIHN0YXRpYyBpbnQgZWhjaV9oY2Rfb21hcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQogCQl9CiAJfQogCisvLwlwbV9ydW50aW1lX2VuYWJsZShkZXYtPnBhcmVudCk7
CisJcG1fcnVudGltZV9pcnFfc2FmZShkZXYtPnBhcmVudCk7CisKKyNpZiAwCisJc3Bpbl9sb2Nr
X2lycSgmZGV2LT5wYXJlbnQtPnBvd2VyLmxvY2spOworICAgICAgICBkZXYtPnBhcmVudC0+cG93
ZXIuaXJxX3NhZmUgPSAxOworICAgICAgICBzcGluX3VubG9ja19pcnEoJmRldi0+cGFyZW50LT5w
b3dlci5sb2NrKTsKKyNlbmRpZgogCXBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2LT5wYXJlbnQpOwog
CSpwZGF0YS0+dXNiaHNfdXBkYXRlX3NhciA9IDE7CiAKQEAgLTgxNyw2ICs4MjUsNyBAQCBzdGF0
aWMgaW50IGVoY2lfaGNkX29tYXBfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
IAogCW9tYXBfZWhjaSA9IGhjZF90b19laGNpKGhjZCk7CiAJb21hcF9laGNpLT5zYnJuID0gMHgy
MDsKKwlvbWFwX2VoY2ktPmVoY2lfc3RhdGUgPTA7CiAKIAl3YWtlX2xvY2tfaW5pdCgmKG9tYXBf
ZWhjaS0+d2FrZWxvY2spLCBXQUtFX0xPQ0tfU1VTUEVORCwKIAkJImVoY2lfaGNkLW9tYXAiKTsK
QEAgLTk0NCwxMCArOTUzLDg1IEBAIHN0YXRpYyB2b2lkIGVoY2lfaGNkX29tYXBfc2h1dGRvd24o
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAl9CiB9CiAKK2ludCBlaGNpX29tYXBfYnVz
X2Nsa19lbmFibGUoc3RydWN0IHVzYl9oY2QgKmhjZCkKK3sKKyAgICAgICAgc3RydWN0IGRldmlj
ZSAqZGV2ID0gaGNkLT5zZWxmLmNvbnRyb2xsZXI7CisJCXN0cnVjdCBlaGNpX2hjZF9vbWFwX3Bs
YXRmb3JtX2RhdGEgICAgICAqcGRhdGEgPSBkZXYtPnBsYXRmb3JtX2RhdGE7CisJICAgIHN0cnVj
dCBlaGNpX2hjZCAqZWhjaSA9IGhjZF90b19laGNpKGhjZCk7CisJICAgIHN0cnVjdCBvbWFwX2h3
bW9kICAgICAgICpvaDsKKyAgICAgICAgc3RydWN0IGNsayAqY2xrOworICAgICAgICBpbnQgaTsK
KworICAgICAgICBpbnQgcmV0OworCisgICAgICAgIGRldl9kYmcoZGV2LCAiZWhjaV9vbWFwX2J1
c19yZXN1bWVcbiIpOworCQorICAgICAgICBvaCA9IG9tYXBfaHdtb2RfbG9va3VwKFVTQkhTX0VI
Q0lfSFdNT0ROQU1FKTsKKworICAgICAgICByZXQgPSBvbWFwX2h3bW9kX2Rpc2FibGVfaW9yaW5n
X3dha2V1cChvaCk7CisKKyAgICAgICAgLyogUmUtZW5hYmxlIGFueSBleHRlcm5hbCB0cmFuc2Nl
aXZlciBjbG9ja3MgZmlyc3QgKi8KKyAgICAgICAgcGRhdGEgPSBkZXYtPnBsYXRmb3JtX2RhdGE7
CisgICAgICAgIGZvciAoaSA9IDAgOyBpIDwgT01BUDNfSFNfVVNCX1BPUlRTIDsgaSsrKSB7Cisg
ICAgICAgICAgICAgICAgY2xrID0gcGRhdGEtPnRyYW5zY2VpdmVyX2Nsa1tpXTsKKyAgICAgICAg
ICAgICAgICBpZiAoY2xrKQorICAgICAgICAgICAgICAgICAgICAgICAgY2xrX2VuYWJsZShjbGsp
OworICAgICAgICB9CisKKyAgICAgICAgb21hcF9wbV9zZXRfbWluX2J1c190cHV0KGRldiwKKyAg
ICAgICAgICAgICAgICAgICAgICAgIE9DUF9JTklUSUFUT1JfQUdFTlQsCisgICAgICAgICAgICAg
ICAgICAgICAgICAoMjAwKjEwMDAqNCkpOworCisgICAgICAgIGlmIChkZXYtPnBhcmVudCkKKyAg
ICAgICAgICAgICAgICBwbV9ydW50aW1lX2dldF9zeW5jKGRldi0+cGFyZW50KTsKKworICAgICAg
ICpwZGF0YS0+dXNiaHNfdXBkYXRlX3NhciA9IDE7CisgICAgICAgcmV0dXJuIGVoY2lfYnVzX3Jl
c3VtZShoY2QpOworfQorRVhQT1JUX1NZTUJPTChlaGNpX29tYXBfYnVzX2Nsa19lbmFibGUpOwor
CitpbnQgZWhjaV9vbWFwX2J1c19jbGtfZGlzYWJsZShzdHJ1Y3QgdXNiX2hjZCAqaGNkKQorewor
ICAgICAgIHN0cnVjdCBlaGNpX2hjZCAqZWhjaSA9IGhjZF90b19laGNpKGhjZCk7CisgICAgICAg
c3RydWN0IGRldmljZSAqZGV2ID0gaGNkLT5zZWxmLmNvbnRyb2xsZXI7CisgICAgICAgc3RydWN0
IGVoY2lfaGNkX29tYXBfcGxhdGZvcm1fZGF0YSAgKnBkYXRhOworICAgICAgIHN0cnVjdCBvbWFw
X2h3bW9kICAgICAgICpvaDsKKyAgICAgICBzdHJ1Y3QgY2xrICpjbGs7CisgICAgICAgaW50IHJl
dCA9IDA7CisgICAgICAgaW50IGk7CisKKwllaGNpLT5laGNpX3N0YXRlID0xOworCisJcmV0ID0g
ZWhjaV9idXNfc3VzcGVuZChoY2QpOworCisJaWYgKHJldCAhPSAwKSB7CisgICAgICAgICAgICAg
ICBkZXZfZGJnKGRldiwgImVoY2lfb21hcF9idXNfc3VzcGVuZCBmYWlsZWQgJWRcbiIsIHJldCk7
CisgICAgICAgICAgICAgICByZXR1cm4gcmV0OworICAgICAgIH0KKyAgICAgICBvaCA9IG9tYXBf
aHdtb2RfbG9va3VwKFVTQkhTX0VIQ0lfSFdNT0ROQU1FKTsKKworICAgICAgIG9tYXBfaHdtb2Rf
ZW5hYmxlX2lvcmluZ193YWtldXAob2gpOworCisgICAgICAgaWYgKGRldi0+cGFyZW50KQorICAg
ICAgICAgICAgICAgcG1fcnVudGltZV9wdXRfc3luY19zdXNwZW5kKGRldi0+cGFyZW50KTsKKwor
ICAgICAgICBwZGF0YSA9IGRldi0+cGxhdGZvcm1fZGF0YTsKKyAgICAgICAgZm9yIChpID0gMCA7
IGkgPCBPTUFQM19IU19VU0JfUE9SVFMgOyBpKyspIHsKKwkJY2xrID0gcGRhdGEtPnRyYW5zY2Vp
dmVyX2Nsa1tpXTsKKwkJaWYgKGNsayl7CisJCQljbGtfZGlzYWJsZShjbGspOworICAgICAgICAg
ICAgICAgfQorICAgICAgICB9CisKKyAgICAgICAgcmV0dXJuIHJldDsKK30KK0VYUE9SVF9TWU1C
T0woZWhjaV9vbWFwX2J1c19jbGtfZGlzYWJsZSk7CisKIHN0YXRpYyBpbnQgZWhjaV9vbWFwX2J1
c19zdXNwZW5kKHN0cnVjdCB1c2JfaGNkICpoY2QpCiB7CiAJc3RydWN0IGRldmljZSAqZGV2ID0g
aGNkLT5zZWxmLmNvbnRyb2xsZXI7CiAJc3RydWN0IGVoY2lfaGNkX29tYXBfcGxhdGZvcm1fZGF0
YSAgKnBkYXRhOworICAgICAgICBzdHJ1Y3QgZWhjaV9oY2QgKmVoY2kgPSBoY2RfdG9fZWhjaSho
Y2QpOwogCXN0cnVjdCBvbWFwX2h3bW9kCSpvaDsKIAlzdHJ1Y3QgY2xrICpjbGs7CiAJaW50IHJl
dCA9IDA7CkBAIC05NTUsNiArMTAzOSwxMiBAQCBzdGF0aWMgaW50IGVoY2lfb21hcF9idXNfc3Vz
cGVuZChzdHJ1Y3QgdXNiX2hjZCAqaGNkKQogCiAJZGV2X2RiZyhkZXYsICJlaGNpX29tYXBfYnVz
X3N1c3BlbmRcbiIpOwogCisKKyAgICAgICBpZiAocG1fcnVudGltZV9zdXNwZW5kZWQoZGV2LT5w
YXJlbnQpKQorICAgICAgICAgICAgICAgcmV0dXJuIDA7CisKKwlkZWxfdGltZXIgKCZlaGNpLT5l
aGNpX3RpbWVyKTsKKwogCXJldCA9IGVoY2lfYnVzX3N1c3BlbmQoaGNkKTsKIAogCWlmIChyZXQg
IT0gMCkgewpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC9laGNpLmggYi9kcml2ZXJzL3Vz
Yi9ob3N0L2VoY2kuaApvbGQgbW9kZSAxMDA2NDQKbmV3IG1vZGUgMTAwNzU1CmluZGV4IDFjODE4
ZWQuLjE0NWZlOTMKLS0tIGEvZHJpdmVycy91c2IvaG9zdC9laGNpLmgKKysrIGIvZHJpdmVycy91
c2IvaG9zdC9laGNpLmgKQEAgLTc5LDYgKzc5LDcgQEAgc3RydWN0IGVoY2lfaGNkIHsJCQkvKiBv
bmUgcGVyIGNvbnRyb2xsZXIgKi8KIAlzdHJ1Y3QgZWhjaV9xaAkJKnJlY2xhaW07CiAJc3RydWN0
IGVoY2lfcWgJCSpxaF9zY2FuX25leHQ7CiAJdW5zaWduZWQJCXNjYW5uaW5nIDogMTsKKwl1bnNp
Z25lZCAgICAgICAgICAgICAgICBlaGNpX3N0YXRlOwogCiAJLyogcGVyaW9kaWMgc2NoZWR1bGUg
c3VwcG9ydCAqLwogI2RlZmluZQlERUZBVUxUX0lfVERQUwkJMTAyNAkJLyogc29tZSBIQ3MgY2Fu
IGRvIGxlc3MgKi8KQEAgLTEyMSw2ICsxMjIsOCBAQCBzdHJ1Y3QgZWhjaV9oY2QgewkJCS8qIG9u
ZSBwZXIgY29udHJvbGxlciAqLwogCiAJc3RydWN0IHRpbWVyX2xpc3QJaWFhX3dhdGNoZG9nOwog
CXN0cnVjdCB0aW1lcl9saXN0CXdhdGNoZG9nOworCXN0cnVjdCB0aW1lcl9saXN0ICAgICAgIGVo
Y2lfdGltZXI7ICAgICAvKiBkcml2ZXMgZWhjaS1pbnRlcnV1cHQgcm91dGluZSBwb2xsaW5nICov
CisJLy9zdHJ1Y3QgZGVsYXllZF93b3JrICAgICAgcnVudGltZV9laGNpOyAgICAvKiBmb3IgcnVu
dGltZSBzdXNwZW4gbiByZXN1bWUgZWhjaSAqLwogCXVuc2lnbmVkIGxvbmcJCWFjdGlvbnM7CiAJ
dW5zaWduZWQJCXBlcmlvZGljX3N0YW1wOwogCXVuc2lnbmVkCQlyYW5kb21fZnJhbWU7CkBAIC0x
ODIsNiArMTg1LDkgQEAgc3RydWN0IGVoY2lfaGNkIHsJCQkvKiBvbmUgcGVyIGNvbnRyb2xsZXIg
Ki8KIAlzdHJ1Y3Qgb3RnX3RyYW5zY2VpdmVyCSp0cmFuc2NlaXZlcjsKIH07CiAKK2V4dGVybiBp
bnQgZWhjaV9vbWFwX2J1c19jbGtfZW5hYmxlKHN0cnVjdCB1c2JfaGNkICopOworZXh0ZXJuIGlu
dCBlaGNpX29tYXBfYnVzX2Nsa19kaXNhYmxlKHN0cnVjdCB1c2JfaGNkICopOworCiAvKiBjb252
ZXJ0IGJldHdlZW4gYW4gSENEIHBvaW50ZXIgYW5kIHRoZSBjb3JyZXNwb25kaW5nIEVIQ0lfSENE
ICovCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBlaGNpX2hjZCAqaGNkX3RvX2VoY2kgKHN0cnVjdCB1
c2JfaGNkICpoY2QpCiB7Ci0tIAoxLjcuOS41Cgo=

--_002_88EA9DA16B788648836D263C936F15C2D8FAexgmbxfz02saskencom_--
