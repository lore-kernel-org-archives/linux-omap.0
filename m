From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 0/9] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Mon, 7 Mar 2011 10:40:05 +0200
Message-ID: <1299487205.2281.81.camel@deskari>
References: <1299224907-11354-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46918 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895Ab1CGIkK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 03:40:10 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p278e9pu018685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 02:40:09 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p278e9jI016670
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 02:40:09 -0600 (CST)
In-Reply-To: <1299224907-11354-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-03-04 at 01:48 -0600, K, Mythri P wrote:
> Adding HDMI support on OMAP4.
> 
> HDMI is a driver that is similar to the VENC or the DSI driver to support
> HDMI/DVI sink device.

<snip>

> 1. v10 of omap2,3 hwmod DSS adaptation:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42914.html
> 2. v3 of OMAP2PLUS: DSS: Generalize clock names
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43338.html
> 3. v3 of OMAP4: hwmod DSS support:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43177.html
> 4. OMAP: DSS2: Adding dss_features for independent core clk divider 
> https://patchwork.kernel.org/patch/529561/
> 5. OMAP2PLUS-DSS2-Make-members-of-dss_clk_source-generic

I believe all these are now in DSS2 tree's master branch, so can you
rebase the next version on top of the master branch?

 Tomi


