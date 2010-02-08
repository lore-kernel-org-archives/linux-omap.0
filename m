From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/3] DSPBRIDGE: Get rid of MEM_CHECK mechanism
Date: Mon, 8 Feb 2010 16:47:49 -0600
Message-ID: <4B709495.8010401@ti.com>
References: <cover.1265296743.git.ameya.palande@nokia.com>  <5fd56ce70a150d5ff6711689dca84d932e4c9eca.1265296743.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54367 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab0BHWrw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Feb 2010 17:47:52 -0500
In-Reply-To: <5fd56ce70a150d5ff6711689dca84d932e4c9eca.1265296743.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

On 2/4/2010 9:33 AM, Ameya Palande wrote:
> kmemleak offeres the same functionality as custom MEM_CHECK
> mechanism, so get rid of MEM_CHECK.
>
> Signed-off-by: Ameya Palande<ameya.palande@nokia.com>
> ---
>   drivers/dsp/bridge/services/mem.c |  212 +------------------------------------
>   1 files changed, 2 insertions(+), 210 deletions(-)
>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge.

- omar
