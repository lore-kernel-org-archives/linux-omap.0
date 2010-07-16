From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Re: Omap3 omap3_clk_lock_dpll5() problem
Date: Fri, 16 Jul 2010 14:53:15 +0200
Message-ID: <AANLkTim9fOR4G6zpvzNApHS0uW9c5zgmFKJ7IxMC6_2W@mail.gmail.com>
References: <AANLkTinHudaXyhk3qc1sFydzZaGs3PZKW6DObw_acxOc@mail.gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323A2C8DE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53381 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965374Ab0GPMxR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jul 2010 08:53:17 -0400
Received: by bwz1 with SMTP id 1so1201131bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Jul 2010 05:53:16 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C8DE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2010/7/16 Gadiyar, Anand <gadiyar@ti.com>:
> Arno Steffen wrote:
>>
>> I do have some messages while booting a 2.6.33 kernel:
>>
>> What does this mean? How can I get rid of it?
>> What is omap3_clk_lock_dpll5() =A0doing and what if I comment it out=
? I
>> guess it make some sense ;)
>>
>
> Not sure why you have this issue - I'll have to dig a bit, or maybe o=
ther
> people can comment. But I can tell =A0you what this function is for.
>
> DPLL5 is used to supply a 120 MHz clock to the USBTLL and the USBHOST
> modules. You need this if you are going to use the OMAP's EHCI contro=
ller
> on your board.
>
> 120 MHz is the recommended frequency for this DPLL and it is not
> recommended to use any other frequency for normal usage. Hence
> We lock the DPLL to this frequency at bootup, so that later the
> driver can simply do a clk_enable() on the clock it needs and they
> will be at this frequency.
>
> - Anand
>

Thanks Anand,
I don't have any USB working on the board.
If this only for this USB - is it save to comment that out?

I do have some trouble with mounting my flash partition. Sometimes I
get "uncorrectable errors" (issued by nand_ecc.c) which are disappear
in the next boot. The flash is mounted ro, so it should always have
the same content.
And now I dig around - as I am not sure whether I do have a Flash or a
RAM problem or a configuration issue
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
