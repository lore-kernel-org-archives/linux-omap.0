From: Kyle McMartin <kmcmarti@redhat.com>
Subject: Re: 3.11-rc1+ multiplatform kernel+dtb pandaboard issues
Date: Wed, 21 Aug 2013 15:41:43 -0400
Message-ID: <20130821194143.GE26531@redacted.bos.redhat.com>
References: <20130821154321.GA26531@redacted.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49126 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089Ab3HUTlq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Aug 2013 15:41:46 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7LJfjDp004855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-omap@vger.kernel.org>; Wed, 21 Aug 2013 15:41:45 -0400
Received: from redacted.bos.redhat.com ([10.18.17.143])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r7LJfhSx007542
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 21 Aug 2013 15:41:45 -0400
Content-Disposition: inline
In-Reply-To: <20130821154321.GA26531@redacted.bos.redhat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Wed, Aug 21, 2013 at 11:43:21AM -0400, Kyle McMartin wrote:
> I've suspected there might be a config issue, as omap2_defconfig
> works alright, as does booting a uImage with an appended
> omap4-panda.dtb, but there's no love with a zImage + initrd + dtb
> (or even just zImage without initrd + dtb.)
> 

after some further investigation, something odd is going on... turns
out things have been working (at least until initrd time, but that's
another story) fine but none of the bootargs have made it into the
kernel, so console= was unset and no messages came out.

not sure if this is appropriate, but explicitly putting the "default"
serial consoles into the dtb, at least helps me get along debugging
issues...

---
From: Kyle McMartin <kyle@redhat.com>

Specify default bootargs consoles for the Beaglebone and Pandaboards
in their respective device tree files.

Signed-off-by: Kyle McMartin <kyle@redhat.com>

--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -19,6 +19,10 @@
 		};
 	};
 
+	chosen {
+		bootargs = "console=ttyO0,115200n8";
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index faa95b5..b424d00 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -16,6 +16,10 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 
+	chosen {
+		bootargs = "console=ttyO2,115200";
+	};
+
 	leds: leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
