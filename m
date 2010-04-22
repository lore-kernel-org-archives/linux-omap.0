From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Change num_proc type to u8.
Date: Thu, 22 Apr 2010 16:42:55 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DC1648D@dlee03.ent.ti.com>
References: <830E2177532E7946BE0E82F0F4288505044E450B9B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50397 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581Ab0DVVm4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 17:42:56 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3MLguRG008133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:42:56 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o3MLgugO001369
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:42:56 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3MLgtD0028273
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 16:42:56 -0500 (CDT)
In-Reply-To: <830E2177532E7946BE0E82F0F4288505044E450B9B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>
>From 1203012297c7b0a6a36f000a870c5e1210a233e1 Mon Sep 17 00:00:00 2001
>From: Shivananda Hebbar <x0hebbar@ti.com>
>Date: Fri, 19 Mar 2010 17:29:46 -0600
>Subject: [PATCH] DSPBRIDGE: Change num_proc type to u8.
>
>num_proc is used to represent number of processors.
>As of now its 1. Also it can not be > 256.
>So changing it to u8.
>
>Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
>---

Reworked and pushed to dspbridge.

- omar
