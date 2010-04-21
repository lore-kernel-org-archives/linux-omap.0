From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [RFC][PATCH v1 9/19] DSPBRIDGE: Cleanup custom error code (DSP_EFOPEN
 ->- EBADF)
Date: Wed, 21 Apr 2010 14:50:49 -0500
Message-ID: <4BCF5719.70500@ti.com>
References: <19F8576C6E063C45BE387C64729E7394044DEBEE0F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37971 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756268Ab0DUTuv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Apr 2010 15:50:51 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3LJooPT024726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 21 Apr 2010 14:50:50 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o3LJoofL002723
	for <linux-omap@vger.kernel.org>; Wed, 21 Apr 2010 14:50:50 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3LJooqm004816
	for <linux-omap@vger.kernel.org>; Wed, 21 Apr 2010 14:50:50 -0500 (CDT)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DEBEE0F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 3/26/2010 9:28 PM, Hebbar, Shivananda wrote:
>  From 3bf9c85d6d0794e790491334dca1dde8d0ada863 Mon Sep 17 00:00:00 2001
> From: Shivananda Hebbar<x0hebbar@ti.com>
> Date: Tue, 23 Mar 2010 13:24:31 -0600
> Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_EFOPEN ->- EBADF)
>
> This patch replaces DSP_EFOPEN with -EBADF
>
> Signed-off-by: Shivananda Hebbar<x0hebbar@ti.com>

Rebased and pushed the entire series (1st set of 19 + 2nd set of 13), 
fixed some wrong patch subjects among other issues.

It seems there is one thing left though, let me know if you will take 
care of it.

TODO: print the status codes as decimal instead of hex.

- omar

