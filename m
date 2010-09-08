From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: RE: [PATCH 0/5] usb: omap: prepare for OMAP4 EHCI and OHCI support
Date: Wed, 8 Sep 2010 13:21:04 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C2018B20@dbde02.ent.ti.com>
References: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38772 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758028Ab0IHHvL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 03:51:11 -0400
In-Reply-To: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-usb-owner@vger.kernel.org" <linux-usb-owner@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "Kamat, Nishant" <nskamat@ti.com>

> -----Original Message-----
> From: Munegowda, Keshava
> Sent: Wednesday, August 18, 2010 8:26 AM
> To: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
> Cc: Munegowda, Keshava
> Subject: [PATCH 0/5] usb: omap: prepare for OMAP4 EHCI and OHCI support
> 
> This series does minor code cleanup in preparation of an upcoming
> series to add support for EHCI and OHCI on the OMAP4 SoC.
> 
> The changes are:
> - Rename clock names to be consistent across OMAP3 and OMAP4
> - Remove hardcoding of the number of TLL channels
> - Move PHY reset earlier in the init sequence
> 
> These patches do not make any changes to existing functionalities.
> 
> Diffstat is below:
> 
> drivers/usb/host/ehci-omap.c                   |  104 ++++++++++++-------------
> drivers/usb/host/ohci-omap3.c                  |   55 ++++++-------
> 2 files changed
> ---
> Keshava

These are minor patches required for the adding omap4 support for 
EHCI and OHCI in near feature.
Requesting for merge to the current merge window, so that the next 
set of EHCI and OHCI specific changes will be aligned with this patch set.

Keshava Munegowda

