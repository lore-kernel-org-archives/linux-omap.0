From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 0/5] OMAP SMPS regulator driver
Date: Wed, 13 Jul 2011 17:00:33 +0300
Message-ID: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35679 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505Ab1GMOBn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 10:01:43 -0400
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com

Hello,

Based on the comments for the previous version of this set, I implemented
a regulator driver for the OMAP SMPS now. It could actually be moved under
arch/arm/mach-omap2/ directory instead of drivers/regulator, I think it
should work from there also. This would also require less hacking for the
header files. Any thoughts on this?

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

