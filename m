From: Kalle Valo <kalle.valo@iki.fi>
Subject: stlc45xx in 2.6.30-rc1
Date: Thu, 23 Apr 2009 21:16:44 +0300
Message-ID: <87skjz6xrn.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51495 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbZDWSQs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 14:16:48 -0400
Received: by fxm2 with SMTP id 2so697976fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2009 11:16:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: stlc45xx-devel@garage.maemo.org

Hello,

I just want to inform that stlc45xx (wi-fi driver for n800/n810) is now
in 2.6.30-rc1 staging directory. I just tried with latest linux-omap and
I was able to associate to an AP and ping.

Here's the config entry:

config STLC45XX
        tristate "stlc4550/4560 support"
        depends on MAC80211 && WLAN_80211 && SPI_MASTER
        ---help---
          This is a driver for stlc4550 and stlc4560 chipsets.

          To compile this driver as a module, choose M here: the module will be
          called stlc45xx.  If unsure, say N.

There is ongoing work to add spi support to p54 by the community.
stlc45xx will be just an interim solution and it will be removed as soon
as p54 catches up.

The stlc45xx git repo at gitorius.org will phase out soon.

-- 
Kalle Valo
