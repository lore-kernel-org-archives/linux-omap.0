From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: user space program for omap gpio
Date: Tue, 3 Jun 2008 07:35:38 -0400
Message-ID: <a0580c510806030435o506a04f1k4a0267a02cba98b2@mail.gmail.com>
References: <a1d91fa0806020958p21d289edrf2c63c8333af9bd4@mail.gmail.com>
	 <20080602174456.GB4964@kedavra.cpe.vivax.com.br>
	 <a1d91fa0806030251w27a36bb3u62cd925845817efa@mail.gmail.com>
	 <39d10518297acafea1e95228ee125562@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:43142 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbYFCLfj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 07:35:39 -0400
Received: by wa-out-1112.google.com with SMTP id j37so817698waf.23
        for <linux-omap@vger.kernel.org>; Tue, 03 Jun 2008 04:35:38 -0700 (PDT)
In-Reply-To: <39d10518297acafea1e95228ee125562@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: mohammed shareef <mdshareef@gmail.com>, omap <linux-omap@vger.kernel.org>

Hi Felipe,

Actually, David Brownell is working on something very similar. sysfs
for gpio lib.

http://kerneltrap.org/mailarchive/linux-kernel/2008/4/28/1640134

That'd be really useful indeed.

But  I believe it is not merged yet.

My 2 cents.

Cheers,

On Tue, Jun 3, 2008 at 7:19 AM, Felipe Balbi <me@felipebalbi.com> wrote:
>
>
> On Tue, 3 Jun 2008 15:21:02 +0530, "mohammed shareef" <mdshareef@gmail.com>
> wrote:
>> Hi Felipe,
>>
>> could you give me some useful pointers on how to use the gpio-switch
>> and ioctl to read and write gpio?
>
> gpio-switch you can check in arch/arm/mach-omap2/board-n800.c
>
> about using ioctls for controlling the gpio, you'll have to write
> a module from scratch. afaict, there's no way of controlling gpio
> from userland. Besides gpiofs that a friend was writing and never
> finished :-p
>
> I'll try to reach him and ask him to send as RFC cuz it was a good
> work anyway :-)
>
> --
> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Eduardo Bezerra Valentin
