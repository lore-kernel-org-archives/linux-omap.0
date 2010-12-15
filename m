From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [GIT PULL] OMAP: mailbox and iommu changes: for-next for v2.6.38
Date: Wed, 15 Dec 2010 16:49:00 -0600
Message-ID: <AANLkTi=d58bT9TdrGQWwayt7G-h2nEtCv=M18zV48AK6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:51783 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751691Ab0LOWtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 17:49:01 -0500
Received: by mail-pz0-f45.google.com with SMTP id 2so440210pzk.32
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 14:49:01 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi Tony,

The following changes since commit e8a7e48bb248a1196484d3f8afa53bded2b24e71:
 Linus Torvalds (1):
       Linux 2.6.37-rc4

are available in the git repository at:

 git://gitorious.org/iommu_mailbox/iommu_mailbox.git for_2.6.38

Felipe Contreras (1):
     OMAP: iommu: make iva2 iommu selectable

Fernando Guzman Lugo (1):
     OMAP: mailbox: change full flag per mailbox queue instead of global

Guzman Lugo, Fernando (4):
     OMAP: iovmm: no gap checking for fixed address
     OMAP: iovmm: add superpages support to fixed da address
     OMAP: iovmm: replace __iounmap with iounmap
     OMAP: iommu: create new api to set valid da range

Kanigeri, Hari (3):
     OMAP: mailbox: fix checkpatch warnings
     OMAP: mailbox: send message in process context
     OMAP: mailbox: add notification support for multiple readers

Omar Ramirez Luna (2):
     OMAP: mailbox: remove unreachable return
     OMAP: mailbox: fix detection for previously supported chips

 arch/arm/mach-omap2/mailbox.c             |   19 +++--
 arch/arm/mach-omap2/omap-iommu.c          |   10 ++-
 arch/arm/plat-omap/Kconfig                |    3 +
 arch/arm/plat-omap/include/plat/iommu.h   |    5 +
 arch/arm/plat-omap/include/plat/mailbox.h |    8 +-
 arch/arm/plat-omap/iommu.c                |   24 +++++
 arch/arm/plat-omap/iovmm.c                |   81 ++++++++++--------
 arch/arm/plat-omap/mailbox.c              |  130 +++++++++++++++++------------
 8 files changed, 179 insertions(+), 101 deletions(-)

The above patch set is dependent on the following 2 Russell's patches.

ARM: io: make iounmap() a simple macro
ARM: io: simplify ioremap* and iounmap definitions
Ref: http://www.spinics.net/lists/linux-omap/msg42023.html

Thank you,
Best regards,
Hari Kanigeri
