From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Change dw_state type to u8
Date: Thu, 22 Apr 2010 16:41:39 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DC16488@dlee03.ent.ti.com>
References: <830E2177532E7946BE0E82F0F4288505044E450B97@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60630 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017Ab0DVVll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 17:41:41 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3MLfeXr011162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:41:40 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o3MLfe08001016
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:41:40 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3MLfe7t027894
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:41:40 -0500 (CDT)
In-Reply-To: <830E2177532E7946BE0E82F0F4288505044E450B97@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>
>From 147cea10f8b5ff19f4a0308f82dedc829e3d1562 Mon Sep 17 00:00:00 2001
>From: Shivananda Hebbar <x0hebbar@ti.com>
>Date: Fri, 19 Mar 2010 13:25:00 -0600
>Subject: [PATCH] DSPBRIDGE: Change dw_state type to u8
>
>The channel state can have values 0, 1 or 2. Hence changing the type to u8.
>
>Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
>---

Pushed to dspbridge.

- omar
