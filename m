From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: defconfig for panda
Date: Tue, 24 Apr 2012 14:52:37 +0530
Message-ID: <CAMrsUdKWx=PDWiMpExBZuUjLeaaheJiZXJowGn5G5MBZ5+5RTA@mail.gmail.com>
References: <1F91D012-8308-45BB-83AD-90E52D472AC2@kernel.crashing.org>
 <20120330184859.GB8240@atomide.com> <B05E7CFB-E2F3-426C-AAA8-622D715DB86A@kernel.crashing.org>
 <20120330213930.GC8240@atomide.com> <20120420160126.GA21441@beef> <20120420171345.GE21106@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8fb1f68aeceb6b04be694cee
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:45282 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756568Ab2DXJXG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 05:23:06 -0400
Received: by obceq6 with SMTP id eq6so863513obc.34
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 02:22:58 -0700 (PDT)
In-Reply-To: <20120420171345.GE21106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matt Porter <mporter@ti.com>, Kumar Gala <galak@kernel.crashing.org>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

--e89a8fb1f68aeceb6b04be694cee
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2012 at 10:43 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Matt Porter <mporter@ti.com> [120420 09:04]:
>> On Fri, Mar 30, 2012 at 02:39:32PM -0700, Tony Lindgren wrote:
>> > * Kumar Gala <galak@kernel.crashing.org> [120330 14:14]:
>> > >
>> > > On Mar 30, 2012, at 1:48 PM, Tony Lindgren wrote:
>> > >
>> > > > Hi,
>> > > >
>> > > > * Kumar Gala <galak@kernel.crashing.org> [120329 12:24]:
>> > > >> As I'm new to the OMAP community this might be a stupid question =
but trying to just build and run a stock v3.3 kernel on a pandaboard. =A0In=
 doing so it seems as if some basic drivers are not enabled in omap2plus_de=
fconfig for the board. =A0I'm trying to figure out if this is normal for so=
me reason or just an oversight.
>> > > >>
>> > > >> For example, USB and USB ethernet (SMC95xx). =A0I notice the lina=
ro kernel tree introduces an omap4_defconfig, so just wondering should I se=
nd patches to omap2plus_defconfig or what?
>> > > >
>> > > > We can add those to omap2plus_defconfig for sure, but let's have
>> > > > them added as modules. Then distros can use that easily in a
>> > > > standard way using initramfs-tools etc.
>> > > >
>> > > > Let's not change the drivers that are currently built in if they'r=
e
>> > > > needed for mounting mmc or nfsroot. Those can be changed later on.
>> > >
>> > > I'll work up a patch, however I was doing this as I was trying to ge=
t NFS root working and thus would need USB + USB ethernet compiled in and n=
ot as modules for panda. =A0Is that ok?
>> >
>> > Maybe, let's take a look how much bigger the kernel becomes.
>> > Also we need to check if the same EHCI configuration works
>> > for omap3/4.
>>
>> FWIW, the same EHCI + SMSC95xx config is used for Beagle xM for
>> nfsroot. First thing I enable on any builds.
>
> OK, can somebody please do a minimal patch to omap2plus_defconfig
> for this?
>
> Basically run make savedefconfig with those changes added and
> then diff against omap2plus_defconfig.
>

I have not seen the patch to enable this on the list,
so here is the patch[1] to do the same.

--
Thanks,
Govindraj.R

[1]:


>From 2965cfb8c05003dba333963c6206b5457adad943 Mon Sep 17 00:00:00 2001
From: "Govindraj.R" <govindraj.raja@ti.com>
Date: Tue, 24 Apr 2012 14:41:53 +0530
Subject: [PATCH] ARM: omap2plus_defconfig: Enable ehci-omap and sms95xx
 support

Boards like beagle and panda use ehci based smsc95xx lan chips
one has to manually enable these supports to get nfs working
on these boards. So keep these support enable by default.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig
b/arch/arm/configs/omap2plus_defconfig
index d5f00d7..9854ff4 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -98,6 +98,7 @@ CONFIG_LIBERTAS_USB=3Dm
 CONFIG_LIBERTAS_SDIO=3Dm
 CONFIG_LIBERTAS_DEBUG=3Dy
 CONFIG_USB_USBNET=3Dy
+CONFIG_USB_NET_SMSC95XX=3Dy
 CONFIG_USB_ALI_M5632=3Dy
 CONFIG_USB_AN2720=3Dy
 CONFIG_USB_EPSON2888=3Dy
@@ -175,6 +176,7 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
 CONFIG_USB_DEVICEFS=3Dy
 CONFIG_USB_SUSPEND=3Dy
 CONFIG_USB_MON=3Dy
+CONFIG_USB_EHCI_HCD=3Dy
 CONFIG_USB_WDM=3Dy
 CONFIG_USB_STORAGE=3Dy
 CONFIG_USB_LIBUSUAL=3Dy
--=20
1.7.9

--e89a8fb1f68aeceb6b04be694cee
Content-Type: application/octet-stream;
	name="0001-ARM-omap2plus_defconfig-Enable-ehci-omap-and-sms95xx.patch"
Content-Disposition: attachment;
	filename="0001-ARM-omap2plus_defconfig-Enable-ehci-omap-and-sms95xx.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h1eqvhdh0

RnJvbSAyOTY1Y2ZiOGMwNTAwM2RiYTMzMzk2M2M2MjA2YjU0NTdhZGFkOTQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiR292aW5kcmFqLlIiIDxnb3ZpbmRyYWoucmFqYUB0aS5jb20+
CkRhdGU6IFR1ZSwgMjQgQXByIDIwMTIgMTQ6NDE6NTMgKzA1MzAKU3ViamVjdDogW1BBVENIXSBB
Uk06IG9tYXAycGx1c19kZWZjb25maWc6IEVuYWJsZSBlaGNpLW9tYXAgYW5kIHNtczk1eHgKIHN1
cHBvcnQKCkJvYXJkcyBsaWtlIGJlYWdsZSBhbmQgcGFuZGEgdXNlIGVoY2kgYmFzZWQgc21zYzk1
eHggbGFuIGNoaXBzCm9uZSBoYXMgdG8gbWFudWFsbHkgZW5hYmxlIHRoZXNlIHN1cHBvcnRzIHRv
IGdldCBuZnMgd29ya2luZwpvbiB0aGVzZSBib2FyZHMuIFNvIGtlZXAgdGhlc2Ugc3VwcG9ydCBl
bmFibGUgYnkgZGVmYXVsdC4KClNpZ25lZC1vZmYtYnk6IEdvdmluZHJhai5SIDxnb3ZpbmRyYWou
cmFqYUB0aS5jb20+Ci0tLQogYXJjaC9hcm0vY29uZmlncy9vbWFwMnBsdXNfZGVmY29uZmlnIHwg
ICAgMiArKwogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vY29uZmlncy9vbWFwMnBsdXNfZGVmY29uZmlnIGIvYXJj
aC9hcm0vY29uZmlncy9vbWFwMnBsdXNfZGVmY29uZmlnCmluZGV4IGQ1ZjAwZDcuLjk4NTRmZjQg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2NvbmZpZ3Mvb21hcDJwbHVzX2RlZmNvbmZpZworKysgYi9h
cmNoL2FybS9jb25maWdzL29tYXAycGx1c19kZWZjb25maWcKQEAgLTk4LDYgKzk4LDcgQEAgQ09O
RklHX0xJQkVSVEFTX1VTQj1tCiBDT05GSUdfTElCRVJUQVNfU0RJTz1tCiBDT05GSUdfTElCRVJU
QVNfREVCVUc9eQogQ09ORklHX1VTQl9VU0JORVQ9eQorQ09ORklHX1VTQl9ORVRfU01TQzk1WFg9
eQogQ09ORklHX1VTQl9BTElfTTU2MzI9eQogQ09ORklHX1VTQl9BTjI3MjA9eQogQ09ORklHX1VT
Ql9FUFNPTjI4ODg9eQpAQCAtMTc1LDYgKzE3Niw3IEBAIENPTkZJR19VU0JfQU5OT1VOQ0VfTkVX
X0RFVklDRVM9eQogQ09ORklHX1VTQl9ERVZJQ0VGUz15CiBDT05GSUdfVVNCX1NVU1BFTkQ9eQog
Q09ORklHX1VTQl9NT049eQorQ09ORklHX1VTQl9FSENJX0hDRD15CiBDT05GSUdfVVNCX1dETT15
CiBDT05GSUdfVVNCX1NUT1JBR0U9eQogQ09ORklHX1VTQl9MSUJVU1VBTD15Ci0tIAoxLjcuOQoK
--e89a8fb1f68aeceb6b04be694cee--
