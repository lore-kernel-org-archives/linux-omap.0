From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH v2 0/3] staging: tidspbridge: bugfixes
Date: Fri,  5 Nov 2010 17:15:45 +0200
Message-ID: <1288970148-22191-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39839 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab0KEPQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 11:16:04 -0400
Received: by bwz11 with SMTP id 11so2759744bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 08:16:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Changes since v1:

* Split the mgr_enum_node_info patch into two patches:
one that fixes the issue and one that reorganizes the
code.

Ionut Nicu (3):
  staging: tidspbridge: fix mgr_enum_node_info
  staging: tidspbridge: mgr_enum_node_info cleanup
  staging: tidspbridge: fix kernel oops in bridge_io_get_proc_load

 drivers/staging/tidspbridge/core/io_sm.c |   78 +++++++++++------------------
 drivers/staging/tidspbridge/rmgr/mgr.c   |   50 +++++++------------
 2 files changed, 48 insertions(+), 80 deletions(-)

-- 
1.7.2.3

