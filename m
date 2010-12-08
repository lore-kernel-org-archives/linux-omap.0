From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] staging: tidspbridge: use the right type for list_is_last
Date: Wed,  8 Dec 2010 16:20:23 -0600
Message-ID: <1291846823-31513-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35176 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab0LHWbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 17:31:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ionut Nicu <ionut.nicu@gmail.com>

Removes the following warning:

  CC [M]  drivers/staging/tidspbridge/rmgr/rmm.o
drivers/staging/tidspbridge/rmgr/rmm.c: In function 'rmm_alloc':
drivers/staging/tidspbridge/rmgr/rmm.c:147: warning: passing
	argument 1 of 'list_is_last' from incompatible pointer type
include/linux/list.h:170: note: expected 'const struct list_head *'
	but argument is of type 'struct rmm_ovly_sect *'

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/rmgr/rmm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/rmm.c b/drivers/staging/tidspbridge/rmgr/rmm.c
index aae8657..5a3f09c 100644
--- a/drivers/staging/tidspbridge/rmgr/rmm.c
+++ b/drivers/staging/tidspbridge/rmgr/rmm.c
@@ -144,7 +144,7 @@ int rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
 			new_sect->addr = addr;
 			new_sect->size = size;
 			new_sect->page = segid;
-			if (list_is_last(sect, &target->ovly_list))
+			if (list_is_last(&sect->list_elem, &target->ovly_list))
 				/* Put new section at the end of the list */
 				list_add_tail(&new_sect->list_elem,
 						&target->ovly_list);
-- 
1.7.1

