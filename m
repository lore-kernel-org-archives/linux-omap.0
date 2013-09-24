From: Paolo Pisati <p.pisati@gmail.com>
Subject: panda, 3.11 and wifi: 'wlcore: ERROR timeout waiting for the
 hardware to complete initialization'
Date: Tue, 24 Sep 2013 17:35:16 +0200
Message-ID: <20130924153516.GB7410@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:55823 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881Ab3IXPfV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 11:35:21 -0400
Received: by mail-ea0-f172.google.com with SMTP id r16so2584207ead.3
        for <linux-omap@vger.kernel.org>; Tue, 24 Sep 2013 08:35:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Dear,

after the inclusion of 851320e:

 ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for pandaboard

wlan0 is back on my pandaes, but it doesn't work and my logs are swamped
with:

[   56.255401] wlcore: ERROR timeout waiting for the hardware to complete initialization
[   56.264770] wlcore: ERROR firmware boot failed despite 3 retries
[   58.689971] wlcore: ERROR timeout waiting for the hardware to complete initialization
[   61.086730] wlcore: ERROR timeout waiting for the hardware to complete initialization
[   63.523223] wlcore: ERROR timeout waiting for the hardware to complete initialization
[   63.532592] wlcore: ERROR firmware boot failed despite 3 retries
...

any idea what could be wrong now?

here is a complete dmesg: http://goo.gl/e1ZDVp
-- 
bye,
p.
