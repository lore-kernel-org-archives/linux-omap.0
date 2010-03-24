From: Hua Yu Yang <huayu.yang@gmail.com>
Subject: trying to understand the device model
Date: Wed, 24 Mar 2010 17:43:38 +0100
Message-ID: <24f4a101003240943i7e6699f0ocee92abb5d45c19a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:58702 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607Ab0CXQnn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 12:43:43 -0400
Received: by ey-out-2122.google.com with SMTP id d26so793406eyd.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Mar 2010 09:43:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

hi

sorry for spam if this is actually just naive.

i'm new to linux kernel driver module and planning to write a small
driver module for gpio test, here is what confuses me:

1. in the kernel module programming guide from tldp.org, a device is
registered with system by major and minor numbers but in recent kernel
source( i'm working with 2.6.28.10 ), the files under
Documentation/driver-model/ seem to introduce a whole new set of
models, also in kernel source, gpiolib and plat-omap/gpio.c seem to
follow the new models. i'm not sure if the way described in kernel
module programming guide is still valid for recent kernels.

2. for your information, i want to write a simple driver based on gpio
interface described in Documentation/gpio.txt and implement a 8-bit
read function as well as an interrupt handler, sort of using gpios to
emulate a parallel port. this is just a workaround for lacking access
to camera interface on IGEPv2 board, so no need to consider
portability or whatsoever, is there any problem for me to just use
module_init() and module_exit(), as is shown in the kernel module
programming guide, instead of going into all those add/remove classes,
buses, interfaces?

thanks in advance!

-- 
Huayu Yang
