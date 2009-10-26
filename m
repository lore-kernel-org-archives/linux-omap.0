From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 2/2] Accomodate the board file change in Kconfig
Date: Mon, 26 Oct 2009 06:05:03 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AC2284F@dlee02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFDFA7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54097 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580AbZJZLFA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 07:05:00 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9QB55B3021390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 06:05:05 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9QB54Ar003792
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 06:05:04 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9QB54er007154
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 06:05:04 -0500 (CDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFDFA7@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pais, Allen" <allen.pais@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pais, Allen
> Sent: Monday, October 26, 2009 2:43 AM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH 2/2] Accomodate the board file change in Kconfig
> 
> From 0599ed35fde00cd84681e5d8f9a57a797fae1270 Mon Sep 17 00:00:00 2001
> From: Allen Pais <allen.pais@ti.com>
> Date: Mon, 26 Oct 2009 12:51:02 +0530
> Subject: [PATCH 2/2] Accomodate the board file change in Kconfig
> 
> 
> Signed-off-by: Allen Pais <allen.pais@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig  |    4 ++++
>  arch/arm/mach-omap2/Makefile |    1 +
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
Please merge this to patch 1/2 I think we could have this as part of the 1/2
Which was to introduce 3630sdp support.

Regards,
Nishanth Menon
