From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 00/15] OMAPDSS: remove old panel model code
Date: Thu, 29 Aug 2013 20:05:33 +0530
Message-ID: <521F5C35.4040106@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54246 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699Ab3H2OgW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 10:36:22 -0400
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 29 August 2013 07:01 PM, Tomi Valkeinen wrote:
> Here's a series removing all the old panel model code from the omapdss driver.
> This series depends on the series that changes the board files to use the new
> panel drivers.
>
> There's nothing much special in this series, as it's mostly removing code that
> is not used. There are also related cleanups, like making functions static if
> they are no longer called from outside the file, and such.
>
> Tested on OMAP4 SDP, OMAP4 Panda, OMAP3 Beagle, OMAP3 Beagle xM.
>
> This series can also be found from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.12/dss-legacy-removal
>

For the series:

Reviewed-by: Archit Taneja <archit@ti.com>
Acked-by: Archit Taneja <archit@ti.com>

Thanks,
Archit

