From: vimal singh <vimal.newwork@gmail.com>
Subject: SDP support seems broken in LO
Date: Tue, 18 Aug 2009 17:49:02 +0530
Message-ID: <ce9ab5790908180519t644723cbw6876901066f1f213@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:44577 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbZHRMTW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 08:19:22 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1207847qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2009 05:19:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

LO seems broken on OMAP3430 SDP platform. I compile latest kernel with
'omap_3430sdp_defconfig' config options.

Booting hangs after kernel uncompressed and last message which appears
is 'booting the kernel'


Thanks and regards,
vimal

See below log:

## Booting image at 80000000 ...
   Image Name:   Linux-2.6.31-rc5-omap1-05896-ge0
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2520992 Bytes =  2.4 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux.................................................................................................................................................................
done, booting the kernel.
