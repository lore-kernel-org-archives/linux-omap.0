From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE:Change dev_type to u8
Date: Thu, 22 Apr 2010 16:40:54 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DC16483@dlee03.ent.ti.com>
References: <830E2177532E7946BE0E82F0F4288505044E450B96@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52904 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017Ab0DVVk4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 17:40:56 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3MLetxD023105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:40:55 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o3MLetFc000776
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:40:55 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3MLesjN027641
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:40:55 -0500 (CDT)
In-Reply-To: <830E2177532E7946BE0E82F0F4288505044E450B96@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>
>From e2327644af26aaf22ca6a6b987b745c60e02ab4a Mon Sep 17 00:00:00 2001
>From: Shivananda Hebbar <x0hebbar@ti.com>
>Date: Fri, 19 Mar 2010 12:58:23 -0600
>Subject: [PATCH] DSPBRIDGE:Change dev_type to u8
>
>dev_type can take one of the 2 values
>DSP_UNIT    0
>IVA_UNIT    1
>So it need not be s32 or u32. Hence changing it to u8.
>
>Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
>---

Pushed to dspbridge.

- omar
