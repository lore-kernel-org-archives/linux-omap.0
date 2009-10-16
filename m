From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [RFC][Patch V1] OMAP3: Mux Changes.
Date: Fri, 16 Oct 2009 07:20:45 -0700
Message-ID: <6cb013310910160720q1771ba1dnaaed266e9d2762da@mail.gmail.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAFFA9@dbde02.ent.ti.com>
	<4AD7FC40.406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f216.google.com ([209.85.217.216]:53236 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759144AbZJPOVn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 10:21:43 -0400
Received: by gxk8 with SMTP id 8so2231353gxk.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 07:21:05 -0700 (PDT)
In-Reply-To: <4AD7FC40.406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

On Thu, Oct 15, 2009 at 9:53 PM, Nishanth Menon <nm@ti.com> wrote:
>
> Pais, Allen had written, on 10/15/2009 11:53 PM, the following:
>>
>> a) A simple comment to all my comments: why cant we have these in bootloader and just simply leave the mux file alone?
>> [Allen] Yes Nishanth, this would be a much cleaner approach. Even Santosh had suggested
>> The same, if we can conclude on a approach here, I can go ahead and do the Mux Change it accordingly.
>
> Then lets please fix the bootloader and drop this patch.
>>
>> - Allen
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap- owner@vger.kernel.org] On Behalf Of Menon, Nishanth
>>> Sent: Thursday, October 15, 2009 7:24 AM
>>> To: Pais, Allen; Aguirre Rodriguez, Sergio Alberto; linux-omap
>
> Please try not to Top post. see [1]
>
> --
> Regards,
> Nishanth Menon
> Ref:
> [1] http://www.arm.linux.org.uk/mailinglists/etiquette.php#e3

Maybe I'm missing something, but why is it more desirable to add the
mux code to the bootloader instead of the kernel?  Wouldn't adding it
to the kernel guarantee it works regardless of the bootloader?

- Cory

(Repost for linux-omap -- gmail had html enabled the first itme)
