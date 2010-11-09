From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: Mistral AM37x (with AM3715) devel board networking broken
Date: Tue, 9 Nov 2010 10:32:20 +0530
Message-ID: <AANLkTimwkLX2_WcfYYXA3QY1mPsKxbHAWmamWZLw3TUO@mail.gmail.com>
References: <E1PFgDD-0002jm-KX@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:32933 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750727Ab0KIFCm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Nov 2010 00:02:42 -0500
Received: by wyf19 with SMTP id 19so3297512wyf.35
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 21:02:41 -0800 (PST)
In-Reply-To: <E1PFgDD-0002jm-KX@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: linux-omap@vger.kernel.org, premi@ti.com

On Tue, Nov 9, 2010 at 10:23 AM, Rick Bronson <rick@efn.org> wrote:
> Hi Sanjeev,
>
> =A0Thanks much for the help.
>
>> I tried building the latest on l-o master and was able to boot consi=
stently
>> in 4 times I tried. Didn't notice the gpio clock related error I not=
iced in
>> your boot log.
>>
>>
>> U-Boot 2010.09 (Nov 08 2010 - 17:11:45)
>>
>> OMAP3630/3730-GP ES2.0, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
>> OMAP3 EVM board + LPDDR/NAND
>
> =A0Note that mine is ES1.0 (yours is ES2.0):
>
> OMAP3630/3730-GP ES1.0, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
>
> =A0Not sure if that's any clue.
>

That's interesting - there shouldn't b e an ES2.0 of the 3630/3730. The=
 highest
revision is an ES1.2.

> =A0Tonight I got the latest stuff:
>
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-=
omap-2.6.git
>
> =A0and built it up with:
>
> make omap2plus_defconfig ARCH=3Darm
>
> =A0And got this
>
> http://www.efn.org/~rick/pub/boot6.log
>
> =A0It's basically the same, I get the 3 warnings and sometimes eth0 w=
orks
> and sometimes it doesn't. =A0Note that my board works flawlessly with
> the kernel on the SD Card.
>
> =A0What compiler are you using? =A0I tried CodeSourcery
> 2009q1 and 2010q1 with the same results.
>
> =A0How did you configure your u-boot?
>
> =A0Could you send me your boot up text? =A0Could you send me your
> u-boot.bin (and or your uImage) so I can try it? =A0I might help me
> figure out what's going on.
>
> =A0Thanks again.
>
> =A0Rick
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
