From: Yanick Saugy <yanick.saugy@gmail.com>
Subject: NEC lcd ON but still blank
Date: Wed, 8 Sep 2010 23:19:28 +0200
Message-ID: <AANLkTinZs9_B1go+jebjS__T3TnFHvdbQBySYdRgmD-3@mail.gmail.com>
References: <AANLkTimrX9Bnid9wgamXBHKifRKD+LMSvNgb+qUOsAMB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44150 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab0IHVTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 17:19:30 -0400
Received: by iwn5 with SMTP id 5so331994iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Sep 2010 14:19:28 -0700 (PDT)
In-Reply-To: <AANLkTimrX9Bnid9wgamXBHKifRKD+LMSvNgb+qUOsAMB@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I'm working on a zoom2 dev board (omap34x-II MDP), and I can't draw
anything on the LCD display.

I've built kernel 2.6.35 from
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
and then applied the following patchs :
[PATCH 1/2 V7] OMAP: ZOOM2/3&SDP3630: Add display board file for zoom
boards <http://marc.info/?l=linux-omap&m=127445506720934&w=2>
[PATCH 2/2 V7] OMAP: ZOOM2/3&SDP3630: Add display board file for zoom
boards <http://marc.info/?l=linux-omap&m=127445522921326&w=2>
[PATCH V6] OMAP: DSS: Add NEC NL8048HL11-01B display panel
<http://marc.info/?l=linux-omap&m=127445535621669&w=2>

At this time the kernel boots well, and my LCD backlight turns on but
I can't draw anything.
I've checked, the framebuffer device is present and configured with
size of 800x480.

Perhaps I've missed something?

Thank you in advance.

---
Yanick
