From: Joachim Eastwood <manabian@gmail.com>
Subject: DSS and HDMI kernel panic on OMAP4
Date: Thu, 15 May 2014 23:14:37 +0200
Message-ID: <CAGhQ9VyEsX2FmJj4TWgrKMggz=zH--rrVKaztV6AWwLQZTsDUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:61499 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbaEOVOi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 17:14:38 -0400
Received: by mail-vc0-f172.google.com with SMTP id hr9so5134864vcb.31
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2014 14:14:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Tomi,

I wanted to test my Variscite patches after Tony merged them into his
3.16 dt branch so created a base branch from Linus master and pull in
Tony's 3.16 dt and your dss for-next branch.

I discovered that booting with a HDMI monitor connected or plugging in
one cause a kernel panic. See the log at:
http://slexy.org/raw/s20xo68UPx

Any idea what it could be?

I also noted this in the boot log:
[ 0.984527] omapdss_hdmi 58006000.encoder: can't request region for
resource [mem 0x58006400-0x580073ff]

I don't think I have seen this before.

What I previously have tested have been Linus master + my Variscite
patches and your panel-dpi dt + hdmi hpd patches cherry-picked.

regards
Joachim Eastwood
