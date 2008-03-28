From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] i2c: tea5761: New-style i2c driver
Date: Fri, 28 Mar 2008 08:04:08 -0400
Message-ID: <1206705849-9645-1-git-send-email-edubezval@gmail.com>
References: <20080328133820.5a35eca0.jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39740 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbYC1MEQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 08:04:16 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2SC3nAj023108
	for <linux-omap@vger.kernel.org>; Fri, 28 Mar 2008 14:04:13 +0200
In-Reply-To: <20080328133820.5a35eca0.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Jarkko,

Thanks for the review.

>On Thu, 27 Mar 2008 11:31:20 -0400
>"ext Eduardo Valentin" <edubezval@gmail.com> wrote:
>
>> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
>> 
>> This patch updates the fm radio driver for tea5761 chip.
>> It also moves board dependent code to its correct board
>> file place.
>> 
>Good move forward!
>
>Any plans to send this driver with Kconfig & Makefile modifications to
>relevant V4L etc mailing list?

Yes, I can send them to V4L2 mailing list after we have them in a good shape.

>
>Note there are three minor warnings if you run your patch with
>scripts/checkpatch.pl.

Yes, thanks. I'm sending an updated version.

>
>You could also remove these two headers files below since they are not
>needed anymore.

Already done in this new version.

>
>> diff --git a/drivers/media/radio/radio-tea5761.c
>> b/drivers/media/radio/radio-tea5761.c index ac0f621..2341e66 100644
>> --- a/drivers/media/radio/radio-tea5761.c
>> +++ b/drivers/media/radio/radio-tea5761.c
>@@ -23,8 +23,8 @@
> #include <linux/i2c.h>
> #include <linux/delay.h>
> #include <media/v4l2-common.h>
>-#include <asm/arch/gpio.h>
>-#include <asm/arch/board.h>
>
>
>-- 
>Jarkko

Cheers,

Eduardo Valentin


