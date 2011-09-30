From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/6] OMAP4460: Clock: Adding support for 4460 specific
 clocks
Date: Thu, 29 Sep 2011 19:12:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109291911390.26728@utopia.booyaka.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com> <1316705361-12175-7-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42723 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756749Ab1I3BM1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Sep 2011 21:12:27 -0400
In-Reply-To: <1316705361-12175-7-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, Vishwanath BS <vishwanath.bs@ti.com>

Hi

On Thu, 22 Sep 2011, Keerthy wrote:

> From: Vishwanath BS <vishwanath.bs@ti.com>
> 
> OMAP4460 specific clocks are not getting added as the
> cpu_is_omap44xx is choosing only OMAP4430 specific clock nodes.
> Changing it to add to OMAP4460 specific clocks also.
> This is clocks are required of temperature sensor.
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Cc: paul@pwsan.com 

Thanks, this patch has been queued for 3.2.


- Paul
