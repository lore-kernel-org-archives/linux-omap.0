From: Chris Hudson <chudson@kionix.com>
Subject: Driver Merge Questions
Date: Tue, 03 Nov 2009 09:40:17 -0500
Message-ID: <4AF040D1.7020109@kionix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from barracuda.kionix.com ([205.232.90.213]:41590 "EHLO
	mail.kionix.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751261AbZKCOrj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 09:47:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello all,

I've never submitted any software to Linux before, but I've been working 
on some new accelerometer drivers that should be ready for review soon 
(pending company approval).  I've read lots of documentation on patch 
and driver submissions, but I still have some questions that I was 
hoping someone could help me find the answers to.

1- My drivers use i2c for hardware communications, miscdevice for 
IOCTLs, and input_dev for data and interrupt status outputs.  Most of 
the other accelerometer drivers that I've looked at use similar designs 
and are located in drivers/hwmon, but I just wanted to confirm that this 
is the correct location currently.

2- I have done all of my hardware testing with OMAP development 
platforms, so I thought it would be best to send my patch submissions to 
this list for review.  The hardware monitoring tree is listed in 
MAINTAINERS as an orphan, but I was planning on including 
lm-sensors@lm-sensors.org as well.  If either of these assumptions is 
incorrect, please let me know.

3- Should my patch set consist of source, header, kconfig, and makefile 
patches, or should I include my custom changes to mux.c, mux.h, and 
board-zoom2.c as well?  The former are necessary for adding driver 
support, but the latter are specific for my hardware testing platform 
(which others may want to duplicate for testing purposes).  I noticed 
that recent versions of board-zoom2.c are nice and clean, so it's 
probably not a good idea to wedge infrequently-used code in there with a 
bunch of #ifdefs.  I just want to get an idea of what is generally 
included with a new driver.

Any help or advice would be greatly appreciated.

Thank you,

Chris Hudson
Kionix, Inc.

