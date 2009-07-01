From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: OMAP3: RX51: build warning at rx51_t2scripts
Date: Wed, 01 Jul 2009 11:02:41 +0300
Message-ID: <4A4B1821.20604@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39220 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbZGAIDU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jul 2009 04:03:20 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n6182Ruc004279
	for <linux-omap@vger.kernel.org>; Wed, 1 Jul 2009 03:03:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kucheria Amit (EXT-Atomide/Helsinki)" <ext-amit.kucheria@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Amit,

I get the following warning while building Kevin's PM branch for RX-51.
The kernel boots to shell though.
I'm not sure whether it's harmless or not.


MODPOST vmlinux.o
WARNING: vmlinux.o(.data+0xb328): Section mismatch in reference from the 
variable rx51_t2scripts_data to the (unknown reference) .init.data:(unknown)
The variable rx51_t2scripts_data references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
