From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [REGRESSION] No serial console output on BeagleBone Black
Date: Mon, 25 May 2015 16:24:32 +0200
Message-ID: <CAMpxmJVhoWtyzhNBrnyYaiJSa_kSL_HQsJfbWQm5CQGTPac7=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35759 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbEYOYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2015 10:24:33 -0400
Received: by igbyr2 with SMTP id yr2so37573826igb.0
        for <linux-omap@vger.kernel.org>; Mon, 25 May 2015 07:24:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>

Hi Tero,

I tried booting a BeagleBone Black Rev C with current git, but got no
output after u-boot's "Starting kernel ...". Bisect points at commit
e3bc5358 ARM: dts: am33xx: add minimal l4 bus layout with control
module support. Let me know if you need any more info.

Best regards,
Bartosz Golaszewski
