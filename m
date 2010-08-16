From: Ameya Palande <ameya.palande@nokia.com>
Subject: DSS2 broken with 36-rc1
Date: Mon, 16 Aug 2010 15:48:26 +0300
Message-ID: <1281962906.1888.25.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:64879 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab0HPMsu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Aug 2010 08:48:50 -0400
Received: from nokia.com (localhost [127.0.0.1])
	by mgw-sa02.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o7GCiCxA027752
	for <linux-omap@vger.kernel.org>; Mon, 16 Aug 2010 15:45:12 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Tomi,

When I tried to boot 2.6.36-rc1 kernel on Nokia N900, omapfb failed with
following error messages:

[    0.124145] OMAP DSS rev 2.0
[    0.124237] OMAP DISPC rev 3.0

[    0.303833] acx565akm spi1.2: omapfb: acx565akm rev 8b LCD detected

[    0.805419] omapfb omapfb: failed to allocate framebuffer
[    0.810882] omapfb omapfb: failed to allocate fbmem
[    0.815856] omapfb omapfb: failed to setup omapfb
[    0.820648] omapfb: probe of omapfb failed with error -12

I used CONFIG_CMDLINE="console=tty0 console=ttyS2,115200n8
omapfb.vram=0:2M,1:2M,2:2M nosplash"

I have verified that the kernel config which I used, works well with
2.6.35 series kernel.

Cheers,
Ameya.

