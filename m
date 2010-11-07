From: public.avatar@gmail.com ([AvataR])
Subject: UbiFS + HWECC(?) + BeagleBoard = fail
Date: Sun, 07 Nov 2010 09:40:23 +0200
Message-ID: <87iq09wpi0.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50328 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab0KGHk0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 02:40:26 -0500
Received: by bwz11 with SMTP id 11so3894176bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 00:40:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi. After moving to upstream 2.6.3{5,6,7} kernels, i forced to use jffs2
instead of ubifs, because of lot CRC errors. If i use prefetch/dma, i
can attach to ubi, make volume, write data, reboot - and got lots of CRC
errors. Without prefetch i just couldn't do anything to ubi. 

Looks like hw/sw bug in ubi
