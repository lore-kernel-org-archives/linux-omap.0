From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH] OMAP: McSPI: Fix RX DMA transfer path
Date: Thu, 18 Jun 2009 15:26:21 +0300
Message-ID: <87fxdx918y.fsf@litku.valot.fi>
References: <1244809910-4014-1-git-send-email-aaro.koskinen@nokia.com>
	<877hzgnl8l.fsf@litku.valot.fi> <20090615073310.GA4474@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f212.google.com ([209.85.220.212]:63174 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbZFRM0W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 08:26:22 -0400
Received: by fxm8 with SMTP id 8so996438fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 05:26:24 -0700 (PDT)
In-Reply-To: <20090615073310.GA4474@atomide.com> (Tony Lindgren's message of "Mon\, 15 Jun 2009 00\:33\:12 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Tony Lindgren <tony@atomide.com> writes:

>> I will test this patch as soon as I get N800 boot with latest
>> linux-omap, now I only get this:
>>=20
>> <6>JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Hat, In=
c.
>> <6>JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red H
>> <6>msgmni has been set to 247
>> <6>io scheduler noop registered (default)
>> <6>omapfb: ls041y3 rev 87 LCD detected, 0 data lines      d
>> <6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
>> <6>serial8250.0: ttyS1 at MMIO 0x4806e000 (irq =3D 74) is a ST16654
>> <=F3"F:=AD5 #!*$=D5<=F3=AC#0=AD5 #!*$=D5<=F3=ADr%
>> =B5=B2=B2 =E62=D5<=F3$=B6=A0#=AE*#5##=B9'%=D5<=F3#62=B0$=B6=A0=B9)K!=
=A5=BA=B9'=D5<=F3=AC=B95 K#z=A00=AB=B2)=D1%f=A1T:6=E60=AA=FF<=F3=AF
>> =F3
>> %=B0=F62=AD=D5=B3#=B2=A9T=A0=F4=AD#.#=C9=A0,=AD#2=AC#=A3=B50V=B3/=AD=
5 V=A7=CD#%R=ED<=F300=A2F=A0=F4-=A0=B9##=A3$=B6=A0+3S=ED<=F3
>> 0
>> =B7#
>>   # V60=B1:)=A5#
>> ,#=B5=A5=D546=A0V#=D5#
>> =AC=E9)=B6.=B9=AA=FF<=F3=B5&=A3=C9%=B2:=A9F%V$=AE=BA=A0=B9##=A3$=B6
>> =A0=CD#=C9=A1*=AA=FF<=F3=B5&=A0                           =A9#=AD0=C1=
:=A3=B5=AD.#=B5=A5=D54#=D4#K=AA=FF#=F3#=CD!=C4)
>>  %
>> =B33{%=B0=F62=AD=B19=B1S=ED<=F3"=D5=A0{/+#=ED#=F3#=CD!=C4)4?+#=ED#=F3=
#=CD!=C4)4=F3=A0=F6=A3U4=AC=B9=A0=B9)K!)=BA"=AA=FF<=F3"=D5%{/C:=B3=F4
>> =D9=AF    s
>> =AE=D1=A0=AE=AE=D2 335<#U2,=B0=AE!=C4)=A0=A0=F42V#"=F6/=EB"=A2#4/##=AE=
#%!V C%!
>
> Might be related to the omap specific ATAGs now gone, sorry but that
> just had to go to get things in sync. And it should not come as a
> surprise as it's been discussed over past few years :)

Yeah, I understand. Better do it properly, it will get easier soon.

> The missing data needs to be initialized in platform_data, cmdline,
> ARM generic ATAGs, upcoming device tree.. I suggest using platform_da=
ta
> where possible. The GPIO values etc coming from nolo can be dumped
> with some earlier kernel using CONFIG_ATAGS_PROC.

Thanks for the help, all hints are greatly appreciated. And as soon as =
I
manage to finish a personal project of mine I'll start looking at this
in detail.

> BTW, I'll move the n8x0 board-*.c files around a bit to have just
> board-n800.c, board-n810.c and board-n8x0-peripherals.c.

Sounds good.

--=20
Kalle Valo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
