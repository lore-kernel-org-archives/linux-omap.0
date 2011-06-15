From: javier Martin <javier.martin@vista-silicon.com>
Subject: tidspbridge: problems executing sample apps
Date: Wed, 15 Jun 2011 17:19:16 +0200
Message-ID: <BANLkTinawxhRF2FWBrR=vpfCraM=xLX4mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175caad036e1fa04a5c1adc2
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60968 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247Ab1FOPTV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jun 2011 11:19:21 -0400
Received: by ewy4 with SMTP id 4so203981ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 08:19:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--0015175caad036e1fa04a5c1adc2
Content-Type: text/plain; charset=ISO-8859-1

Hi,
we have a Beagleboard xM (DM3730) and we are currently working with
stable kernel 2.6.39 and we have compiled the tisdpbridge in the
staging directory.

In order to test basic DSP functionality we are using
userspace-dspbridge from git repository
git://dev.omapzoom.org/pub/scm/tidspbridge/userspace-dspbridge.git and
commit 9c64192758fd066d1a3f50867919e7aa21f04387
And the following version of needed packages are being used:

bios_5_41_07_24
TI_CGT_C6000_6.1.17
xdctools_3_20_06_81

1- If I try prebuilt binaries (both for DSP side and userspace) I get
an execution error:

root@beagleboard:/dspbridge# ./ping.out
DSP device detected !!
DSPNode[   30.530944] DSPTrace: PING: **PING_TI_create: retval = 0x0 **
[   30.530975] PING: PING_TI_execute: Entered ...
[   30.530975]
Create succeeded[   30.545135] DSPTrace: PING: PING_TI_execute:
Received ping from GPP: cmd = 0xbebe0001; cnt = 0x200596aa
[   30.545166]

DSPNode_registerNotify succeeded
DSPNode_run succeeded
Ping: Id 1.000000 Msg 0.000000 Mem 15408.000000
DSPNode_GetMessage failed: 0xffffffc2
Ping: Id 1.000000 Msg 1.000000 Mem 15408.000000
DSPNode_GetMessage failed: 0xffffffc2

2- If I compile only MPU samples and use DSP prebuilt binaries it works fine.

3- If I compile both DSP side and MPU side samples it also gives an
execution error:

root@beagleboard:/dspbridge# ./cexec.out ddspbase_tiomap3430.dof64P
DSP device detected !!
[   45.862640] proc_load: Processor Loaded ddspbase_tiomap3430.dof64P
[   45.876892] proc_start: dsp in running state
DSPProcessor_Sta[   45.881927] procwrap_detach: deprecated dspbridge ioctl
rt succeeded.
Hit any key to terminate cexec.

root@beagleboard:/dspbridge# ./ping.out
DSP device detec[   64.484649] procwrap_detach: deprecated dspbridge ioctl
ted !!
DSPNode_Create failed: 0xffffffe3


In order to achieve option (3) I had to apply the attached patch to
fix some build errors and I had to copy libstdc++.so.5 to  /usr/lib32/
since I am on a 64bit machine
http://mirror.ovh.net/ubuntu//pool/universe/g/gcc-3.3/libstdc++5_3.3.6-15ubuntu4_i386.deb

Do you know what combination of DSP bios, TI CGT and xdctools is most
suitable for using with tidspbridge in kernel 2.6.39?

Thank you.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com

--0015175caad036e1fa04a5c1adc2
Content-Type: text/x-patch; charset=US-ASCII; name="fix_build.patch"
Content-Disposition: attachment; filename="fix_build.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_goyfa8fy0

ZGlmZiAtLWdpdCBhL3NvdXJjZS9wcm9kdWN0Lm1hayBiL3NvdXJjZS9wcm9kdWN0Lm1hawppbmRl
eCA4OTJmYWY1Li4xOTk2MzY2IDEwMDc1NQotLS0gYS9zb3VyY2UvcHJvZHVjdC5tYWsKKysrIGIv
c291cmNlL3Byb2R1Y3QubWFrCkBAIC0xMywxMiArMTMsMTIgQEAKICMNCiANCiAjIERTUCBCSU9T
DQotU0FCSU9TX1ZFUiAgID0gNS4zMy4wNA0KLVNBQklPU19WRVJfMiA9IDVfMzNfMDQNCitTQUJJ
T1NfVkVSICAgPSA1LjQxLjA3LjI0DQorU0FCSU9TX1ZFUl8yID0gNV80MV8wN18yNA0KIA0KICMg
Q29kZUdlbiBUb29scw0KIENHVDU1X1ZFUiA9IDMuMi4yDQotQ0dUNlhfVkVSID0gNi4wLjcNCitD
R1Q2WF9WRVIgPSA2LjEuMTcNCiANCiAjIEZyYW1ld29yayBjb21wb25lbnRzDQogRkNfVkVSID0g
MV8xMF8wNA0KZGlmZiAtLWdpdCBhL3NvdXJjZS9zYW1wbGVtYWtlZmlsZSBiL3NvdXJjZS9zYW1w
bGVtYWtlZmlsZQppbmRleCA0ZDExNjEwLi5hYzlmNzcyIDEwMDc1NQotLS0gYS9zb3VyY2Uvc2Ft
cGxlbWFrZWZpbGUKKysrIGIvc291cmNlL3NhbXBsZW1ha2VmaWxlCkBAIC04Myw4ICs4Myw4IEBA
IEJSSURHRV9FWFBPUlRfUEFDS0FHRVMgPSBkc3AvdGkvZHNwYnJpZGdlL2RzcC9icmlkZ2VfcHJv
ZHVjdAogCiBTQU1QTEVfUEFDS0FHRVMgPSBzYW1wbGVzL2RzcAogCi1ETExfRklMRVM9JCh3aWxk
Y2FyZCAkKFNBTVBMRV9QQUNLQUdFUykvKi5kbGw2NFApKQotRE9GX0ZJTEVTPSQod2lsZGNhcmQg
JChTQU1QTEVfUEFDS0FHRVMpLyouZG9mNjRQKSkKK0RMTF9GSUxFUz0kKHdpbGRjYXJkICQoU0FN
UExFX1BBQ0tBR0VTKS8qLmRsbDY0UCkKK0RPRl9GSUxFUz0kKHdpbGRjYXJkICQoU0FNUExFX1BB
Q0tBR0VTKS8qLmRvZjY0UCkKIAogLnNhbXBsZXM6IC5icmlkZ2Vfc2FtcGxlcwogCkBAIC0xNDQs
NyArMTQ0LDcgQEAgaWZuZXEgKCQoRExMX0ZJTEVTKSwpCiAJJChDUCkgLWYgJChETExfRklMRVMp
ICQoVEFSR0VURElSKS9kc3BicmlkZ2UvCiBlbmRpZgogaWZuZXEgKCQoRE9GX0ZJTEVTKSwpCi0J
JChDUCkgLWYgJChET0ZfRklMRVMpLyAkKFRBUkdFVERJUikvZHNwYnJpZGdlLworCSQoQ1ApIC1m
ICQoRE9GX0ZJTEVTKSAkKFRBUkdFVERJUikvZHNwYnJpZGdlLwogZW5kaWYKIAogIy5leGVjdXRl
X3ZlcnNpb25fc2NyaXB0OiB2ZXJzaW9uLmtzaCAkKFZFUlNJT05fRklMRSkKZGlmZiAtLWdpdCBh
L3NvdXJjZS9zYW1wbGVzL2RzcC9kZHNwYmFzZS50Y2kgYi9zb3VyY2Uvc2FtcGxlcy9kc3AvZGRz
cGJhc2UudGNpCmluZGV4IDE3NDZhZGMuLmQ5NjhjYWIgMTAwNzU1Ci0tLSBhL3NvdXJjZS9zYW1w
bGVzL2RzcC9kZHNwYmFzZS50Y2kKKysrIGIvc291cmNlL3NhbXBsZXMvZHNwL2Rkc3BiYXNlLnRj
aQpAQCAtMTksNiArMTksOCBAQAogICoNCiAgKi8NCiANCit2YXIgY2hpcFR5cGUgPSBlbnZpcm9u
bWVudFsiY29uZmlnLmNoaXBUeXBlIl07DQorDQogLyogYnJpZGdlIGRlZmF1bHQgaXMgNTEyLCB0
aGF0J3Mgbm90IGVub3VnaCBzb21ldGltZXMgKi8NCiB2YXIgdHJhY2VTaXplID0gNTEyOw0KIA0K
--0015175caad036e1fa04a5c1adc2--
