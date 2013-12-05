From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: OMAP3 NAND ECC selection
Date: Thu, 5 Dec 2013 11:13:54 -0800
Message-ID: <CAN8TOE9qG2-RRPKgP2t_vCAnV4Lp4AjLdtGuc+ROMveaPny1UA@mail.gmail.com>
References: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net>
	<CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com>
	<52A04E75.3010609@corscience.de>
	<alpine.DEB.2.01.1312051711410.20976@pmeerw.net>
	<20131205171326.GA26766@atomide.com>
	<CABxcv=mtqkpyup0y-zv53YRvdgKH0bNXeCWf9mxPFoUTRQ=Gew@mail.gmail.com>
	<20131205182628.GF2345@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:49902 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab3LETNz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 14:13:55 -0500
Received: by mail-vc0-f172.google.com with SMTP id hz11so13609925vcb.3
        for <linux-omap@vger.kernel.org>; Thu, 05 Dec 2013 11:13:55 -0800 (PST)
In-Reply-To: <20131205182628.GF2345@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, "Gupta, Pekon" <pekon@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?ISO-8859-1?Q?Andreas_Bie=DFmann?= <andreas.biessmann@corscience.de>, Peter Meerwald <pmeerw@pmeerw.net>

On Thu, Dec 5, 2013 at 10:26 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> (CCing Brian: What do you think about this?)
>
> On Thu, Dec 05, 2013 at 06:39:10PM +0100, Javier Martinez Canillas wrote:
>> On Thu, Dec 5, 2013 at 6:13 PM, Tony Lindgren <tony@atomide.com> wrote:
>>
>> In the another thread [0] pointed out by Enric we were discussing the
>> same issue. Thomas suggested [1] that ideally we should be able to set
>> a per MTD partition ECC scheme. That way we can set 1 bit hamming for
>> the first MTD partition that has the SPL that the boot ROM needs to
>> read and the other partitions can use a more secure ECC scheme. I
>> completely agree with him.
>>
> [..]
>> global ECC scheme and we should expand the GPMC NAND DT binding so
>> partitions support the "ti,nand-ecc-opt". I'll see if I can get some
>> free time to try to implement that.
>>
>
> AFAIK, there's no hardware limitation that would prevent us from setting
> a per-partition ECC, keep in mind this effort is not reduced to make
> devicetree accept ECC on the partitions.
>
> While there are some per MTD device (which model each partition), the
> ECC mode is present in the, nand_chip structure. My understanding is that
> the NAND core hasn't been designed for this use case, and thus some
> major re-work is needed to accomplish it.

Yes, it looks like a lot of work for little benefit. IMO, the *right*
thing to do is have the bootloader use a sufficiently strong ECC for
the flash part, so you don't have to configure different strengths for
different partitions. But I'll concede that it may be *nice* to have
flexibility in some cases.

Part of the difficulty is in making this generic for all types of NAND
drivers. On some, you can simply change some high-level software
parameters to use a different ECC mode, while others may require hooks
for controlling hardware parameters. And switching this at runtime can
end up being a lot of work, since a sequence of reads/writes
alternating between two differently-configured partitions would rapid
reconfiguration of the ECC controller, which previously only needed
configured at module initialization time. It may be doable, but to
commit to this approach, you must do a lot of work.

Also, this requires major changes to the MTD framework. Right now, I
believe MTD partitions are a very small shim layer, where the bulk of
the MTD transactions are filtered through to the parent "master" MTD.

> Therefore, it's a much short-term solution to implement the OMAP
> module parameter to fix the issue.

That's possible, but even there, I don't see what the real benefit is.
If you only need special-case solutions (which it seems like this use
case is) for updating bootloader data, can't a simple 1-bit ECC
user-space tool (like the one you linked earlier) suffice? It seems
like it's only a small convenience to place this flexibility in a
module parameter, but it is much *less* generic; what if someone
builds omap2 into the kernel (not as a module)? So the user-space tool
seems superior in many cases.

Brian
