From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: [PATCH][OMAPZOOM] OMAP3: Initialize XCCR and RCCR registers for
 McBSP DAI driver
Date: Mon, 24 Nov 2008 16:20:42 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705A455AA18@dlee07.ent.ti.com>
References: <1227565078-29925-1-git-send-email-x0052729@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36528 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847AbYKXWUt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 17:20:49 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAOMKhDr027856
	for <linux-omap@vger.kernel.org>; Mon, 24 Nov 2008 16:20:48 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAOMKheh005013
	for <linux-omap@vger.kernel.org>; Mon, 24 Nov 2008 16:20:43 -0600 (CST)
In-Reply-To: <1227565078-29925-1-git-send-email-x0052729@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

> This patch initializes XCCR and RCCR registers for OMAP McBSP DAI driver
> for
> OMAP 2430/34xx platforms. Those registers were being set to 0 as they were
> not properly initialized.
> 
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
This version includes Anand and Chandra's comments.
