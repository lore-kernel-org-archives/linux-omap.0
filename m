From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v11 00/10] [PATCH v10 00/10] mtd:nand:omap2: clean-up of
 supported ECC schemes
Date: Tue, 29 Oct 2013 23:59:57 -0400
Message-ID: <CAN8TOE_KQxW4-6KgjQDczyB31wmYB_y9Tirxa34GWQGgY39sNQ@mail.gmail.com>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
	<20131024135258.GC9958@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:42605 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab3J3D77 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Oct 2013 23:59:59 -0400
In-Reply-To: <20131024135258.GC9958@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Pekon Gupta <pekon@ti.com>, Mark Rutland <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, Artem Bityutskiy <dedekind1@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, "tony@atomide.com" <tony@atomide.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Avinash Philip <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, Rob Herring <robherring2@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>

On Thu, Oct 24, 2013 at 9:52 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Just as suggestion, I think you should reconsider your 'upstream strategy'.
>
> On Thu, Oct 24, 2013 at 06:20:16PM +0530, Pekon Gupta wrote:
> [..]
>>
>> Pekon Gupta (10):
>>   ARM: OMAP2+: cleaned-up DT support of various ECC schemes
>>   mtd: nand: omap: combine different flavours of 1-bit hamming ecc schemes
>>   mtd: nand: omap: cleanup: replace local references with generic framework names
>
> IMHO, this patch about the dobule nand_scan_ident():
>>   mtd: nand: omap: use DT specified bus-width only for scanning NAND device
>
> is a fix unrelated to this series and can be pushed independently.
> Maybe you can try to send it as a one-patch fix?
>
>>   mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in device_probe
>>   mtd: nand: omap: clean-up ecc layout for BCH ecc schemes
>>   mtd: nand: omap: use drivers/mtd/nand/nand_bch.c wrapper for BCH ECC instead of lib/bch.c
>>   ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
>
> And also this patch:
>>   mtd: nand: omap: updated devm_xx for all resource allocation and free calls
>
> doesn't seem to belong to this series.
>
> I think tou could send those two independently and ask Brian to merge them earlier
> if appropriate.
>
> But again, this is just a suggestion.

I agree with Ezequiel's thoughts, since the excessive amount of noise
in this patch series has delayed it significantly. But at this point,
I think it has stabilized; we have reviews from the DT folks (thanks
guys; please comment if you have an official "ack" to give), and I
think we've retained backwards compatibility properly; I've combed
through it a few times over the months; we have a third-party tester;
and at this point, I'm sure we're all sick of this.

So, without further delay: pushed all patches except path 8 to l2-mtd.git.

Tony, you mentioned the DTS update in patch 8 going in via an ARM
tree? This patch is not urgent, and it should probably wait until we
know what release the rest of the series makes it into. This may
depend on David Woodhouse's recommendation, but I'm not sure this
series will have enough time baking in linux-next before entering
mainline in 3.13 (the merge window is approaching).

Pekon/Ezequiel/others: please feel free to send any follow up cleanups
for this driver. I'll take a look at what Ezequiel has already sent
out and see if it's still applicable on top.

Thanks,
Brian
