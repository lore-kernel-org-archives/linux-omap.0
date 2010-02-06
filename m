From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix to avoid possible memory leaks in bridge
 driver.
Date: Fri, 5 Feb 2010 19:57:51 -0600
Message-ID: <4B6CCC9F.7090407@ti.com>
References: <B852767254C5C94EBB1040EE0EFA06008C4CFD72@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52538 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933133Ab0BFB5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 20:57:52 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o161vqoJ024448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 19:57:52 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o161vpTw014351
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 19:57:51 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o161vptd001513
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 19:57:51 -0600 (CST)
In-Reply-To: <B852767254C5C94EBB1040EE0EFA06008C4CFD72@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 1/28/2010 12:27 PM, Ramos Falcon, Ernesto wrote:
>  From e586fe38099ac140e037fda9d2e7d3a846ec023c Mon Sep 17 00:00:00 2001
> From: Ernesto Ramos<ernesto@ti.com>
> Date: Thu, 28 Jan 2010 12:11:39 -0600
> Subject: [PATCH] DSPBRIDGE: Fix to avoid possible memory leaks in bridge driver.
>
> This patch fixes possible memory leaks detected in dsp bridge.
>
> Signed-off-by: Ernesto Ramos<ernesto@ti.com>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

> ---
>   drivers/dsp/bridge/pmgr/dbll.c  |    3 ++-
>   drivers/dsp/bridge/rmgr/drv.c   |    4 ++--
>   drivers/dsp/bridge/wmd/msg_sm.c |    8 ++------
>   3 files changed, 6 insertions(+), 9 deletions(-)
>

Pushed to dspbridge.

- omar
