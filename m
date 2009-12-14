From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 0/4] i2c driver conversion to use omap_device/omap_hwmod
Date: Mon, 14 Dec 2009 14:42:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4EC7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52682 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbZLNJMl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 04:12:41 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBE9CbtB015991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 03:12:40 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBE9CbkB010714
	for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 14:42:37 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

This patch-set adds support for using omap_device api's based on omap_hwmod
layer for i2c driver.

I have based these currently on 'pm-wip/uart' branch manitained by Kevin Hilman [1].
These add hwmod structures for OMAP3 only and are validated on omap3430sdp.
These would break OMAP2/4 untill the hwmod structures are available for them.

regards,
Rajendra

----

Paul Walmsley (1):
OMAP: I2C: split device registration; convert OMAP2+ to omap_device

Rajendra Nayak (3):
OMAP2: Fix compile breaks
OMAP3: hwmod: add I2C hwmods for OMAP3430
I2C: Convert i2c driver to use omap_device/omap_hwmod

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git