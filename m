From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: OMAP3 NAND ECC selection
Date: Thu, 5 Dec 2013 18:39:10 +0100
Message-ID: <CABxcv=mtqkpyup0y-zv53YRvdgKH0bNXeCWf9mxPFoUTRQ=Gew@mail.gmail.com>
References: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net>
	<CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com>
	<52A04E75.3010609@corscience.de>
	<alpine.DEB.2.01.1312051711410.20976@pmeerw.net>
	<20131205171326.GA26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:46949 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756771Ab3LERjM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 12:39:12 -0500
Received: by mail-we0-f179.google.com with SMTP id q59so16666835wes.24
        for <linux-omap@vger.kernel.org>; Thu, 05 Dec 2013 09:39:10 -0800 (PST)
In-Reply-To: <20131205171326.GA26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Gupta, Pekon" <pekon@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, =?UTF-8?Q?Andreas_Bie=C3=9Fmann?= <andreas.biessmann@corscience.de>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-mtd@lists.infradead.org

[adding Pekon and Thomas as cc]

On Thu, Dec 5, 2013 at 6:13 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Peter Meerwald <pmeerw@pmeerw.net> [131205 08:13]:
>> > >> I'd like to be able to update MLO and u-boot from within a booted Linux
>> > >> system on the device (I have to resort to u-boot for that where I can
>> > >> control the ECC scheme used)
>>
>> > > Meanwhile, to do this we use a small userspace program created by
>> > > Javier Martinez in order to flash the MLO in our OMAP3 boards. See
>> > > http://git.isee.biz/?p=pub/scm/writeloader.git;a=summary
>>
>> > we used another aproach here. See
>> > http://article.gmane.org/gmane.linux.drivers.mtd/43804
>>
>> pretty much what I have been looking for, thanks!
>
> Hmm well both methods should work, but is there anything stopping us
> merging the module param patch to the mainline tree?
>

Hi Tony,

In the another thread [0] pointed out by Enric we were discussing the
same issue. Thomas suggested [1] that ideally we should be able to set
a per MTD partition ECC scheme. That way we can set 1 bit hamming for
the first MTD partition that has the SPL that the boot ROM needs to
read and the other partitions can use a more secure ECC scheme. I
completely agree with him.

In fact the data-sheet for the NAND device used on the IGEPv2 board says:

"Minimum required ECC 4-bit ECC per 528 bytes || Minimum required ECC
for block 0  1-bit ECC per 528 byte"

so I don't think we should impose a software limitation by having a
global ECC scheme and we should expand the GPMC NAND DT binding so
partitions support the "ti,nand-ecc-opt". I'll see if I can get some
free time to try to implement that.

Pekon does not agree with this solution though [2]

Thanks a lot and best regards,
Javier

[0]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg98969.html
[1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg99008.html
[2]: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108136
