From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Add new omap_dss_device after dss_device_registration
Date: Wed, 27 Oct 2010 13:39:10 +0200
Message-ID: <AANLkTi=ph99HPyzNunrjKZnQqrndghCV5DVTUizjNN9+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60260 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab0J0LjL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 07:39:11 -0400
Received: by qwk3 with SMTP id 3so574699qwk.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Oct 2010 04:39:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Hello all,

Can I add a new omap_dss_device after dss_device registration  ?
Something like add_new_omap_dss_device(lcd_device) or similar ?

On IGEP v2 we register only igep2_dvi_device as dss_device, We want to
add a new dss_device (igep2_lcd_device) after dss registration. Is it
possible ?

For example we want to do something like this :

  step 1: register IGEP v2  dss_devices (dvi)
  step 2: detect if IGEP expansion board is detected.
  step 3: if it's detected add new dss_devices (lcd)

Thanks in advance,
  Enric
