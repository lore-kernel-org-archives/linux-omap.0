From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] OMAP3: Zoom2: provide default MTD partitions
Date: Tue, 1 Sep 2009 12:34:26 +0530
Message-ID: <ce9ab5790909010004y67d3b29nf6ddc4532d390aef@mail.gmail.com>
References: <1251374386-6733-1-git-send-email-mpetazzoni@mvista.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F9A44CDF@dbde02.ent.ti.com>
	<20090827140617.GA30917@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f188.google.com ([209.85.211.188]:48051 "EHLO
	mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbZIAHEo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 03:04:44 -0400
Received: by ywh26 with SMTP id 26so7092309ywh.5
        for <linux-omap@vger.kernel.org>; Tue, 01 Sep 2009 00:04:46 -0700 (PDT)
In-Reply-To: <20090827140617.GA30917@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Petazzoni <mpetazzoni@mvista.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Singh, Vimal" <IMCEAEX-_O=TI_OU=BD_cn=Recipients_cn=x0094262@dlee86.itg.ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Rix, Tom" <trix@ti.com>

On Thu, Aug 27, 2009 at 7:36 PM, Maxime Petazzoni<mpetazzoni@mvista.com> wrote:
> Hi,
>
> * Pandita, Vikram <vikram.pandita@ti.com> [2009-08-27 19:16:27]:
>
>> Why?
>>
>> I know of an implementation by Vimal Singh that introduces a common
>> flash file for Zoom1 and Zoom2.
>> There is reuse of code there.
>
> Thanks for your comments.
>
> There are indeed other implentations around using a common flash file
> for Zoom1 and Zoom2 boards. I didn't know of this specific
> implementation by Vimal Singh, but we use something very similar
> internally.
>
> Since linux-omap didn't had any MTD partitions definitions for either
> boards, I decided to go for the smallest change: only partitions for
> Zoom2.
>
>> Please discuss and get a converged approach on handling NAND
>> partitions on Zoom1 and Zoom2.
>
> Agreed. We should use a common file for Zoom1 and Zoom2 flash, with
> Zoom2 specific partition sizes. But I'm not sure I deserve the right to
> propose Vimal Singh's patch (by the way, why hasn't it been merged in
> the linux-omap tree?). How should we proceed then?
>
>> Also the Systerm/User/Cache partition definitions are more from Android perspective.
>>
>> Given that each system may have a different NAND partition requirement,
>> have you looked at bootargs passing the MTD partition info: Eg:
>>
>> mtdparts=omap2-nand.0:512k@0(xloader),\
>> 1536k@512k(bootloader),\
>> 29m@2m(kernel),\
>> 160m@32m(system),\
>> 32m@192m(userdata),\
>> 32m@224m(cache)
>
> Yes, I am aware of the mtdparts command line arguments, which works
> great. I think a "default", sensible partition layout for the Zoom2
> would be nice though.

I agree. Keeping it in the mind that mtdparts command line arguments
will be given higher precedence anyway...

-vimal

>
> - Maxime
>
> --
> Maxime Petazzoni
> Linux kernel & software dev
> MontaVista Software, Inc
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkqWktkACgkQ7KsOe4Pmrg28zwCdHvKdX9NDgWVoUOx6Mc8kA6+7
> rx8An1NMQg5aEUHrEgGBZM/1YoFTvQtz
> =4L+0
> -----END PGP SIGNATURE-----
>
>



-- 
Regards,
Vimal Singh
