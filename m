From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 0/3] omap: rx51: board-rx51-peripherals.c updates
Date: Wed, 26 May 2010 10:30:14 +0300
Message-ID: <1274859017-19509-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:33953 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab0EZH34 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 03:29:56 -0400
Received: by ewy8 with SMTP id 8so748155ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 00:29:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Hi

There are now required sound/soc/ patches in mainline and linux-omap to get
basic Nokia N900 audio working.

Patch 1/3 is continuation to earlier set, see

http://marc.info/?l=linux-omap&m=127306914008392&w=2

IMO, it should go for 2.6.35 as it's kind of fix for unworking audio due
codec being in unknown reset state.

Patches 2-3/3 are posted earlier but now based on top 1/3 since it has
priority over them.

Patches 2/3/3 are not important for 2.6.35 but they are preparation for 2.6.36
and must hit the mainline before adding headphone support to
sound/soc/omap/rx51.c.


-- 
Jarkko
