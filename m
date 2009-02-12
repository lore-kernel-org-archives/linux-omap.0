From: Matthias Ludwig <matthias.ludwig@gmx.net>
Subject: omapfb: 24bpp not working?
Date: Thu, 12 Feb 2009 10:50:59 +0100
Message-ID: <cb7bedd90902120150l609ee132rfc76f28b223e923b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f31.google.com ([209.85.219.31]:63420 "EHLO
	mail-ew0-f31.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079AbZBLJvA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 04:51:00 -0500
Received: by ewy12 with SMTP id 12so168360ewy.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 01:50:59 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I selected a 1024x768x24bpp in the drivers/video/omap/lcd_xxx file for
a new platform (very similar to OMAP3EVM) which has a display
connected to the CPU using a LVDS-transmitter. Everything works find,
but the systems does not send 888-RGB-values but 565 ones, even if i
select bpp = 24 and data_lines = 24 in my lcd-configuration.

The framebuffer-device has the correct size (dd if=/dev/fb0
of=/tmp/fb-dump gives me a file which is 1024x768x3=2359296 bytes).
If i fill the display up with a solid color and then run following command:
dd if=/dev/zero of=/dev/fb0 bs=1024 count=1
half a display-line is getting black (should only be 1 third)

Any ideas on that?

Thanks,
Matthias
