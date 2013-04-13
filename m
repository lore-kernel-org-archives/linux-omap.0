From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [BUG] omap: mfd/regulator: twl/core: init order
Date: Sat, 13 Apr 2013 20:27:39 +0200
Message-ID: <1365877659.3812.110.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:41025 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab3DMS1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Apr 2013 14:27:44 -0400
Received: by mail-bk0-f50.google.com with SMTP id jg1so1791598bkc.9
        for <linux-omap@vger.kernel.org>; Sat, 13 Apr 2013 11:27:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Liam Girdwood <lrg@ti.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>

Hi

 while testing an omap3 board with device tree support I stumbled upon a
bug which is due to wrong initialization order of twl-core and
twl-regulator (I suppose): In the boot process they get loaded way too
late so that a lot of drivers before where configured wrong or just
refuse to load.

For example the real time clock driver: The RTC kicks in way before
twl_probe() and due to that it configures its register map wrong
(at this time twl_priv->twl_id isn't configured yet).

Another example is the omap display subsystem. It (DSS) fails loading
while trying to register some not yet existent regulators and because it
lacks EPROBE_DEFER.

USB and MMC is also not working and I'm suspicious of the same cause.

Any ideas?

 Thanks
  -- Christoph

