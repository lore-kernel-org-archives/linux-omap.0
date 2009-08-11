From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: query: omap-defconfigs
Date: Wed, 12 Aug 2009 03:01:37 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F598989C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39506 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753556AbZHKVby convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 17:31:54 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7BLVnx1013215
	for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2009 16:31:55 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


For the omap board defconfigs, is there a plan to remove these entries:
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y

I can see that on pm branch on kevin's tree, these are not enabled.

With older busybox, I needed these entries to be enabled, but switching to latest busybox 1_9_2 I could disable these entries without problem.

Anything we would break by removing these DEPRECATED entries? 

