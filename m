From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: logic error fix for SleepDSP timeout value
Date: Tue, 23 Feb 2010 20:11:02 -0600
Message-ID: <4B848AB6.7050308@ti.com>
References: <1266530134-8186-1-git-send-email-omar.ramirez@ti.com> <1266530134-8186-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55251 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab0BXCLI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 21:11:08 -0500
In-Reply-To: <1266530134-8186-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On 2/18/2010 3:55 PM, Ramirez Luna, Omar wrote:
> When leaving the loop waiting for the dsp to transition
> from its power state, timeout value will be negative, therefore
> a print for "timeout waiting for the dsp" won't be displayed, as
> the condition to check for is !timeout.
>
> Reported-by: Berenice Herrera<berenice@ti.com>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---
>   drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>

Pushed to dspbridge

- omar
