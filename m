From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 3/3] DSPBRIDGE: auto select mailbox when compiling bridge
Date: Thu, 25 Mar 2010 12:37:27 -0500
Message-ID: <4BAB9F57.9070706@ti.com>
References: <1269384510-1526-1-git-send-email-omar.ramirez@ti.com> <1269384510-1526-2-git-send-email-omar.ramirez@ti.com> <1269384510-1526-3-git-send-email-omar.ramirez@ti.com> <1269384510-1526-4-git-send-email-omar.ramirez@ti.com> <4BAA642C.8070500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41307 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646Ab0CYRhc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Mar 2010 13:37:32 -0400
In-Reply-To: <4BAA642C.8070500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

On 3/24/2010 2:12 PM, Chitriki Rudramuni, Deepak wrote:
> Omar Ramirez Luna wrote:
>> Auto select mailbox when compiling bridgedriver.
>>
>> If selected as module, first install:
>> arch/arm/plat-omap/mailbox.ko
>> arch/arm/mach-omap2/mailbox_mach.ko
>>
>> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com
[...]
> Acked-by: Deepak Chitriki<deepak.chitriki@ti.com>
>

Pushed to dspbridge.

- Omar
