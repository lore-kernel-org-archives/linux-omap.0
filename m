From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 5/8] OMAP4 : DSS2 : HDMI: HDMI panel driver addition
 in the DSS
Date: Tue, 1 Mar 2011 19:11:10 +0200
Message-ID: <1298999470.2049.37.camel@deskari>
References: <1298988988-28429-1-git-send-email-mythripk@ti.com>
	 <1298988988-28429-6-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44299 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756162Ab1CARLM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 12:11:12 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21HBCJh031205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 11:11:12 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p21HBBDs019976
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 11:11:11 -0600 (CST)
In-Reply-To: <1298988988-28429-6-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-01 at 08:16 -0600, K, Mythri P wrote:
> The panel driver(hdmi_omap4_panel.c) in dss file acts as a controller
> to manage the enable and disable requests and synchronize audio and video.
> Also the header file to export the hdmi registers is added in the
> plat-omap , so that it can be accessed by audio driver.

Could you review the description. The panel driver is not in "dss file"
and there's no header in this patch.

The locking is broken in this patch. You cannot return from the function
while holding the lock.

 Tomi


