From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Re: Labrador OMAP 3430 problem
Date: Fri, 11 Sep 2009 21:40:16 +0700
Message-ID: <d9ca78710909110740v5ae4d18dl8bda5ae094f4a3bb@mail.gmail.com>
References: <d9ca78710909110654r7e9cb0ffmb65311645b0789d9@mail.gmail.com>
	 <0cbe01ca32e9$5bf40d10$LocalHost@wipultra1385>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f176.google.com ([209.85.210.176]:49323 "EHLO
	mail-yx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbZIKOkN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 10:40:13 -0400
Received: by yxe6 with SMTP id 6so1576086yxe.22
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 07:40:16 -0700 (PDT)
In-Reply-To: <0cbe01ca32e9$5bf40d10$LocalHost@wipultra1385>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly AM <x0080970@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

i solve the problem...thanks a lot

On 9/11/09, Lesly AM <x0080970@ti.com> wrote:
> Seems like you were using nand boot, and you erased the loader & U-Boot on
> NAND.
>
> Can you try to boot from MMC card. (copy X-loader and U-Boot to MMC card)
>
> Regards,
> Lesly AM
>
> ----- Original Message -----
> From: "Tar Gz" <bsdraisefromhell@gmail.com>
> To: "linux-omap" <linux-omap@vger.kernel.org>
> Sent: Friday, September 11, 2009 7:24 PM
> Subject: Labrador OMAP 3430 problem
>
>
>>i have problem with my labrador board, after i using nand erase and
>> i'm restart my board..my board can't show anything in hyperterminal
>> nad the BT indicator(blue led) still on....any idea?
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
>
