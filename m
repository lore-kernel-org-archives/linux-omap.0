From: "Lesly AM" <x0080970@ti.com>
Subject: Re: Labrador OMAP 3430 problem
Date: Fri, 11 Sep 2009 19:38:36 +0530
Message-ID: <0cbe01ca32e9$5bf40d10$LocalHost@wipultra1385>
References: <d9ca78710909110654r7e9cb0ffmb65311645b0789d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59600 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbZIKOIh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Sep 2009 10:08:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tar Gz <bsdraisefromhell@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Seems like you were using nand boot, and you erased the loader & U-Boot on 
NAND.

Can you try to boot from MMC card. (copy X-loader and U-Boot to MMC card)

Regards,
Lesly AM

----- Original Message ----- 
From: "Tar Gz" <bsdraisefromhell@gmail.com>
To: "linux-omap" <linux-omap@vger.kernel.org>
Sent: Friday, September 11, 2009 7:24 PM
Subject: Labrador OMAP 3430 problem


>i have problem with my labrador board, after i using nand erase and
> i'm restart my board..my board can't show anything in hyperterminal
> nad the BT indicator(blue led) still on....any idea?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> 

