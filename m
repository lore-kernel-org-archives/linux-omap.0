From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: watchdog pdev id set to -1
Date: Fri, 18 Feb 2011 16:11:11 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370061699@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43853 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756824Ab1BRKlR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 05:41:17 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1IAfEat018479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 04:41:16 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1IAfDJ9026637
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 16:11:13 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

There this boot-time message (on both omap3 and am3517 evms atleast):
[    1.904418] omap_device: omap_wdt.-1: new worst case activate latency 0: 6105

omap_init_wdt() initializes the id to -1 and then omap_device_build() is called with this value; this eventually calls platform_device_register() with a pdev having id as -1. I don't see any code that checks for this -1 and changes it to a non-erroneous value.

Perhaps there is a reason I've failed to notice?
Please comment.
Else I'm planning to submit a patch which fixes this.

- Abhilash

