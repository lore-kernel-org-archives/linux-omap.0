From: "Venkatesh, Subbu" <subbu.wrs@ti.com>
Subject: Early gpio_request on LDP for LCD fails
Date: Thu, 4 Jun 2009 19:10:54 -0500
Message-ID: <5F744A5A3C131242B81CE5874BD2CFFB34E35EBE@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54492 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbZFEALK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 20:11:10 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n550B8Fl032316
	for <linux-omap@vger.kernel.org>; Thu, 4 Jun 2009 19:11:13 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n550B7rx025387
	for <linux-omap@vger.kernel.org>; Thu, 4 Jun 2009 19:11:07 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n550B7Sn017109
	for <linux-omap@vger.kernel.org>; Thu, 4 Jun 2009 19:11:07 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Venkatesh, Subbu" <subbu.wrs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
I am getting failed messages when I try gpio_request for LCD in the early board_init (GPIO number is (9+OMAP_GPIO_LINES_MAX)).
Could any one suggest me how to resolve it, or any inputs are appreicated.

Regards,
Subbu
