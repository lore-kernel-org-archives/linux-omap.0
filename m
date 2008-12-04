From: "Smith, Stephen" <smsmith@ti.com>
Subject: OMAP Zoom kernel ALSA build problem
Date: Thu, 4 Dec 2008 09:38:56 -0600
Message-ID: <23D0CDE7C386D144A4F26EB0F427F8C019A5829E@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42014 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202AbYLDPjB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 10:39:01 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mB4FctVE023859
	for <linux-omap@vger.kernel.org>; Thu, 4 Dec 2008 09:39:00 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mB4Fct56001235
	for <linux-omap@vger.kernel.org>; Thu, 4 Dec 2008 09:38:55 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I am trying to build sound support for the MDK (3430LDP).=A0 There is a=
 build problem on the current git master of the OMAP Zoom kernel.=A0 If=
 "OMAP3 TWL4030 alsa driver" is turned on, the compile fails (looks lik=
e the header for the twl4030 gpio routines is missing).=A0 Additionally=
, if it is selected as a Module, the build will also fail because only =
CONFIG_SND_OMAP3_TWL4030 is being checked (not CONFIG_SND_OMAP3_TWL403_=
MODULE) in sound/arm/omap/omap-alsa-dma.h.

Device Drivers -=20
=A0 Sound card support -=20
=A0=A0=A0 Advanced Linux Sound Architecture -=20
=A0=A0=A0=A0=A0 ARM sound devices -
=A0=A0=A0=A0=A0=A0=A0 OMAP3 TWL4030 alsa driver


sound/arm/omap/omap-alsa-twl4030.c: In function 'twl4030_ext_mut_conf':
sound/arm/omap/omap-alsa-twl4030.c:312: error: implicit declaration of =
function 'twl4030_request_gpio'
sound/arm/omap/omap-alsa-twl4030.c:317: error: implicit declaration of =
function 'twl4030_set_gpio_direction'
sound/arm/omap/omap-alsa-twl4030.c: In function 'twl4030_ext_mut_unconf=
':
sound/arm/omap/omap-alsa-twl4030.c:329: error: implicit declaration of =
function 'twl4030_free_gpio'
sound/arm/omap/omap-alsa-twl4030.c: In function 'twl4030_ext_mut_off':
sound/arm/omap/omap-alsa-twl4030.c:344: error: implicit declaration of =
function 'twl4030_set_gpio_dataout'


OMAP Linux Kernel Tracker Bug ID 224

Stephen

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
