From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH v3 1/3] staging: tidspbridge: fix mgr_enum_node_info
Date: Fri,  5 Nov 2010 18:31:12 +0200
Message-ID: <1288974674-24330-2-git-send-email-ionut.nicu@mindbit.ro>
References: <1288974674-24330-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45057 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab0KEQbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 12:31:31 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2827646bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 09:31:30 -0700 (PDT)
In-Reply-To: <1288974674-24330-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

The current code was always returning a non-zero status value
to userspace applications when this ioctl was called.

The error code was ENODATA, which isn't actually an error,
it's always returned by dcd_enumerate_object() when it hits the
end of list.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/rmgr/mgr.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/mgr.c b/drivers/staging/tidspbridge/rmgr/mgr.c
index 0ea89a1..2eab6a5 100644
--- a/drivers/staging/tidspbridge/rmgr/mgr.c
+++ b/drivers/staging/tidspbridge/rmgr/mgr.c
@@ -169,6 +169,11 @@ int mgr_enum_node_info(u32 node_id, struct dsp_ndbprops *pndb_props,
 
 		}
 	}
+
+	/* the last status is not 0, but neither an error */
+	if (status > 0)
+		status = 0;
+
 	if (!status) {
 		if (node_id > (node_index - 1)) {
 			status = -EINVAL;
-- 
1.7.2.3

