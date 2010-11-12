From: Grant Erickson <marathon96@gmail.com>
Subject: DSS2 and 2.6.36
Date: Fri, 12 Nov 2010 10:04:39 -0800
Message-ID: <A1FC6DD0-C6CA-4E03-B4DD-C3AD4CCC9619@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59712 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932180Ab0KLSEn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Nov 2010 13:04:43 -0500
Received: by yxn35 with SMTP id 35so180817yxn.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Nov 2010 10:04:42 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I have a Mistral AM37x development board and am working on transitioning it from the 2.6.32 provided with the SDK to 2.6.36 and have run into some issues with the OMAP2 DSS driver that it seems others have encountered as well (e.g. "DSS2 broken with 36-rc1" <http://marc.info/?t=128196295000004&r=1&w=2 and "[PATCH 1/2] video: omap: vram: remove from normal memory" <http://marc.info/?t=128714705300004&r=1&w=2>).

Is 2.6.37-rcY the preferred canonical tree to fast-forward to pick up the remap/allocation/reserve changes for this or is there another preferred tree (e.g. git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git or git://gitorious.org/linux-omap-dss2/linux.git)?

Best,

Grant


