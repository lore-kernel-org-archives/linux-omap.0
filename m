From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv7 00/23]I2C big cleanup
Date: Wed, 12 Sep 2012 15:41:40 +0530
Message-ID: <50505FDC.4090500@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com> <20120911220048.GD27031@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:39370 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756534Ab2ILKLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 06:11:48 -0400
Received: by obbuo13 with SMTP id uo13so2336669obb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 03:11:46 -0700 (PDT)
In-Reply-To: <20120911220048.GD27031@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com

On Wednesday 12 September 2012 03:30 AM, Wolfram Sang wrote:
>> Changes since v6:
>> >         - Fix comments on setting the pdev to NULL.
>> >         - Trivial changelog update
> Looks mostly good, thanks. Only a few comments. Oh, and I still get
> reports about a section mismatch ;)
I am using omap2plus_defconfig
 $ make --ver
GNU Make 3.81
Copyright (C) 2006  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

$ make CONFIG_DEBUG_SECTION_MISMATCH=y uImage
....
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  OBJCOPY arch/arm/boot/Image
  Kernel: arch/arm/boot/Image is ready
  GZIP    arch/arm/boot/compressed/piggy.gzip
  CC      arch/arm/boot/compressed/misc.o
  CC      arch/arm/boot/compressed/decompress.o
  CC      arch/arm/boot/compressed/string.o
  AS      arch/arm/boot/compressed/piggy.gzip.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready
  UIMAGE  arch/arm/boot/uImage
Image Name:   Linux-3.6.0-rc5-00022-g49fb6db
Created:      Wed Sep 12 15:24:21 2012
Image Type:   ARM Linux Kernel Image (uncompressed)
Data Size:    4074688 Bytes = 3979.19 kB = 3.89 MB
Load Address: 80008000
Entry Point:  80008000
  Image arch/arm/boot/uImage is ready

I donot see the warning. Am I missing something?


