From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: [PATCH 0/2] staging: tidspbridge: fix dma race condition
Date: Mon, 20 Dec 2010 16:25:32 +0200
Message-ID: <1292855134-14374-1-git-send-email-felipe.contreras@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I found a race condition that triggers a kernel panic. It's explained in the
following patches, but basically the map_obj that contains the user pages is
being destroyed while doing a DMA operation (which requires that map_obj).

My solution is to convert the spinlock to a semaphore, and exten the area
protected (which might sleep).

I have not tested these specific patches; they have been forward ported. But in
a similar branch, they solve the issue.

Felipe Contreras (2):
  staging: tidspbridge: convert dmm_map_lock to sema
  staging: tidspbridge: extend dmm_map semaphore

 .../staging/tidspbridge/include/dspbridge/drv.h    |    2 +-
 drivers/staging/tidspbridge/rmgr/drv_interface.c   |    2 +-
 drivers/staging/tidspbridge/rmgr/proc.c            |   23 +++++++++++++-------
 3 files changed, 17 insertions(+), 10 deletions(-)

-- 
1.7.3.3
