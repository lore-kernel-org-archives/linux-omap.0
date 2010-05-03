From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 02/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
Date: Tue, 4 May 2010 03:40:53 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304F5A672@dbde02.ent.ti.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
 <20100430203349.25812.64659.stgit@baageli.muru.com>
 <87sk6cirt0.fsf@deeprootsystems.com> <20100430210216.GI29604@atomide.com>
 <87vdb8hc2d.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC3560870304E80F5F@dbde02.ent.ti.com>
 <87y6g4d2ic.fsf@deeprootsystems.com> <20100430233002.GJ29604@atomide.com>
 <87sk6c8osn.fsf@deeprootsystems.com> <20100501013751.GL29604@atomide.com>
 <20100501015050.GM29604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_FCCFB4CDC6E5564B9182F639FC3560870304F5A672dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35242 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754136Ab0ECWLF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 May 2010 18:11:05 -0400
In-Reply-To: <20100501015050.GM29604@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>

--_002_FCCFB4CDC6E5564B9182F639FC3560870304F5A672dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Friday, April 30, 2010 8:51 PM
>To: Kevin Hilman
>Cc: Pandita, Vikram; linux-arm-kernel@lists.infradead.org; linux-
>omap@vger.kernel.org; Pais, Allen
>Subject: Re: [PATCH 02/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
>
>* Tony Lindgren <tony@atomide.com> [100430 18:33]:
>>
>> So far only tested on n900, will give it a try also on zoom3 after
>> updating the zoom3 related patch.
>
>And here's the updated zoom debug_ll patch, seems to work.

For testing if I put this printk hack (the good old days patch),=20
Zoom3 does not boot after applying your patch.

So looks like we are still missing something for zoom2/3 to work.
Can debug tomorrow.

>
>> --- a/arch/arm/plat-omap/include/plat/uncompress.h
>> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
>> @@ -20,27 +20,22 @@
>>  #include <linux/types.h>
>>  #include <linux/serial_reg.h>
>>
>> +#include <asm/memory.h>
>> +#include <asm/io.h>
>>  #include <asm/mach-types.h>
>>
>>  #include <plat/serial.h>
>
>BTW, the include of asm/io.h is not needed, I'll remove that.
>
>Regards,
>
>Tony

--_002_FCCFB4CDC6E5564B9182F639FC3560870304F5A672dbde02enttico_
Content-Type: application/octet-stream; name="printk-dbg.patch"
Content-Description: printk-dbg.patch
Content-Disposition: attachment; filename="printk-dbg.patch"; size=570;
	creation-date="Tue, 04 May 2010 03:38:04 GMT";
	modification-date="Tue, 04 May 2010 03:38:04 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC9wcmludGsuYyBiL2tlcm5lbC9wcmludGsuYwppbmRleCA3NTA3
N2FkLi4yNDdjMTY5IDEwMDY0NAotLS0gYS9rZXJuZWwvcHJpbnRrLmMKKysrIGIva2VybmVsL3By
aW50ay5jCkBAIC0zOSw2ICszOSwxMCBAQAogCiAjaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KIAor
I2lmZGVmIENPTkZJR19ERUJVR19MTAorZXh0ZXJuIHZvaWQgcHJpbnRhc2NpaShjaGFyICopOwor
I2VuZGlmCisKIC8qCiAgKiBmb3JfZWFjaF9jb25zb2xlKCkgYWxsb3dzIHlvdSB0byBpdGVyYXRl
IG9uIGVhY2ggY29uc29sZQogICovCkBAIC03MDksNiArNzEzLDkgQEAgYXNtbGlua2FnZSBpbnQg
dnByaW50ayhjb25zdCBjaGFyICpmbXQsIHZhX2xpc3QgYXJncykKIAlwcmludGVkX2xlbiArPSB2
c2NucHJpbnRmKHByaW50a19idWYgKyBwcmludGVkX2xlbiwKIAkJCQkgIHNpemVvZihwcmludGtf
YnVmKSAtIHByaW50ZWRfbGVuLCBmbXQsIGFyZ3MpOwogCisjaWZkZWYgQ09ORklHX0RFQlVHX0xM
CisJcHJpbnRhc2NpaShwcmludGtfYnVmKTsKKyNlbmRpZgogCiAJcCA9IHByaW50a19idWY7CiAK

--_002_FCCFB4CDC6E5564B9182F639FC3560870304F5A672dbde02enttico_--
