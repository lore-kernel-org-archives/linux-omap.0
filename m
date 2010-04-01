From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH v2] DSPBRIDGE: DSP recovery feature
Date: Wed, 31 Mar 2010 19:00:16 -0500
Message-ID: <4BB3E210.5070402@ti.com>
References: <AcrMYJFr1p3cmVYdQomG2hf1Av9JXw==>	 <496565EC904933469F292DDA3F1663E602CADC3396@dlee06.ent.ti.com> <94a0d4531003281629xe17d16dtcebba669c0a59f47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55520 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756567Ab0DAAA2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 20:00:28 -0400
In-Reply-To: <94a0d4531003281629xe17d16dtcebba669c0a59f47@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

On 3/28/2010 6:29 PM, Felipe Contreras wrote:
> On Fri, Mar 26, 2010 at 12:17 AM, Guzman Lugo, Fernando<x0095840@ti.com>  wrote:
>>
>> Patch updated with new O_NONBLOCK option in bridge_open function.
>>
>>
>>  From aa1b238e4bd30eb52a96a7000998cd7d32e37050 Mon Sep 17 00:00:00 2001
>> From: Fernando Guzman Lugo<x0095840@ti.com>
>> Date: Thu, 25 Mar 2010 15:23:38 -0600
>> Subject: [PATCH] DSPBRIDGE: DSP recovery feature
>>
>> This patch implements a workqueue in charge of reseting
>> DSP in case of fatal error.
>
> Tested-by: Felipe Contreras<felipe.contreras@nokia.com>
>

Pushed to dspbridge.

- omar
