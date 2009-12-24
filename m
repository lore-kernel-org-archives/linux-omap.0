From: Niamathullah sharief <omapsha@gmail.com>
Subject: gstreamer compilation
Date: Thu, 24 Dec 2009 14:54:48 +0530
Message-ID: <4ad3b6300912240124o66abe09do585b3bb9c07a5d57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:57037 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbZLXJYt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Dec 2009 04:24:49 -0500
Received: by pwj9 with SMTP id 9so4862468pwj.21
        for <linux-omap@vger.kernel.org>; Thu, 24 Dec 2009 01:24:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello i am trying to compile gstreamer for arm. But i am getting the
following error when i do configure

/home/ariem/CodeSourcery/Sourcery_G++_Lite/bin/../lib/gcc/arm-none-linux-gnueabi/4.3.3/../../../../arm-none-linux-gnueabi/bin/ld:
cannot find -lgstriff-0.10
collect2: ld returned 1 exit status
make[1]: *** [libmfw_gst_aacdec.la] Error 1
make[1]: Leaving directory
`/home/ariem/Desktop/plugins/fsl_linux_sdk_gstreamer_plugins_1.6.0_1/gst-fsl-plugin-1.6.0/src/audio/aac_dec/src'
make: *** [all-recursive] Error 1
Building  of glib library  has failed
root@ariem-desktop:/home/ariem/Desktop/plugins/fsl_linux_sdk_gstreamer_plugins_1.6.0_1/gst-fsl-plugin-1.6.0/src#
