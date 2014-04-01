From: Nishanth Menon <nm@ti.com>
Subject: am3517-craneboard: regression?
Date: Tue, 1 Apr 2014 08:57:19 -0500
Message-ID: <533AC5BF.4080502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37263 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbaDAN5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Apr 2014 09:57:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

next-20140401-omap2plus_defconfig
craneboard:  Boot FAIL: http://slexy.org/raw/s2QxOJkvil

multi_v7_defconfig seems to boot fine as well
(http://slexy.org/raw/s20Tg7ldyt).

next-20140331-omap2plus_defconfig
craneboard:  Boot PASS: http://slexy.org/raw/s21s8CTKxd

diffstat between next-20140331 and next-20140401 showed nothing
interesting on a quick look.. no other of my 17 platforms I monitor
showed regression meanwhile.

-- 
Regards,
Nishanth Menon
