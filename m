From: Tom Rini <trini@ti.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain backward
 compatibility.
Date: Mon, 2 Dec 2013 12:25:20 -0500
Message-ID: <529CC280.5040703@ti.com>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com> <CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com> <20131202115422.1f8c73f6@skate> <CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com> <20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com> <20131202160219.40286dc9@skate> <20980858CB6D3A4BAE95CA194937D5E73EA5099E@DBDE04.ent.ti.com> <CAFqH_52ARf44fWOP9HBwfS=AjoNm2MfEMyBBAJ7KDJO+xLPGfw@mail.gmail.com> <20131202165103.726314d9@skate>	<529CAEA3.2080808@ti.com> <20131202170606.2191fd89@skate> <20980858CB6D3A4BAE95CA194937D5E73EA50A23@DBDE04.ent.ti.com> <20131202171907.56c9300a@skate> <20980858CB6D3A4BAE95CA194937D5E73EA50AA4@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47050 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868Ab3LBRZP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Dec 2013 12:25:15 -0500
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA50AA4@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Javier Martinez Canillas (javier@dowhile0.org)" <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, =?ISO-8859-1?Q?Beno=EEt_Co?= =?ISO-8859-1?Q?usson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "Scott Wood (scottwood@freescale.com)" <scottwood@freescale.com>

On 12/02/2013 12:05 PM, Gupta, Pekon wrote:
>> From: Thomas Petazzoni [mailto:thomas.petazzoni@free-electrons.com]
>> Dear Gupta, Pekon,
>>
>> On Mon, 2 Dec 2013 16:13:56 +0000, Gupta, Pekon wrote:
>>
>>> Yes, at-least OMAP3 arch u-boot should still supports 'nandecc'.
>>> The infrastructure is still in place, however the command 'nandecc' is
>>> deprecated in newer versions.
>>> References in mainline u-boot:
>>> arch/arm/cpu/armv7/omap3/board.c  @@do_switch_ecc()
>>> driver/mtd/nand/omap_gpmc.c @@omap_nand_switch_ecc()
>>>
>>> So with minor hacks, you should be able to bring-back 'nandecc'.
>>
>> So in short, what it means is that indeed the fact of switching to BCH8
>> on the kernel side is really breaking things, because U-Boot users now
>> have the choice between:
>>
>> * Configuring U-Boot to use Hamming ECC, and be able to reflash their
>>   SPL, but not their filesystem images.
>>
>> * Configuring U-Boot to use BCH8, and be able to reflash their
>>   filesystem images, but not their SPL.
>>
>> Seems a little bit annoying for users, no?
>>
> Yes, agree ..
> But this is only because we have mis-match in ecc-scheme between
> ROM-code (while reading SPL) v/s  rest of system.
> However, if you continue using 'HAM1' for *both* u-boot and kernel
> you should not face any issue. And with latest patch on u-boot
> your board file should also remain unchanged.

I'm sorry, this is wrong.  When the hardware says you MUST use BCH8 or
more for a given chip using HAM1 you will have issues.  And chips that
say you must use BCH4/8/16 are why we get into this issue.

-- 
Tom
