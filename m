From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [GIT PULL] ARM: omap2: twl-common update
Date: Fri, 15 Mar 2013 10:01:42 +0100
Message-ID: <5142E376.9080407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48999 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab3COJBs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Mar 2013 05:01:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

The branch is on top of today's mainline.
Is it still possible to send this for 3.9?

Regards,
P=E9ter
---
The following changes since commit a2362d24764a4e9a3187fc46b14e1d2cd065=
7700:

  mm/fremap.c: fix possible oops on error path (2013-03-14 17:00:39 -07=
00)

are available in the git repository at:

  git://gitorious.org/omap-audio/linux-audio.git peter/upstream/for-ton=
y

for you to fetch changes up to 25d28e7988512eb4964eca5fc54a214ae69a7154=
:

  omap2: twl-common: Add default power configuration (2013-03-15 09:59:=
28 +0100)

----------------------------------------------------------------
Matthias Brugger (1):
      omap2: twl-common: Add default power configuration

 arch/arm/mach-omap2/twl-common.c | 38 ++++++++++++++++++++++++++++++++=
++++++
 arch/arm/mach-omap2/twl-common.h |  1 +
 2 files changed, 39 insertions(+)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
