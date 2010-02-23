From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 3/4] DSPBRIDGE: Fix memory corruption in DRV_ProcFreeDMMRes
Date: Tue, 23 Feb 2010 10:23:53 -0600
Message-ID: <4B840119.10407@ti.com>
References: <cover.1266503387.git.ameya.palande@nokia.com>  <9fb63d8737768758ac367ff242c4142f38ce7427.1266503387.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33640 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab0BWQX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 11:23:58 -0500
In-Reply-To: <9fb63d8737768758ac367ff242c4142f38ce7427.1266503387.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

On 2/18/2010 8:40 AM, Ameya Palande wrote:
> This patch fixes following issues:
>
> 1. pDMMRes was dereferenced and modified when it was already freed by
>     PROC_Ummap(). This results in memory corruption.
>
> 2. Instead of passing ulDSPAddr, ulDSPResAddr was passed to PROC_UnMap()
>     which will not retrieve correct DMMRes element.
>
> Signed-off-by: Ameya Palande<ameya.palande@nokia.com>
> Signed-off-by: Felipe Contreras<felipe.contreras@nokia.com>
> ---
>   drivers/dsp/bridge/rmgr/drv.c |   12 ++----------
>   1 files changed, 2 insertions(+), 10 deletions(-)
>

Pushed to dspbridge

- omar
