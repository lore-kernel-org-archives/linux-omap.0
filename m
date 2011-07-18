From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 0/6] OMAP SMPS regulator driver
Date: Mon, 18 Jul 2011 20:35:16 +0300
Message-ID: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51145 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477Ab1GRRgE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jul 2011 13:36:04 -0400
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com

Hello,

Main changes compared to v2:

- cleanup should now work better
- register all available regulators always, if no initdata => readonly
- added board init support functionality to twl-common
- constraints not touched by the driver anymore

Tested on omap3 beagle.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

