From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: MMU-Fault debugging enhancements
Date: Fri, 30 Apr 2010 14:24:15 -0500
Message-ID: <C161915E2DD8304FAAE595A13B0A0948024AE50D98@dlee01.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CB04896F@dlee06.ent.ti.com>
 <x2y94a0d4531004300821v920d3240p5215a967c6c48759@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35049 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759367Ab0D3TYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 15:24:23 -0400
In-Reply-To: <x2y94a0d4531004300821v920d3240p5215a967c6c48759@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

Hi,

>-----Original Message-----
>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>Sent: Friday, April 30, 2010 10:21 AM
>To: Guzman Lugo, Fernando; Ramos Falcon, Ernesto
>Cc: linux-omap@vger.kernel.org; Hiroshi DOYU; Ameya Palande;
>felipe.contreras@nokia.com
>Subject: Re: [PATCH] DSPBRIDGE: MMU-Fault debugging enhancements
>
>On Fri, Apr 9, 2010 at 3:15 AM, Guzman Lugo, Fernando <x0095840@ti.com>
>wrote:
>> From db3d76a2e89a1c227322a2732ddf7ebf5cd4b4cf Mon Sep 17 00:00:00 2001
>> From: Ernesto Ramos <ernesto@ti.com>
>> Date: Wed, 24 Mar 2010 11:12:05 -0600
>> Subject: [PATCH] DSPBRIDGE: MMU-Fault debugging enhancements
>>
>> These changes allow for DSP task information to be printed
>> by the MPU dspbridge when DSP MMU fault ocurrs.
>>
>> Signed-off-by: Cris Jansson <cjansson@ti.com>
>> [change to open source coding style]
>> Signed-off-by: Ernesto Ramos <ernesto@ti.com>
>
>This patch seems to be doing a lot of things. Couldn't it have been split?
>
>Also, from the commit message it seems to implement a new feature,
>however, I heard it's supposed to fix memory corruption too. Is that
>true? If that's the case the code that fixes that would have to be
>separate.
>
>I understand this patch was already pushed to dspbridge branch, but I
>think such important changes should be properly recorded in the
>history.
>
>Cheers.
>

Hi Felipe,
I agree important changes must be properly recorded but in this case the patch introduces only one new feature and because of the way that it is implemented using gpt8 overflow interrupt instead of mailbox to inform about the MMU Fault, the problem of the memory corruption was fixed indirectly, however these changes are part of the feature design itself and I don't see the need to split this new feature.

Saludos,
Ernesto

>--
>Felipe Contreras