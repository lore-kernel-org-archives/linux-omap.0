From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix declaration and initialization of sync
 objects.
Date: Wed, 21 Apr 2010 14:50:33 -0500
Message-ID: <4BCF5709.8010702@ti.com>
References: <496565EC904933469F292DDA3F1663E602CB215E41@dlee06.ent.ti.com> <4BCCE02D.6080407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52476 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756233Ab0DUTuj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Apr 2010 15:50:39 -0400
In-Reply-To: <4BCCE02D.6080407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

On 4/19/2010 5:58 PM, Chitriki Rudramuni, Deepak wrote:
> Guzman Lugo, Fernando wrote:
>>  From 2edd80839e6d3bbe6e92914c3097a6dedca23784 Mon Sep 17 00:00:00 2001
>> From: Fernando Guzman Lugo<x0095840@ti.com>
>> Date: Sun, 18 Apr 2010 00:32:01 -0500
>> Subject: [PATCH] DSPBRIDGE: Fix declaration and initialization of sync objects.
>>
>> This patch fixes declaration of completions for sync in
>> drv_interface and also initialize sync->done object in
>> msg_sm.c
>>
>> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>
[...]
> Acked-by: Deepak Chitriki<deepak.chitriki@ti.com>
>
> Deepak

Pushed to dspbridge

- omar
