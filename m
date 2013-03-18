From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [GIT PULL v2] ARM: omap2: twl-common update
Date: Mon, 18 Mar 2013 11:12:37 +0100
Message-ID: <5146E895.50709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57225 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3CRKMl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Mar 2013 06:12:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@list.infradead.org

Hi Tony,

I have rebased the branch on 3.9-rc3 tag.
Is it still possible to send this for 3.9?

Regards,
P=E9ter
---
The following changes since commit a937536b868b8369b98967929045f1df5423=
4323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://gitorious.org/omap-audio/linux-audio.git peter/upstream/for-ton=
y

for you to fetch changes up to 282f21df32df9a01c66d68e7009150ffc69e4e0c=
:

  omap2: twl-common: Add default power configuration (2013-03-18 11:08:=
12 +0100)

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
