From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH V3 0/6] Add Display support for AM43xx
Date: Fri, 28 Mar 2014 15:08:26 +0530
Message-ID: <53354312.3020901@ti.com>
References: <1395658916-9032-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39954 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbaC1Jib (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 05:38:31 -0400
In-Reply-To: <1395658916-9032-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

On Monday 24 March 2014 04:31 PM, Sathya Prakash M R wrote:
> This patch series adds DSS support to the AM43x. The DPI LCD
> panel is supported on both am43x-epos-evm and am437x-gp-evm.
> The LCD panel is from OSD model: OSD057T0559-34TS
> 
> Version 1 of this series can be found below[1]:
> [1]: https://patchwork.kernel.org/patch/3274421/
> 
> Tested on am43x-epos-evm and am437x-gp-evm.
> 
> Dependent patches :
> Sourav patches adding device nodes for epos [2] and gp [3] evm
> [2]: https://patchwork.kernel.org/patch/3246701/
> [3]: https://patchwork.kernel.org/patch/3246751/
> 
> AM43xx has a dedicated display pll. Hence tomi patch improving
> func clock handling is needed [4]
> [4]: https://patchwork.kernel.org/patch/3196221/
> 
> Tomi patch adding DT support to DSS [5]
> [5]: https://patchwork.kernel.org/patch/3516341/

I think it will help to rebase the series to latest linux-next or Tomi's
-next branch since he has already committed a change to move fbdev
drivers to drivers/video/fbdev.

I tried giving this series a spin, but could not do so because of this.

Rest of the dependencies seem to be already present in linux-next so
there is good progress there.

Thanks,
Sekhar

