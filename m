From: Nishant Kamat <nskamat@ti.com>
Subject: [RESENDING PATCH 0/4] Support for omap3430 LDP (zoom)
Date: Thu, 15 May 2008 09:30:28 -0500
Message-ID: <1210861832-10048-1-git-send-email-nskamat@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:37941 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbYEOOai (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 May 2008 10:30:38 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m4FEUXBo004440
	for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 09:30:38 -0500
Received: from legion.dal.design.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m4FEUWDt027637
	for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 09:30:32 -0500 (CDT)
Received: from dirac.dal.design.ti.com (dirac.dal.design.ti.com [128.247.25.123])
	by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id m4FEUWG02628
	for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 09:30:32 -0500 (CDT)
Received: from dirac.dal.design.ti.com (localhost.localdomain [127.0.0.1])
	by dirac.dal.design.ti.com (8.12.11/8.12.11) with ESMTP id m4FEUWwi027394
	for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 09:30:32 -0500
Received: (from a0868510@localhost)
	by dirac.dal.design.ti.com (8.12.11/8.12.11/Submit) id m4FEUWl5027391
	for linux-omap@vger.kernel.org; Thu, 15 May 2008 09:30:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Tony, All,

> -----Original Message-----
> From: Kamat, Nishant
> Sent: Friday, May 02, 2008 4:57 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH 0/7] Support for OMAP3430 LDP (Zoom)
> 
> 
> Tony, All,
> 
> Following is a series of patches that add basic support for OMAP3430
> LDP, also known as the Zoom development kit. Refer [1] for more info.

I am resending the patches with the following changes:
	- added MUSB as suggested by Filipe
	- split out twl4030.h additions in a separate patch, as
	  suggested by Tony.
	- removed the drivers/net/smc911x.[ch] changes from the series,
	  as suggested by Tony. I submitted them separately to linux-netdev.
	- removed NAND driver changes from the series for now as more
	  changes are required.

Thanks,
Nishant
