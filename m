From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 3/3] DSPBRIDGE: Get rid of MEM_VFree()
Date: Mon, 8 Feb 2010 16:47:59 -0600
Message-ID: <4B70949F.20306@ti.com>
References: <cover.1265296743.git.ameya.palande@nokia.com>  <ad25763f4a3358893208d591f5a055ac6f8c85ea.1265296743.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53023 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab0BHWsD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Feb 2010 17:48:03 -0500
In-Reply-To: <ad25763f4a3358893208d591f5a055ac6f8c85ea.1265296743.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

On 2/4/2010 9:33 AM, Ameya Palande wrote:
> vfree() is NULL safe so MEM_VFree() doesn't provide any significant
> advantage. By getting rid of MEM_VFree() and the NULL pointer check
> associated with it, we can save on:
> 1. One level of indirection which translates to a function call cost.
> 2. NULL pointer checking cost.
>
> Signed-off-by: Ameya Palande<ameya.palande@nokia.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/mem.h |   17 -----------------
>   drivers/dsp/bridge/pmgr/dmm.c              |    3 +--
>   drivers/dsp/bridge/services/mem.c          |   17 -----------------
>   3 files changed, 1 insertions(+), 36 deletions(-)
>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge.

- omar
