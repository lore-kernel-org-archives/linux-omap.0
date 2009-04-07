From: Remith Ravi <remithmailinglist@gmail.com>
Subject: USB EHCI Issue
Date: Tue, 7 Apr 2009 22:00:40 +0530
Message-ID: <814dfab70904070930h3444bd59vfd569bb8f0b4c515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:20193 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298AbZDGQao convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 12:30:44 -0400
Received: by ti-out-0910.google.com with SMTP id i7so2487715tid.23
        for <linux-omap@vger.kernel.org>; Tue, 07 Apr 2009 09:30:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

I am working on a new board which uses USB EHCI Host Controller. It is
connected to HS USB Port 2 of OMAP3530.
The transceiver used is SMSC USB3320.

I am able to boot the GIT kernel on my board. But when I enable the
USB EHCI option in menuconfig, the kernel hangs while booting and
shows some stray characters in UART console.

The UART log is given below
-----------------------------------------------------------------------=
--------------------
Creating 5 MTD partitions on "omap2-nand.0":
0x000000000000-0x000000080000 : "xloader-nand"
0x000000080000-0x000000240000 : "uboot-nand"
0x000000240000-0x000000280000 : "params-nand"
0x000000280000-0x000000780000 : "linux-nand"
0x000000780000-0x000001b80000 : "jffs2-nand"
OneNAND driver initializing
usbmon: debugfs is not available
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
B       =B2=FA=FB=FE"=F5=FF
               =FF=FF@hU=A5=E1=FF=FF
                        =EE`=A6=FF
                            =FE
                             =EA=E0=A9=FE=FF
-----------------------------------------------------------------------=
----------------------

The point of failure is

  File:  drivers/usb/host/ehci-omap.c
  Function:  omap_start_ehc()
  code:
        /* perform TLL soft reset, and wait until reset is complete */
        omap_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT,
                        OMAP_USBTLL_SYSCONFIG);

I am able to boot the kernel by commenting out this line. But then the
USB EHCI driver displays a message that It is unable to enumerate the
device.
I probed using USB Analyzer and there is no data transfer happening
over the port.

Please provide your suggestions towards solving this issue.

Regards,
Remith
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
