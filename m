From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: am335x: system doesn't reboot after flashing NAND
Date: Tue, 3 Jun 2014 09:57:52 +0200
Message-ID: <CAGm1_kstgCEQRuaz836v7xg=DHVxpQ6VQPBzkORz1D=18fxp8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:41867 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbaFCH6N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2014 03:58:13 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so5162963pbb.22
        for <linux-omap@vger.kernel.org>; Tue, 03 Jun 2014 00:58:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kernel: 3.14, 3.15 (I haven't tried another kernels)

As soon as I write something to my NAND flash (via cat image >
/dev/mtdblockx or ubiupdatevol) and make reboot or press a reset
button, I see only CCCCC and nothing happens before I make a power
cycle. Any idea?

Yegor
