From: Kevin Hilman <khilman@mvista.com>
Subject: OMAP3430: MUSB host and hot-plugging
Date: Wed, 19 Mar 2008 17:14:41 -0700
Message-ID: <87d4pqqmj2.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:15930 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764634AbYCTAOn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 20:14:43 -0400
Received: from paris.hilman.org (asshur.mvista.com [10.0.0.11])
	by hermes.mvista.com (Postfix) with ESMTP id 92E8C184F8
	for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 17:14:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Using the default config omap_3430sdp_defconig, I'm doing some basic
hot-plug tests of MUSB in host mode.

I noticed that after booting, the first time I connect my USB key, it
is detected just fine, the usb/scsi storage modulesare loaded by
hotplug and I can access the device just fine.

I then remove the key, and the kernel seems to detect the removal just
fine, and does what seems to be a clean shutdown.

However, if I then plug the key back in, nothing happens.  

Forcing a session start via "echo 'F' > /proc/driver/musb_hdrc" causes
the device to be (re)detected and things look good again.  It is not
until I force the session start that I see the interrupt and the
CONNECT event.

Any ideas why this isn't detected on insertion?

Thanks,

Kevin

