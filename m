From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH v4 0/3] staging: tidspbridge: bugfixes
Date: Fri,  5 Nov 2010 19:01:47 +0200
Message-ID: <1288976510-25470-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62296 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0KERCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 13:02:16 -0400
Received: by gyh4 with SMTP id 4so2320897gyh.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 10:02:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Changes since v1:

* Split the mgr_enum_node_info patch into two patches:
one that fixes the issue and one that reorganizes the
code.

Changes since v2:

* Set proper authorship on patch 1/3

Felipe Contreras (1):
  staging: tidspbridge: fix mgr_enum_node_info

Ionut Nicu (2):
  staging: tidspbridge: mgr_enum_node_info cleanup
  staging: tidspbridge: fix kernel oops in bridge_io_get_proc_load

 drivers/staging/tidspbridge/core/io_sm.c |   78 +++++++++++------------------
 drivers/staging/tidspbridge/rmgr/mgr.c   |   50 +++++++------------
 2 files changed, 48 insertions(+), 80 deletions(-)

-- 
1.7.2.3

