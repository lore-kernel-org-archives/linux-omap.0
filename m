From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC][PATCH 2/3] OMAP PM: Add support for bypassing VP/VC in
 Voltage layer
Date: Wed, 16 Mar 2011 12:28:13 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C3078D7@dbde02.ent.ti.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
 <1300199622-32500-3-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35996 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab1CPG7T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 02:59:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2G6xG7q032299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 01:59:18 -0500
In-Reply-To: <1300199622-32500-3-git-send-email-vishwanath.bs@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Sripathy, Vishwanath
> Sent: Tuesday, March 15, 2011 8:04 PM
> To: linux-omap@vger.kernel.org
> Cc: Sripathy, Vishwanath
> Subject: [RFC][PATCH 2/3] OMAP PM: Add support for bypassing 
> VP/VC in Voltage layer
> 
> Currently Voltage layer assumes that all PMICs use VP/VC for 
> Voltage scaling.
> There can be some instances where PMIC would want to bypass 
> VP/VC for voltage
> scaling. So make VOltage layer flexible enough to handle this.

[sp] This series still considers various PMICs meaning various
PMICs in TWL family.

However, this isn't always the case. I had posted an RFC indicating
issues that we come across when PMIC is not TWLx0y0.

I now have an update version of these patches - will be posting
them shortly - for reference.

In my opinion the cleanup needs to start at the basic PMIC
integration - only then we can have separation of concerns - opp,
voltage and smartreflex.

See: http://marc.info/?l=linux-omap&m=129848392424250&w=2

~sanjeev

> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
