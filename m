From: "Girish S G" <girishsg@ti.com>
Subject: Re: Problem in McSPI (TXS timed out)
Date: Mon, 11 Aug 2008 10:48:27 +0530
Message-ID: <002101c8fb72$1380f0c0$LocalHost@wipultra1376>
References: <ca6476860808102100o1f63af04y426c68a9be8e1b29@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:58738 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbYHKFV1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Aug 2008 01:21:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: halli manjunatha <hallimanju@gmail.com>, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "halli manjunatha" <hallimanju@gmail.com>
To: <linux-omap@vger.kernel.org>
Sent: Monday, August 11, 2008 9:30 AM
Subject: Problem in McSPI (TXS timed out)


> Hello All,
>              I am working on OMAP3430 with 2.6.24 kernel, In that i
> am using McSPI2 for initializing the LCD and serializer, but while
> booting am getting the following messages
>
> In mcspi wakeup callback
> display spi2.0: TXS timed out
> In mcspi wakeup callback

Check the pin mux of  SPI2 including i/p enable bit. Can you dump what configuration you have set to SPI2?

Regards,
Girish



