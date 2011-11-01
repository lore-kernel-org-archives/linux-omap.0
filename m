From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: DaVinci NAND writing utility release, was: RE: [RFC] Change ECC
 algorithm from userspace
Date: Tue, 1 Nov 2011 11:34:53 +0100
Message-ID: <CAAwP0s2xeh6Bn0u-VmVsy=fo0UHo9ZGo8ps7zDWoJxU-Z75JSg@mail.gmail.com>
References: <CAAwP0s0TzB2iFzYkjAsN6q-YA9d0MEd7ViOd-UUvbMf_11q8gw@mail.gmail.com>
 <70E876B0EA86DD4BAF101844BC814DFE0BF244FEEE@Cloud.RL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61942 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab1KAKfP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Nov 2011 06:35:15 -0400
Received: by gyb13 with SMTP id 13so6882480gyb.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Nov 2011 03:35:14 -0700 (PDT)
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE0BF244FEEE@Cloud.RL.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Povey <Jon.Povey@racelogic.co.uk>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, dlos <davinci-linux-open-source@linux.davincidsp.com>

On Tue, Nov 1, 2011 at 5:18 AM, Jon Povey <Jon.Povey@racelogic.co.uk> w=
rote:
> Adding davinci linux open source ML to CC as folk there might find th=
is
> utility useful.
>
> Javier Martinez Canillas wrote:
>> On Fri, Oct 28, 2011 at 12:33 PM, Jon Povey
>> <Jon.Povey@racelogic.co.uk> wrote:
>>> linux-mtd-bounces@lists.infradead.org wrote:
>>> DM355 and DM365 has similar issues as the RBL expects a different
>>> OOB/ECC layout to Linux.
>>>
>>> What I have done is write a utility that calculates ECC and writes =
to
>>> the mtd device in RAW mode. So to rewrite the bootloader I take car=
e
>>> of the ECC and layout at application level without changing the
>>> kernel.
>
>> Is your utility publicly available? It would be great if I can use i=
t
>> as an starting point.
>
> Management have given the thumbs-up, this is now released under GPL v=
2
> at https://github.com/jonpovey/flashtool
>
> Supports DM355 and DM365 RBL layouts, ECC generation, UBI image writi=
ng,
> and various bad block / range handling.
>
> Enjoy!
>
> --

Hi Jon, thanks for sharing your tool!

Today is holiday in Spain and I don't have proper hardware to test.
But tomorrow I will definitely give a try.

Thanks a lot and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
