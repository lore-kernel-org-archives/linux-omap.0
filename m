From: Maxim Podbereznyy <lisarden@gmail.com>
Subject: ks8851 speed regression in kernel 3.0.17-115c
Date: Wed, 22 Feb 2012 14:32:21 +0300
Message-ID: <CAP3+TEo=nrB4Y5VYnnpgPnQcaqd4xZ1-Up6Fd9RztKuur8S+wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46162 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751065Ab2BVLcX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 06:32:23 -0500
Received: by lagu2 with SMTP id u2so8875611lag.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 03:32:21 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi!

Current kernel: linux-3.0.17-r115c
Download speed:  745kB/sec

Previous kernel: 2.6.32-r78
Download speed: 1MB/sec

I noticed the regression in speed for ks8851 driver (Micrel
KSZ8851-SNL). I used this part with kernel 2.6.32 and the speed was
1MB/s. Then the driver code was changed and for current Linux version
linux-3.0.17-r115c the speed is 745kB/s. 25% speed reduce is indeed
noticeable.

I use Angstrom Linux built in OE environment.
Target board is Beagleboard C4.
