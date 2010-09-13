From: Yanick Saugy <yanick.saugy@heig-vd.ch>
Subject: LCD on Zoom2 dev board with DSS
Date: Mon, 13 Sep 2010 14:43:27 +0200
Message-ID: <1284381807.1801.38.camel@A05BPC17>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.infomaniak.ch ([84.16.68.90]:49536 "EHLO
	smtp2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab0IMMt0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 08:49:26 -0400
Received: from [10.192.51.60] (pub1.heig-vd.ch [193.134.216.2])
	(authenticated bits=0)
	by smtp2.infomaniak.ch (8.14.2/8.14.2) with ESMTP id o8DChQh4017397
	for <linux-omap@vger.kernel.org>; Mon, 13 Sep 2010 14:43:28 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all, 

I'm working on a zoom2 dev board (omap34x-II MDP). There is my actual config :

I've built kernel 2.6.35 from git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
and then applied the following patchs :
[PATCH 1/2 V7] OMAP: ZOOM2/3&SDP3630: Add display board file for zoom boards <http://marc.info/?l=linux-omap&m=127445506720934&w=2>
[PATCH 2/2 V7] OMAP: ZOOM2/3&SDP3630: Add display board file for zoom boards <http://marc.info/?l=linux-omap&m=127445522921326&w=2>
[PATCH V6] OMAP: DSS: Add NEC NL8048HL11-01B display panel <http://marc.info/?l=linux-omap&m=127445535621669&w=2>

Finally I've enabled DSS and lcd NEC_NL8048HL11 in kernel config file.

At this time the kernel boots well, and my LCD backlight turns on but I can't see TUX while booting, and I can't draw anything after logging in.
I've checked, the framebuffer device is present and configured with size of 800x480.

I've played with sys filesystem like on this wiki, but nothing happened:
<http://www.omappedia.org/wiki/Bootargs_for_enabling_display>

To enable DSS at boot time, I passed following boot options:
vram=10M omapdss.def_disp=lcd


Perhaps I've missed something?

Thank you in advance.

---
Yanick

