From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 00/14]: ARM: OMAP2: clock DT conversion
Date: Mon, 19 May 2014 17:21:43 +0300
Message-ID: <537A1377.7070004@ti.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42301 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbaESOV0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 10:21:26 -0400
In-Reply-To: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, mturquette@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 03/04/2014 11:18 AM, Tero Kristo wrote:
> Hi,
>
> Changes compared to v1:
> - fixed OMAP2 only build issues
> - fixed OMAP2420 boot issues
> - added patch #13 and #14 to remove legacy clock data for OMAP2/OMAP3
> - fixed smatch + DT bindings documentation problems reported by Nishanth
>
> This set is un-tested on OMAP2 hardware as I don't have access to any. So,
> any testing feedback welcome.
>
> Test branch available:
> tree: https://github.com/t-kristo/linux-pm.git
> branch: 3.14-rc4-omap2-dt-clks-v2

I just queued these for 3.16/ti-clk-drv.

-Tero

>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

