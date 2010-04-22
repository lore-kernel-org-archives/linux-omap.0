From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Change channel mode type to u8
Date: Thu, 22 Apr 2010 16:42:36 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DC1648B@dlee03.ent.ti.com>
References: <830E2177532E7946BE0E82F0F4288505044E450B98@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52994 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425Ab0DVVmh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 17:42:37 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3MLgb3x023300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:42:37 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o3MLgbld015262
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:42:37 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3MLgb3l028172
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:42:37 -0500 (CDT)
In-Reply-To: <830E2177532E7946BE0E82F0F4288505044E450B98@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>
>From 4723494935d2188ef014297a5bed66fecb3901ad Mon Sep 17 00:00:00 2001
>From: Shivananda Hebbar <x0hebbar@ti.com>
>Date: Fri, 19 Mar 2010 15:12:03 -0600
>Subject: [PATCH] DSPBRIDGE: Change channel mode type to u8
>
>chnl_mode or dw_mode can have value 0 or 1.
>Hence changing the type to u8.
>
>Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
>---

Reworked as one value is initialized with -1 this can't be u8 changed to s8.

Pushed to dspbridge.

- omar
