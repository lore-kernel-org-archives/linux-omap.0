From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND v5 0/3] Add support for TI814X processor series
Date: Mon, 12 Dec 2011 10:25:16 -0800
Message-ID: <20111212182515.GG31337@atomide.com>
References: <1323482305-32155-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50376 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab1LLSZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 13:25:19 -0500
Content-Disposition: inline
In-Reply-To: <1323482305-32155-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Hemant Pedanekar <hemantp@ti.com> [111209 17:27]:
> This patch set adds support for DM814x/AM387x device series having Cortex-A8
> MPU.
> 
> The technical documents are available from following link:
> 
> http://focus.ti.com/docs/prod/folders/print/tms320dm8148.html
> 
> This series is referred in code as TI814X.
> 
> Since these devices share similar architecture as TI816X devices, existing
> TI816X code is updated to accomodate TI814X support. The code shared across
> TI816X and TI814X devices is updated with TI81XX/ti81xx prefix as applicable,
> while maintaining cpu_is_ti816x() and cpu_is_ti814x() to distinguish specific
> execution differences.

Thanks applying 1 & 2 into soc branch and 3 into board branch.

Regards,

Tony
