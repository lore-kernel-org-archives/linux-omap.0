From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v2] drivers: net : cpsw: Update Kconfig for CPSW
Date: Thu, 4 Dec 2014 11:47:47 +0530
Message-ID: <547FFC8B.7020100@ti.com>
References: <1417668869-25616-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54746 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbaLDGRx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2014 01:17:53 -0500
In-Reply-To: <1417668869-25616-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>, netdev@vger.kernel.org, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, grygorii.strashko@ti.com, balbi@ti.com, nsekhar@ti.com, t-kristo@ti.com

On Thursday 04 December 2014 10:24 AM, Lokesh Vutla wrote:
> CPSW is present in AM33xx, AM43xx, DRA7xx.
> Updating the Kconfig to depend on ARCH_OMAP2PLUS instead of listing
> all SoC's.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Acked-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
