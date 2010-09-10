From: Cliff Brake <cliff.brake@gmail.com>
Subject: NAND erase failures on overo
Date: Fri, 10 Sep 2010 17:52:14 -0400
Message-ID: <AANLkTi=JiyPeyi11cvqNZDn1JWBEPJupmu1i5DZ+=q+f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37692 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab0IJVwP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 17:52:15 -0400
Received: by wyf22 with SMTP id 22so3302349wyf.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Sep 2010 14:52:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Users <linux-omap@vger.kernel.org>

With the current, linux-omap:master branch
(8475b9e5077d9e9b4ba7a92afd4c5c7d65564c09), I get the following errors
on a overo system when erasing flash:

root@ts3:~# flash_eraseall -j /dev/mtd4
Erasing 128 Kibyte @ 8c40000 -- 56 % complete. Cleanmarker written at 8c20000.
flash_eraseall: /dev/mtd4: MTD Erase failure: Input/output error
Erasing 128 Kibyte @ 9440000 -- 59 % complete. Cleanmarker written at 9420000.
flash_eraseall: /dev/mtd4: MTD Erase failure: Input/output error
Erasing 128 Kibyte @ f980000 -- 100 % complete.Cleanmarker written at f960000.

On the omap3530 TI EVM, with the same kernel, I don't see any of these errors.

I'm not sure if its related to something like this:

http://lists.infradead.org/pipermail/linux-mtd/2010-August/031563.html

Thanks,
Cliff

-- 
=================
http://bec-systems.com
