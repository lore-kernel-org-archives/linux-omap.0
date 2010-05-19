From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: omap: hwmod questions
Date: Wed, 19 May 2010 11:44:04 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4BCEB3D0@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37748 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634Ab0ESQoH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 12:44:07 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4JGi5FI012236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 11:44:05 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id o4JGi5tW024481
	for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 11:44:05 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o4JGi5hB012815
	for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 11:44:05 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I have few questions regarding hwmod usage. Can any one please respond to this.

1. I see omap_device_build function doing the platform_device_register, but I didn't find the equivalent function that does platform_device_unregister. Is this expected?

2. What is the purpose of omap_device_pm_latency structure that is provided to omap_device_build function?

Thank you,
Best regards,
Hari

