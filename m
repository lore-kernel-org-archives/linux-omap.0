From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH 0/1] Export clock notifier symbols to kernel modules
Date: Thu, 12 Feb 2009 14:51:48 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C1026@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C0BED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57916 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755017AbZBLJWY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 04:22:24 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1C9MHvM002326
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 03:22:23 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1C9MGZ3003056
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 14:52:16 +0530 (IST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C0BED@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All,
Some mistake in mail configuration, it didn't reach the list, I resent the same.
Thanks
Ramesh Gupta G 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gupta, Ramesh
> Sent: Thursday, February 12, 2009 6:52 AM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH 0/1] Export clock notifier symbols to kernel modules
> 
> 
> Hi All,
> This is to export clk_notifier_register and 
> clk_notifier_unregister Symbols for building kernel module. 
> This can be applied on pm branch.
> 
> 
> Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> ---
> arch/arm/plat-omap/clock.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
> 
> 
> Please let me know your comments.
> 
> Thanks & regards
> Ramesh Gupta G
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
> 