From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] omap: 3630: update is_chip variable
Date: Tue, 3 Nov 2009 00:36:00 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA36FBC6@dbde02.ent.ti.com>
References: <1255989491-27088-1-git-send-email-vikram.pandita@ti.com>
 <71a0d6ff0911020905u7879b332x53d01f43b5888307@mail.gmail.com>
 <20091102182831.GD15200@shisha.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52927 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480AbZKBTGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 14:06:04 -0500
In-Reply-To: <20091102182831.GD15200@shisha.kicks-ass.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>, "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: Alexander Shishkin [mailto:virtuoso@slind.org]
>Sent: Monday, November 02, 2009 12:29 PM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org; Menon, Nishanth
>Subject: Re: [PATCH] omap: 3630: update is_chip variable
>
>On Mon, Nov 02, 2009 at 07:05:49PM +0200, Alexander Shishkin wrote:
>> 2009/10/20 Vikram Pandita <vikram.pandita@ti.com>:
>> > 3630 is getting treated like next rev of 3430
>> > omap_chip.oc variable has to be updated for 3630 version
>> >
>> > Otherwise the Core power domain is not getting registered.
>> >
>> > This gets used in the registration of power domains in:
>> > "arch/arm/mach-omap2/powerdomains34xx.h"
>> > core_34xx_es3_1_pwrdm
>> > OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1)
>> >
>> > Core power doman will get registered for 3630 only when .oc is pouplated
>> > correctly.
>> >
>> > Tested on Zoom3(3630) board
>> >
>> > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> FWIW,
>>
>> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
>
>Please excuse me, I obviously wanted to say
>
>Acked-by: Alexander Shishkin <virtuoso@slind.org>

Posting Ver 3 of the patch as the current 
patch [1] does not apply because of header file changes.


Regards,
Vikram 
[1] http://patchwork.kernel.org/patch/54847/


>
>Regards,
>--
>Alex

