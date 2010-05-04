From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 02b/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
Date: Tue, 4 May 2010 23:03:47 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304F5AC4F@dbde02.ent.ti.com>
References: <20100430210216.GI29604@atomide.com>
 <87vdb8hc2d.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC3560870304E80F5F@dbde02.ent.ti.com>
 <87y6g4d2ic.fsf@deeprootsystems.com> <20100430233002.GJ29604@atomide.com>
 <87sk6c8osn.fsf@deeprootsystems.com> <20100501013751.GL29604@atomide.com>
 <20100501015050.GM29604@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC3560870304F5A672@dbde02.ent.ti.com>
 <20100504004001.GB29604@atomide.com> <20100504005838.GF29604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_FCCFB4CDC6E5564B9182F639FC3560870304F5AC4Fdbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37886 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757792Ab0EDReH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 May 2010 13:34:07 -0400
In-Reply-To: <20100504005838.GF29604@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>

--_002_FCCFB4CDC6E5564B9182F639FC3560870304F5AC4Fdbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Tony

>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Monday, May 03, 2010 7:59 PM
>To: Pandita, Vikram
>Cc: Kevin Hilman; linux-arm-kernel@lists.infradead.org; linux-
>omap@vger.kernel.org; Pais, Allen
>Subject: [PATCH 02b/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
>
>And here's this patch one more time. Both 2a and 2b are needed
>for zoom debug uart to work.

Test 1:
Tested on Zoom3 with 02a and 02b applied. Enabled DEBUG_LL.=20
Booted fine.

Test 2:
Applied Hack printk.patch (attached)
Booted fine and duplicate logs can be seen on console =3D> printascii is wo=
rking.

Ack-by: Vikram Pandita <vikram.pandita@ti.com>

>
>Regards,
>
>Tony

--_002_FCCFB4CDC6E5564B9182F639FC3560870304F5AC4Fdbde02enttico_
Content-Type: application/octet-stream; name="printk.patch"
Content-Description: printk.patch
Content-Disposition: attachment; filename="printk.patch"; size=570;
	creation-date="Sat, 13 Mar 2010 00:05:12 GMT";
	modification-date="Sat, 13 Mar 2010 00:05:12 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC9wcmludGsuYyBiL2tlcm5lbC9wcmludGsuYwppbmRleCAxNzQ2
M2NhLi4zMjZiYWU3IDEwMDY0NAotLS0gYS9rZXJuZWwvcHJpbnRrLmMKKysrIGIva2VybmVsL3By
aW50ay5jCkBAIC0zOCw2ICszOCwxMCBAQAogCiAjaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KIAor
I2lmZGVmIENPTkZJR19ERUJVR19MTAorZXh0ZXJuIHZvaWQgcHJpbnRhc2NpaShjaGFyICopOwor
I2VuZGlmCisKIC8qCiAgKiBmb3JfZWFjaF9jb25zb2xlKCkgYWxsb3dzIHlvdSB0byBpdGVyYXRl
IG9uIGVhY2ggY29uc29sZQogICovCkBAIC03MTYsNiArNzIwLDkgQEAgYXNtbGlua2FnZSBpbnQg
dnByaW50ayhjb25zdCBjaGFyICpmbXQsIHZhX2xpc3QgYXJncykKIAlwcmludGVkX2xlbiArPSB2
c2NucHJpbnRmKHByaW50a19idWYgKyBwcmludGVkX2xlbiwKIAkJCQkgIHNpemVvZihwcmludGtf
YnVmKSAtIHByaW50ZWRfbGVuLCBmbXQsIGFyZ3MpOwogCisjaWZkZWYgQ09ORklHX0RFQlVHX0xM
CisJcHJpbnRhc2NpaShwcmludGtfYnVmKTsKKyNlbmRpZgogCiAJcCA9IHByaW50a19idWY7CiAK

--_002_FCCFB4CDC6E5564B9182F639FC3560870304F5AC4Fdbde02enttico_--
