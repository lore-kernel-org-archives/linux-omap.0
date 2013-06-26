From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Wed, 26 Jun 2013 18:52:59 +0530
Message-ID: <51CAEB33.5010101@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org> <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58770 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab3FZNXm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Jun 2013 09:23:42 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, "Rini, Tom" <trini@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

>>
>> Just to confirm, my problems with mainline were with appended DTB also.
>> Separate DTB and zImage work fine (at least using u-boot v2013.04.)
>>
>> That being said, appended DTB should still work, so there's a bug
>> hiding
>> someplace that needs to be found fixed.
>>
>> Can you guys update your tests to test appended DTB also?
>>
> 
> What is missing here is, 
> 
> CONFIG_ARM_APPENDED_DTB = y
> CONFIG_ARM_ATAG_DTB_COMPAT = y
> 
> 
> And for the code which is required in case of appended DTB, please refer to the code
> "arch/arm/boot/compressed/head.S"
> 
> 
> Please __NOTE__ that these options are not enabled in default omap2plus_defconfig.

Paul/Kevin,

Apart from confirming if you are manually enabling these options, can you also give some
details on how you append the dtb to the kernel image?

Most of us use an out-of-tree patch from Grant to do this, which I have shared below [2]

Even without the patch with the below commands [1] to append the dtb, it still works, so it
would be good to know what steps you follow to append the dtb to the kernel image.

regards,
Rajendra

[1]
cat arch/arm/boot/zImage arch/arm/boot/dts/am335x-bone.dtb > zImage
mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "Linux" -d zImage uImage 

[2]
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Apr 2012 16:19:29 +0530
Subject: Makefile: Build a uImage with dtb already appended

Do not commit to mainline; this is a useful hack only for now.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/Makefile      |    2 ++
 arch/arm/boot/Makefile |    7 +++++++
 2 files changed, 9 insertions(+)

Index: linux-2.6/arch/arm/Makefile
===================================================================
--- linux-2.6.orig/arch/arm/Makefile    2013-04-24 12:25:22.547990009 +0530
+++ linux-2.6/arch/arm/Makefile 2013-04-26 14:30:57.143150733 +0530
@@ -295,6 +295,8 @@

 %.dtb: scripts
        $(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
+uImage.%: uImage
+       $(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@

 dtbs: scripts
        $(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) dtbs
Index: linux-2.6/arch/arm/boot/Makefile
===================================================================
--- linux-2.6.orig/arch/arm/boot/Makefile       2013-04-24 12:25:22.547990009 +0530
+++ linux-2.6/arch/arm/boot/Makefile    2013-04-26 14:30:57.151150508 +0530
@@ -55,6 +55,9 @@
        $(call if_changed,objcopy)
        @$(kecho) '  Kernel: $@ is ready'

+$(obj)/zImage-dtb.%:   $(obj)/dts/%.dtb $(obj)/zImage
+       cat $(obj)/zImage $< > $@
+
 endif

 ifneq ($(LOADADDR),)
@@ -80,6 +83,10 @@
        $(call if_changed,uimage)
        @$(kecho) '  Image $@ is ready'

+$(obj)/uImage.%:       $(obj)/zImage-dtb.% FORCE
+       $(call if_changed,uimage)
+       @echo '  Image $@ is ready'
+
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
        $(Q)$(MAKE) $(build)=$(obj)/bootp $@
        @:

