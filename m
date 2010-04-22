From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Change max channels/open channels type to u8
Date: Thu, 22 Apr 2010 16:43:37 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DC16491@dlee03.ent.ti.com>
References: <830E2177532E7946BE0E82F0F4288505044E450B99@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45665 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab0DVVnj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 17:43:39 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3MLhc3f030504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:43:38 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3MLhcOn011697
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:43:38 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3MLhc4c028512
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:43:38 -0500 (CDT)
In-Reply-To: <830E2177532E7946BE0E82F0F4288505044E450B99@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>
>From eb282300f2527473fa0bfbaa23a516ca8361f18a Mon Sep 17 00:00:00 2001
>From: Shivananda Hebbar <x0hebbar@ti.com>
>Date: Fri, 19 Mar 2010 16:15:25 -0600
>Subject: [PATCH] DSPBRIDGE: Change max channels/open channels type to u8
>
>max channels can have max value of 32. So changing
>max channnels and open channels type to u8
>
>Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
>---

Pushed to dspbridge.

- omar
