From: John Garland <johnnyg@cse.unsw.edu.au>
Subject: Re: Hang on boot
Date: Mon, 11 Oct 2010 22:35:19 +1100
Message-ID: <AANLkTimzCZrd4XH5fW7rWvio84nY3wWO23nQockU_5Mf@mail.gmail.com>
References: <AANLkTiknOwhUJny9WcYxROic+SP1eOcUmqbG7Kh9pPDY@mail.gmail.com> <1286780104.10205.32.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:45899 "EHLO
	note.orchestra.cse.unsw.EDU.AU" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852Ab0JKLfr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Oct 2010 07:35:47 -0400
Received: From
	mail-wy0-f174.google.com ([74.125.82.174]) (auth-user johnnyg) (cse-authentic-sender johnnyg)
	(for <linux-omap@vger.kernel.org>) By note With Smtp ;
	Mon, 11 Oct 2010 22:35:44 +1100
Received: by wye20 with SMTP id 20so356804wye.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 04:35:40 -0700 (PDT)
In-Reply-To: <1286780104.10205.32.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: linux-omap@vger.kernel.org

On 11 October 2010 17:55, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
> Hi,
>
> On Mon, 2010-10-11 at 14:09 +1100, John Garland wrote:
>> Hi,
>>
>> Both the dspbridge and master branch of linux-omap seem to hang when
>> trying to boot (i.e. no output) on a beagleboard C2.
>> This is with the new omap2plus_defconfig (as opposed to the old
>> omap3_defconfig).
>>
>> Is anybody else experiencing this or does anyone have any idea what
>> could be causing this?
>>
>
> Make sure you update your u-boot environment so that you have
> console=ttyO2,115200 in your kernel command line (btw, it's ttyO2, not
> tty02). It's been recently changed in the linux-omap tree (commit
> d6e284d).
>
> You'll probably also need to update your /etc/inittab.
>
> Cheers,
> Ionut.
>
>
>

You're a champ, that was the problem.

Cheers,
John.
