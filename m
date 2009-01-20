From: pramod gurav <pramodforum@gmail.com>
Subject: i2c-probe in 2.6.28 returns -EOPNOTSUPP
Date: Tue, 20 Jan 2009 18:20:58 +0530
Message-ID: <f502236f0901200450n4e943c63n7da6ac815efe4aca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.239]:25085 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbZATMvA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2009 07:51:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

Hi All
I am trying to port the i2c client drivers from linux-omap-2.6.26 to 2.6.28.
The i2c client drivers are old styled. The i2c-probe function called by
attach_adapter function returns -EOPNOTSUPP.
This states adapter does not support SMBUS_QUICK command.
Same driver on linux-omap-2.6.26 works well.
The omap_i2c_func in i2c-omap.c driver doesn't seem to be returning
this support.

What changes have gone into i2c-omap driver that are causing i2c-probe
function to return this error value?

-- 
Best Regards
Pramod
