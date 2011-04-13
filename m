From: Constantine Shulyupin <const@makelinux.com>
Subject: Super Fast Linux Boot on BeagleBoard: 300 ms from boot loader to shell
Date: Wed, 13 Apr 2011 17:42:01 +0300
Message-ID: <BANLkTim4eCSeGm6WN5NnrYWWoQu2148N7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cpoproxy3-pub.bluehost.com ([67.222.54.6]:59691 "HELO
	cpoproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756363Ab1DMOmG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 10:42:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46])
	by box668.bluehost.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <const@makelinux.com>)
	id 1QA1Ge-0004fr-27
	for linux-omap@vger.kernel.org; Wed, 13 Apr 2011 08:42:04 -0600
Received: by fxm17 with SMTP id 17so495219fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Apr 2011 07:42:01 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Make Linux Software presents the fastest ever embedded Linux boot for
720 MHz ARM and NAND flash memory. Linux boot time is 300 milliseconds
from boot loader to shell. The first goal of the project is to achieve
a minimal boot time of a minimal but functional Linux system on common
hardware. The second goal is to provide a platform for developing more
functional systems with shortest possible boot time.

Video of boot process: http://www.youtube.com/watch?v=747XLVbTgA4

Boot log with timestamps:

0.000 0.000: TI X-Loader 1.4.4ss Mar 26 2011 01:45:43
0.000 0.000: Optimised by www.MakeLinux.com
0.000 0.000: Loading
0.237 0.237: Running
0.237 0.000: CFG_LOADADDR=80008000
0.249 0.012: *(int*)CFG_LOADADDR=e321f0d3
0.276 0.027: Linux version 2.6.32 (const@makelinux.com)
0.276 0.000: Starting application
0.296 0.020: BusyBox v1.16.2 hush - the humble shell

To learn more, please visit http://www.makelinux.com/emb/fastboot/omap

-- 
Constantine Shulyupin
http://www.MakeLinux.com/
Embedded Linux Systems,
Device Drivers, TI DaVinci
