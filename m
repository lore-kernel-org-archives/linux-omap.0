From: <Mikko.K.Ylinen@nokia.com>
Subject: RE: twl4030-madc conversions always time out
Date: Mon, 11 May 2009 09:17:11 +0200
Message-ID: <697A7C5C820BFF44B6906324D764CE010C93110B46@NOK-EUMSG-05.mgdnok.nokia.com>
References: <5a7b8b7b0905101914g7bef0069n812421454fac3419@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58912 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbZEKHRq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 03:17:46 -0400
In-Reply-To: <5a7b8b7b0905101914g7bef0069n812421454fac3419@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hugo.vincent@gmail.com, linux-omap@vger.kernel.org, gumstix-users@lists.sourceforge.net

Hi, 

>-----Original Message-----
>From: Hugo Vincent
>Sent: 11 May, 2009 05:15
>
>It seems that the TWL4030_MADC_BUSY bit gets set and never 
>cleared (as in the aforementioned nabble thread).
>
>Any ideas?

I believe Overo board has sysclk other than 26MHz. Please check
GPBR1 register settings for MADC_HFCLK_EN and DEFAULT_MADC_CLK_EN
bits.

Those bits should be configured *before* sysclk is set in CFG_BOOT.

-- 
Regards, Mikko