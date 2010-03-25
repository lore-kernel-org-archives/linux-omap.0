From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/3] DSPBRIDGE: fix checkpatch error introduced with mailbox
 patches
Date: Thu, 25 Mar 2010 12:36:45 -0500
Message-ID: <4BAB9F2D.9060102@ti.com>
References: <1269384510-1526-1-git-send-email-omar.ramirez@ti.com> <1269384510-1526-2-git-send-email-omar.ramirez@ti.com> <4BAA63C9.1020104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41260 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588Ab0CYRgs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Mar 2010 13:36:48 -0400
In-Reply-To: <4BAA63C9.1020104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

On 3/24/2010 2:11 PM, Chitriki Rudramuni, Deepak wrote:
> Omar Ramirez Luna wrote:
>> This fixes:
>> ERROR: "foo* bar" should be "foo *bar"
>> 218: FILE: drivers/dsp/bridge/wmd/_tiomap.h:374:
>> +dsp_status sm_interrupt_dsp(struct wmd_dev_context* dev_context, u16 mb_val);
>>
>> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
[...]
> Acked-by: Deepak Chitriki<deepak.chitriki@ti.com>
>

Pushed to dspbridge.

- Omar

